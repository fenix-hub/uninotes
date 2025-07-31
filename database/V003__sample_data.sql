-- Sample data for UniNotes database
-- This file populates the database with realistic sample data for development and testing

-- First, let's create some sample users in auth.users (this would normally be handled by Supabase Auth)
-- Note: In production, users are created through Supabase Auth, but for development we can insert sample data

-- Sample user profiles
INSERT INTO uninotes.user_profiles (id, username, full_name, university, major, graduation_year, bio, is_public) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'marco_rossi', 'Marco Rossi', 'Università di Milano', 'Informatica', 2025, 'Studente di informatica appassionato di AI e machine learning. Sempre disponibile per collaborazioni!', true),
('550e8400-e29b-41d4-a716-446655440002', 'giulia_bianchi', 'Giulia Bianchi', 'Università Bocconi', 'Economia', 2024, 'Studentessa di economia con focus sulla finanza digitale e startup.', true),
('550e8400-e29b-41d4-a716-446655440003', 'luca_ferrari', 'Luca Ferrari', 'Politecnico di Milano', 'Ingegneria Informatica', 2026, 'Futuro ingegnere informatico, appassionato di robotica e IoT.', true),
('550e8400-e29b-41d4-a716-446655440004', 'sara_conti', 'Sara Conti', 'Università di Roma La Sapienza', 'Medicina', 2023, 'Studentessa di medicina al quinto anno, specializzanda in neurologia.', false),
('550e8400-e29b-41d4-a716-446655440005', 'andrea_russo', 'Andrea Russo', 'Università di Torino', 'Fisica', 2025, 'Studente di fisica teorica, interessato alla fisica quantistica.', true);

-- Sample notes with realistic content
INSERT INTO uninotes.notes (id, title, content, subject, course_code, professor, academic_year, semester, tags, status, is_public, user_id) VALUES
-- Marco's notes (Informatica)
('660e8400-e29b-41d4-a716-446655440001', 'Algoritmi di Ordinamento', 
'# Algoritmi di Ordinamento

## Bubble Sort
- Complessità: O(n²)
- Algoritmo semplice ma inefficiente
- Confronta elementi adiacenti

## Quick Sort  
- Complessità media: O(n log n)
- Divide et impera
- Pivot selection strategy

## Merge Sort
- Complessità: O(n log n) garantita
- Stabile e predicibile
- Richiede spazio aggiuntivo O(n)', 
'Algoritmi e Strutture Dati', 'CS101', 'Prof. Giovanni Alberti', '2024/2025', 'Primo Semestre', 
ARRAY['algoritmi', 'ordinamento', 'complessità', 'informatica'], 'published', true, '550e8400-e29b-41d4-a716-446655440001'),

('660e8400-e29b-41d4-a716-446655440002', 'Introduzione al Machine Learning',
'# Machine Learning Basics

## Tipi di Apprendimento
1. **Supervised Learning**: Abbiamo esempi etichettati
2. **Unsupervised Learning**: Cerchiamo pattern nei dati
3. **Reinforcement Learning**: Apprendiamo attraverso reward/punishment

## Algoritmi Fondamentali
- Linear Regression
- Decision Trees
- Neural Networks
- SVM (Support Vector Machines)

## Overfitting e Underfitting
- **Overfitting**: Il modello memorizza i dati di training
- **Underfitting**: Il modello è troppo semplice
- Soluzione: Cross-validation, Regularization',
'Machine Learning', 'CS201', 'Prof. Maria Verdi', '2024/2025', 'Secondo Semestre',
ARRAY['ml', 'ai', 'supervised', 'unsupervised', 'neural-networks'], 'published', true, '550e8400-e29b-41d4-a716-446655440001'),

-- Giulia's notes (Economia)
('660e8400-e29b-41d4-a716-446655440003', 'Microeconomia: Teoria del Consumatore',
'# Teoria del Consumatore

## Preferenze del Consumatore
- **Assiomi delle preferenze**: Completezza, Transitività, Monotonia
- **Curve di indifferenza**: Rappresentano combinazioni di beni che danno la stessa utilità
- **Saggio marginale di sostituzione**: Quanto il consumatore è disposto a rinunciare di un bene per ottenere un\'unità dell\'altro

## Vincolo di Bilancio
- Retta di bilancio: px·x + py·y = m
- Dove m è il reddito, px e py sono i prezzi

## Scelta Ottima
- Punto di tangenza tra curva di indifferenza e vincolo di bilancio
- Condizione: SMS = px/py',
'Microeconomia', 'ECON101', 'Prof. Roberto Neri', '2024/2025', 'Primo Semestre',
ARRAY['microeconomia', 'consumatore', 'utilità', 'preferenze'], 'published', true, '550e8400-e29b-41d4-a716-446655440002'),

