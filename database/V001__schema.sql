-- Create Schema
CREATE SCHEMA IF NOT EXISTS uninotes;

-- Create custom types
CREATE TYPE uninotes.note_status AS ENUM ('draft', 'published', 'archived');
CREATE TYPE uninotes.file_type AS ENUM ('pdf', 'docx', 'txt', 'md', 'image', 'audio', 'video');

-- Notes table
CREATE TABLE uninotes.notes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    subject VARCHAR(100) NOT NULL,
    course_code VARCHAR(20),
    professor VARCHAR(100),
    academic_year VARCHAR(10),
    semester VARCHAR(20),
    tags TEXT[], -- Array of tags
    status uninotes.note_status DEFAULT 'draft',
    is_public BOOLEAN DEFAULT FALSE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    search_vector tsvector
);

-- Funzione trigger per aggiornare il search_vector
CREATE OR REPLACE FUNCTION update_search_vector()
RETURNS trigger AS $$
BEGIN
  NEW.search_vector :=
    setweight(to_tsvector('english', COALESCE(NEW.title, '')), 'A') ||
    setweight(to_tsvector('english', COALESCE(NEW.content, '')), 'B') ||
    setweight(to_tsvector('english', COALESCE(NEW.subject, '')), 'C') ||
    setweight(to_tsvector('english', COALESCE(array_to_string(NEW.tags, ' '), '')), 'D');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger per update e insert
CREATE TRIGGER trg_update_search_vector
BEFORE INSERT OR UPDATE ON uninotes.notes
FOR EACH ROW EXECUTE FUNCTION update_search_vector();

-- Note files table uninotes.(for attachments stored in Supabase Storage)
CREATE TABLE uninotes.note_files (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    note_id UUID REFERENCES uninotes.notes(id) ON DELETE CASCADE,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500) NOT NULL, -- Path in Supabase Storage
    file_size BIGINT,
    file_type uninotes.file_type NOT NULL,
    mime_type VARCHAR(100),
    is_primary BOOLEAN DEFAULT FALSE, -- Main file for the note
    uploaded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE
);

-- Note sharing table
CREATE TABLE uninotes.note_shares (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    note_id UUID REFERENCES uninotes.notes(id) ON DELETE CASCADE,
    shared_by UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    shared_with UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    permission_level VARCHAR(20) DEFAULT 'read' CHECK (permission_level IN ('read', 'write', 'admin')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE(note_id, shared_with)
);

-- Note favorites table
CREATE TABLE uninotes.note_favorites (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    note_id UUID REFERENCES uninotes.notes(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE(note_id, user_id)
);

-- User profiles table
CREATE TABLE uninotes.user_profiles (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    full_name VARCHAR(100),
    university VARCHAR(100),
    major VARCHAR(100),
    graduation_year INTEGER,
    avatar_url VARCHAR(500),
    bio TEXT,
    is_public BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_notes_user_id ON uninotes.notes(user_id);
CREATE INDEX idx_notes_subject ON uninotes.notes(subject);
CREATE INDEX idx_notes_course_code ON uninotes.notes(course_code);
CREATE INDEX idx_notes_status ON uninotes.notes(status);
CREATE INDEX idx_notes_created_at ON uninotes.notes(created_at DESC);
CREATE INDEX idx_notes_search_vector ON uninotes.notes USING GIN(search_vector);
CREATE INDEX idx_notes_tags ON uninotes.notes USING GIN(tags);

CREATE INDEX idx_note_files_note_id ON uninotes.note_files(note_id);
CREATE INDEX idx_note_files_user_id ON uninotes.note_files(user_id);
CREATE INDEX idx_note_files_file_type ON uninotes.note_files(file_type);

CREATE INDEX idx_note_shares_note_id ON uninotes.note_shares(note_id);
CREATE INDEX idx_note_shares_shared_with ON uninotes.note_shares(shared_with);

CREATE INDEX idx_note_favorites_user_id ON uninotes.note_favorites(user_id);
CREATE INDEX idx_note_favorites_note_id ON uninotes.note_favorites(note_id);

-- Update timestamp trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_notes_updated_at 
    BEFORE UPDATE ON uninotes.notes 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_profiles_updated_at 
    BEFORE UPDATE ON uninotes.user_profiles 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Row Level Security policies
ALTER TABLE uninotes.notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE uninotes.note_files ENABLE ROW LEVEL SECURITY;
ALTER TABLE uninotes.note_shares ENABLE ROW LEVEL SECURITY;
ALTER TABLE uninotes.note_favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE uninotes.user_profiles ENABLE ROW LEVEL SECURITY;

-- Notes policies
CREATE POLICY "Users can view their own notes" ON uninotes.notes
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can view public notes" ON uninotes.notes
    FOR SELECT USING (is_public = true AND status = 'published');

CREATE POLICY "Users can view shared notes" ON uninotes.notes
    FOR SELECT USING (
        id IN (
            SELECT note_id FROM uninotes.note_shares 
            WHERE shared_with = auth.uid()
        )
    );

CREATE POLICY "Users can insert their own notes" ON uninotes.notes
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own notes" ON uninotes.notes
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own notes" ON uninotes.notes
    FOR DELETE USING (auth.uid() = user_id);

-- Note files policies
CREATE POLICY "Users can view files for accessible notes" ON uninotes.note_files
    FOR SELECT USING (
        note_id IN (
            SELECT id FROM uninotes.notes 
            WHERE user_id = auth.uid() 
               OR is_public = true 
               OR id IN (
                   SELECT note_id FROM uninotes.note_shares 
                   WHERE shared_with = auth.uid()
               )
        )
    );

CREATE POLICY "Users can insert files for their notes" ON uninotes.note_files
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own note files" ON uninotes.note_files
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own note files" ON uninotes.note_files
    FOR DELETE USING (auth.uid() = user_id);

-- User profiles policies
CREATE POLICY "Users can view public profiles" ON uninotes.user_profiles
    FOR SELECT USING (is_public = true);

CREATE POLICY "Users can view their own profile" ON uninotes.user_profiles
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON uninotes.user_profiles
    FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert their own profile" ON uninotes.user_profiles
    FOR INSERT WITH CHECK (auth.uid() = id);


-- Grants
GRANT USAGE ON SCHEMA uninotes TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA uninotes TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA uninotes TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA uninotes TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA uninotes GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA uninotes GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA uninotes GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;