# Analisi umanitaria del conflitto in Ucraina (2022–2026)

## Autori

- **Nome gruppo / membri:** _inserire nomi e cognomi_
- **Affiliazione:** Università di Bologna — Corso di Utilizzo Statistico di Banche Dati Economiche Online

## Descrizione del progetto

Questo progetto analizza l’impatto umanitario del conflitto in Ucraina utilizzando i microdati forniti da **ACLED (Armed Conflict Location & Event Data Project)**.  
L’obiettivo è studiare:

- l’evoluzione temporale degli eventi bellici;
- la distribuzione geografica dei conflitti;
- l’esposizione della popolazione agli eventi violenti.

## Dati

- **Fonte:** ACLED
- **Copertura geografica:** Ucraina
- **Periodo di analisi:** dal 01/01/2022 al 01/01/2026
- **Modalità di accesso:** download tramite API REST con autenticazione OAuth2

## Sicurezza e credenziali

Per motivi di sicurezza, le credenziali API personali non sono incluse nel repository.  
Le variabili di autenticazione per l'accesso al sito ACLED devono essere salvate in un file locale `config.py`, 
escluso dal controllo di versione.

Il file deve contenere almeno:

- `USERNAME`
- `PASSWORD`

## Requisiti software

Per eseguire correttamente il progetto è necessario il seguente ambiente:

- **IDE:** Positron o RStudio
- **Linguaggio:** Python 3.x
- **Pacchetti Python:**
  - `requests` per le chiamate API
  - `pandas` per la gestione dei dati
  - `time` per la gestione delle attese tra le richieste
- **Controllo versione:** Git / GitHub

## Struttura del repository

Il progetto è organizzato nel modo seguente:

- `data/raw/` — contiene il dataset grezzo scaricato direttamente dall’API
- `data/processed/` — contiene il dataset pulito e ordinato, pronto per l’analisi
- `manuscript/` — contiene il file Quarto principale (`.qmd`) del progetto
- `config.py` — file locale con le credenziali API
- `.gitignore` — file di configurazione per Git. Contiene le istruzioni per ignorare i file sensibili.

## Riproducibilità

Per replicare l’intero flusso di lavoro:

1. Clonare il repository sul proprio computer.
2. Creare il file `config.py` nella directory principale e inserire le proprie credenziali ACLED (`USERNAME` e `PASSWORD`).
    In particolare: 
    - Nella directory principale del progetto, fai **clic destro** e seleziona **Nuovo file** (o *New File*).
    - Chiama il file esattamente `config.py` e premi Invio.
    - Apri il file appena creato e scrivi al suo interno le tue credenziali assegnandole alle relative variabili (ricordati di usare le virgolette):
    USERNAME = "la_tua_email@esempio.com"
    PASSWORD = "la_tua_password"
    - Salva e chiudi il file
3. Aprire il file "Analisi dei Conflitti.qmd" ed eseguire sia lo script per l'installazione dei pacchetti necessari che 
   lo script di download per scaricare automaticamente tutti gli eventi 
   relativi all’Ucraina e salvarli in `data/raw/`.
4. Eseguire lo script di data management per pulire, ordinare e salvare il dataset in `data/processed/`.

## Licenza

- **Codice:** MIT
- **Testo e dati:** CC-BY 4.0