('660e8400-e29b-41d4-a716-446655440004', 'Analisi degli Investimenti',
'# Analisi degli Investimenti

## Metodi di Valutazione
1. **VAN (Valore Attuale Netto)**
   - VAN = Σ(Flussi di Cassa / (1+r)^t) - Investimento Iniziale
   - Se VAN > 0, investimento conveniente

2. **TIR (Tasso Interno di Rendimento)**
   - Tasso che rende VAN = 0
   - Confrontare con costo del capitale

3. **Payback Period**
   - Tempo necessario per recuperare l\'investimento
   - Semplice ma ignora valore temporale del denaro

## Criteri di Scelta
- Progetti indipendenti: VAN > 0
- Progetti mutuamente esclusivi: VAN maggiore
- Considerare sempre il rischio!',
'Finanza Aziendale', 'FIN201', 'Prof. Elena Marchetti', '2024/2025', 'Secondo Semestre',
ARRAY['finanza', 'investimenti', 'van', 'tir', 'valutazione'], 'published', true, '550e8400-e29b-41d4-a716-446655440002'),

-- Luca's notes (Ingegneria)
('660e8400-e29b-41d4-a716-446655440005', 'Sistemi Embedded e IoT',
'# Sistemi Embedded e Internet of Things

## Caratteristiche Sistemi Embedded
- **Real-time constraints**: Risposta entro tempo determinato
- **Risorse limitate**: CPU, memoria, energia
- **Affidabilità**: Funzionamento continuo richiesto

## Architetture IoT
1. **Device Layer**: Sensori, attuatori, microcontrollori
2. **Connectivity Layer**: WiFi, Bluetooth, LoRaWAN, 5G
3. **Data Processing**: Edge computing, Cloud computing
4. **Application Layer**: Dashboard, mobile apps

## Protocolli di Comunicazione
- **MQTT**: Lightweight, publish-subscribe
- **CoAP**: RESTful per dispositivi limitati  
- **HTTP**: Standard web, più pesante
- **WebSocket**: Comunicazione bidirezionale

## Sicurezza IoT
- Autenticazione dispositivi
- Cifratura dati
- Aggiornamenti sicuri (OTA)',
'Sistemi Embedded', 'ENG301', 'Prof. Francesco Galli', '2024/2025', 'Primo Semestre',
ARRAY['embedded', 'iot', 'mqtt', 'sicurezza', 'protocolli'], 'published', true, '550e8400-e29b-41d4-a716-446655440003'),

-- Sara's notes (Medicina) - private
('660e8400-e29b-41d4-a716-446655440006', 'Neuroanatomia: Sistema Nervoso Centrale',
'# Sistema Nervoso Centrale

## Encefalo
### Telencefalo
- **Corteccia cerebrale**: Sostanza grigia, neuroni
- **Sostanza bianca**: Assoni mielinizzati
- **Nuclei della base**: Controllo movimento

### Diencefalo  
- **Talamo**: Stazione di relay sensoriale
- **Ipotalamo**: Controllo endocrino e autonomo
- **Ipofisi**: Ghiandola endocrina principale

## Midollo Spinale
- **Sostanza grigia**: Corpo cellulare neuroni
- **Sostanza bianca**: Vie ascendenti e discendenti
- **Riflessi spinali**: Arco riflesso monosinaptico

## Liquido Cerebrospinale
- Prodotto dai plessi coroidei
- Circolazione: Ventricoli → Spazio subaracnoideo
- Funzioni: Protezione, nutrizione, rimozione metaboliti',
'Neuroanatomia', 'MED301', 'Prof. Carla Fontana', '2024/2025', 'Primo Semestre',
ARRAY['neuroanatomia', 'encefalo', 'midollo', 'neurologia'], 'draft', false, '550e8400-e29b-41d4-a716-446655440004'),

