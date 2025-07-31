-- Create storage buckets
INSERT INTO storage.buckets (id, name, public) 
VALUES 
    ('note-files', 'note-files', false),
    ('note-images', 'note-images', false),
    ('profile-avatars', 'profile-avatars', true);

-- Storage policies for note-files bucket
CREATE POLICY "Users can view files for accessible notes" ON storage.objects
    FOR SELECT USING (
        bucket_id = 'note-files' AND
        (storage.foldername(name))[1] IN (
            SELECT n.id::text FROM uninotes.notes n
            WHERE n.user_id = auth.uid()
               OR n.is_public = true
               OR n.id IN (
                   SELECT ns.note_id FROM uninotes.note_shares ns
                   WHERE ns.shared_with = auth.uid()
               )
        )
    );

CREATE POLICY "Users can upload files to their note folders" ON storage.objects
    FOR INSERT WITH CHECK (
        bucket_id = 'note-files' AND
        (storage.foldername(name))[1] IN (
            SELECT n.id::text FROM uninotes.notes n
            WHERE n.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update their note files" ON storage.objects
    FOR UPDATE USING (
        bucket_id = 'note-files' AND
        (storage.foldername(name))[1] IN (
            SELECT n.id::text FROM uninotes.notes n
            WHERE n.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete their note files" ON storage.objects
    FOR DELETE USING (
        bucket_id = 'note-files' AND
        (storage.foldername(name))[1] IN (
            SELECT n.id::text FROM uninotes.notes n
            WHERE n.user_id = auth.uid()
        )
    );

-- Storage policies for note-images bucket
CREATE POLICY "Anyone can view public note images" ON storage.objects
    FOR SELECT USING (bucket_id = 'note-images');

CREATE POLICY "Users can upload note images" ON storage.objects
    FOR INSERT WITH CHECK (
        bucket_id = 'note-images' AND
        auth.uid()::text = (storage.foldername(name))[1]
    );

-- Storage policies for profile-avatars bucket (public bucket)
CREATE POLICY "Anyone can view avatars" ON storage.objects
    FOR SELECT USING (bucket_id = 'profile-avatars');

CREATE POLICY "Users can upload their own avatar" ON storage.objects
    FOR INSERT WITH CHECK (
        bucket_id = 'profile-avatars' AND
        auth.uid()::text = (storage.foldername(name))[1]
    );

CREATE POLICY "Users can update their own avatar" ON storage.objects
    FOR UPDATE USING (
        bucket_id = 'profile-avatars' AND
        auth.uid()::text = (storage.foldername(name))[1]
    );