-- Andrea's notes (Fisica)
('660e8400-e29b-41d4-a716-446655440007', 'Meccanica Quantistica: Principi Fondamentali',
'# Meccanica Quantistica

## Postulati della MQ
1. **Stato**: Descritto da funzione d\'onda ψ(x,t)
2. **Osservabili**: Operatori hermitiani
3. **Misura**: Valor medio = ⟨ψ|Â|ψ⟩
4. **Evoluzione**: Equazione di Schrödinger

## Equazione di Schrödinger
### Indipendente dal tempo
Ĥψ = Eψ

### Dipendente dal tempo  
iℏ ∂ψ/∂t = Ĥψ

## Principi Fondamentali
- **Principio di indeterminazione**: ΔxΔp ≥ ℏ/2
- **Dualità onda-particella**: Natura complementare
- **Sovrapposizione**: ψ = c₁ψ₁ + c₂ψ₂
- **Entanglement**: Correlazioni quantistiche

## Interpretazioni
- **Copenhagen**: Collasso della funzione d\'onda
- **Many-worlds**: Multiverso quantistico
- **De Broglie-Bohm**: Variabili nascoste',
'Meccanica Quantistica', 'PHYS301', 'Prof. Alessandro Ricci', '2024/2025', 'Secondo Semestre',
ARRAY['quantistica', 'schrödinger', 'postulati', 'indeterminazione'], 'published', true, '550e8400-e29b-41d4-a716-446655440005');

-- Sample note files
INSERT INTO uninotes.note_files (id, note_id, file_name, file_path, file_size, file_type, mime_type, is_primary, user_id) VALUES
('770e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', 'algoritmi_ordinamento.pdf', 'notes/algoritmi_ordinamento.pdf', 2048576, 'pdf', 'application/pdf', true, '550e8400-e29b-41d4-a716-446655440001'),
('770e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440002', 'ml_slides.pdf', 'notes/ml_slides.pdf', 5242880, 'pdf', 'application/pdf', true, '550e8400-e29b-41d4-a716-446655440001'),
('770e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440003', 'microeconomia_grafici.pdf', 'notes/microeconomia_grafici.pdf', 1536000, 'pdf', 'application/pdf', true, '550e8400-e29b-41d4-a716-446655440002'),
('770e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440005', 'iot_schema.png', 'notes/iot_schema.png', 512000, 'image', 'image/png', false, '550e8400-e29b-41d4-a716-446655440003'),
('770e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440007', 'quantum_equations.pdf', 'notes/quantum_equations.pdf', 3145728, 'pdf', 'application/pdf', true, '550e8400-e29b-41d4-a716-446655440005');

-- Sample note shares (collaborazioni tra studenti)
INSERT INTO uninotes.note_shares (id, note_id, shared_by, shared_with, permission_level) VALUES
-- Marco condivide i suoi appunti di ML con Luca
('880e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003', 'read'),
-- Giulia condivide microeconomia con Marco (scambio di appunti tra facoltà diverse)
('880e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'read'),
-- Luca condivide IoT con Marco (entrambi informatica/ingegneria)
('880e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', 'write');

-- Sample favorites (appunti salvati come preferiti)
INSERT INTO uninotes.note_favorites (id, note_id, user_id) VALUES
-- Marco salva come preferiti gli appunti di microeconomia di Giulia
('990e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001'),
-- Giulia salva come preferiti gli appunti di ML di Marco  
('990e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002'),
-- Luca salva come preferiti gli algoritmi di Marco
('990e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003'),
-- Andrea salva come preferiti ML e IoT (fisico interessato alla tecnologia)
('990e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440005'),
('990e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440005');

-- Additional notes for more variety
INSERT INTO uninotes.notes (id, title, content, subject, course_code, professor, academic_year, semester, tags, status, is_public, user_id) VALUES
-- More CS notes
('660e8400-e29b-41d4-a716-446655440008', 'Database: Modello Relazionale',
'# Modello Relazionale

## Concetti Base
- **Relazione**: Tabella con righe (tuple) e colonne (attributi)
- **Chiave Primaria**: Identifica univocamente ogni tupla
- **Chiave Esterna**: Riferimento a chiave primaria di altra relazione

## Normalizzazione
1. **1NF**: Attributi atomici
2. **2NF**: Eliminare dipendenze parziali
3. **3NF**: Eliminare dipendenze transitive
4. **BCNF**: Forma normale di Boyce-Codd

## SQL Queries
```sql
SELECT * FROM students 
WHERE major = "Computer Science"
ORDER BY gpa DESC;
```',
'Database', 'CS201', 'Prof. Luigi Bianchi', '2024/2025', 'Primo Semestre',
ARRAY['database', 'sql', 'relazionale', 'normalizzazione'], 'published', true, '550e8400-e29b-41d4-a716-446655440001'),

-- Economics advanced
('660e8400-e29b-41d4-a716-446655440009', 'Macroeconomia: Modello IS-LM',
'# Modello IS-LM

## Curva IS (Investment-Saving)
- Rappresenta equilibrio nel mercato dei beni
- Relazione negativa tra tasso di interesse e reddito
- Y = C + I + G, dove I dipende negativamente da r

## Curva LM (Liquidity-Money)  
- Rappresenta equilibrio nel mercato monetario
- Relazione positiva tra tasso di interesse e reddito
- M/P = L(Y,r), domanda di moneta

## Equilibrio Generale
- Intersezione IS-LM determina Y* e r*
- Politica fiscale: spostamento IS
- Politica monetaria: spostamento LM

## Trappola della Liquidità
- LM orizzontale a tasso molto basso
- Politica monetaria inefficace
- Solo politica fiscale espansiva funziona',
'Macroeconomia', 'ECON201', 'Prof. Marco Pellegrini', '2024/2025', 'Secondo Semestre',
ARRAY['macroeconomia', 'is-lm', 'politica-monetaria', 'equilibrio'], 'published', true, '550e8400-e29b-41d4-a716-446655440002'),

-- Engineering advanced
('660e8400-e29b-41d4-a716-446655440010', 'Reti di Calcolatori: Protocolli TCP/IP',
'# Stack TCP/IP

## Livelli del Modello
1. **Application Layer**: HTTP, FTP, SMTP, DNS
2. **Transport Layer**: TCP, UDP
3. **Internet Layer**: IP, ICMP, ARP
4. **Network Access**: Ethernet, WiFi

## Protocollo TCP
- **Connection-oriented**: Handshake a 3 vie
- **Reliable**: ACK, retransmission, checksums
- **Flow control**: Sliding window
- **Congestion control**: Slow start, congestion avoidance

## Protocollo IP
- **Best effort**: No guarantees
- **Routing**: Tabelle di routing, algoritmi
- **Addressing**: IPv4 (32-bit), IPv6 (128-bit)

## DNS (Domain Name System)
- Traduce nomi in indirizzi IP
- Gerarchia: Root → TLD → Authoritative
- Caching per performance',
'Reti di Calcolatori', 'ENG201', 'Prof. Stefano Ricci', '2024/2025', 'Primo Semestre',
ARRAY['reti', 'tcp-ip', 'protocolli', 'networking'], 'published', true, '550e8400-e29b-41d4-a716-446655440003');

-- Update search vectors for all notes (this would normally be done by the trigger)
UPDATE uninotes.notes SET updated_at = NOW() WHERE id IN (
    '660e8400-e29b-41d4-a716-446655440008',
    '660e8400-e29b-41d4-a716-446655440009', 
    '660e8400-e29b-41d4-a716-446655440010'
);

-- Add some draft notes (work in progress)
INSERT INTO uninotes.notes (id, title, content, subject, course_code, professor, academic_year, semester, tags, status, is_public, user_id) VALUES
('660e8400-e29b-41d4-a716-446655440011', 'Sistemi Operativi: Scheduling - WIP',
'# Scheduling dei Processi

## Round Robin
- Time quantum fisso
- Preemptive
- Fair ma non ottimale per response time

## TODO:
- [ ] Completare Shortest Job First
- [ ] Aggiungere Priority Scheduling
- [ ] Esempi pratici
- [ ] Confronto performance',
'Sistemi Operativi', 'CS301', 'Prof. Anna Moretti', '2024/2025', 'Secondo Semestre',
ARRAY['sistemi-operativi', 'scheduling', 'processi'], 'draft', false, '550e8400-e29b-41d4-a716-446655440001'),

('660e8400-e29b-41d4-a716-446655440012', 'Analisi Matematica: Derivate - Bozza',
'# Derivate

## Definizione
Il limite del rapporto incrementale:
f\'(x) = lim[h→0] (f(x+h) - f(x))/h

## Regole di Derivazione
- (x^n)\' = nx^(n-1)
- (sin x)\' = cos x
- (cos x)\' = -sin x

## TODO da completare:
- Regola della catena
- Derivate composte  
- Applicazioni geometriche
- Esercizi svolti',
'Analisi Matematica', 'MATH101', 'Prof. Giuseppe Villa', '2024/2025', 'Primo Semestre',
ARRAY['matematica', 'derivate', 'analisi', 'calcolo'], 'draft', false, '550e8400-e29b-41d4-a716-446655440005');
