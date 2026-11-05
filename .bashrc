# Se la sessione non è interattiva, esci subito
[[ $- != *i* ]] && return

# Inizializzazione ble.sh (soltanto per sessioni interattive)
[[ -f /usr/share/blesh/ble.sh ]] && source /usr/share/blesh/ble.sh --noattach

# ==============================================================================
# CONFIGURAZIONE COLORI FILE (EZA / LS)
# Modifica i numeri (es. 32, 35) per cambiare colore o aggiungi nuove estensioni
# ==============================================================================
# Disattiva ruoli/sfumature di sistema di eza
RESET_RULES="im=0:sn=0:sb=0:da=0:uu=0:gu=0"

# IMMAGINI
IMG_COLORS="*.gif=33:*.jpg=32:*.jpeg=32:*.png=35:*.webp=36:*.svg=35"

# VIDEO E AUDIO
MEDIA_COLORS="*.mp4=31:*.mkv=31:*.avi=31:*.mp3=33:*.flac=33"

# ARCHIVI
ARCHIVE_COLORS="*.zip=31:*.tar=31:*.gz=31:*.7z=31"

# DOCUMENTI E TESTO
DOC_COLORS="*.txt=37:*.md=37:*.pdf=31"

# CODICE E SCRIPT
CODE_COLORS="*.sh=33:*.py=34:*.json=33:*.js=33:*.html=31:*.css=34"

# Unione di tutte le regole
export EZA_COLORS="${RESET_RULES}:${IMG_COLORS}:${MEDIA_COLORS}:${ARCHIVE_COLORS}:${DOC_COLORS}:${CODE_COLORS}"
export EXA_COLORS="$EZA_COLORS"
export LS_COLORS="$EZA_COLORS"

# Colori e utility
alias grep='grep --color=auto'
alias cat='bat'

# Eza (ls in colonna, ordinato per estensione, colori coerenti per tipo di file)
alias ls='eza -1 -s extension --icons=always --group-directories-first -I="Caz|fvm|hidapitester|Modelli|Musica|Pubblici|Video|Backup-KDE|"'
alias ll='eza -la --icons=always --group-directories-first'
cd() {
    builtin cd "$@" && ls
}

# Path
export PATH=$PATH:/home/liif/.spicetify

# Prompt minimale a due righe con riga vuota di separazione
PS1='\n\[\e[1;34m\]\w\[\e[0m\]\n\[\e[1;33m\]❯\[\e[0m\] '

# Fastfetch con immagine casuale e padding superiore
if [ -d "$HOME/Immagini/imp" ]; then
    RANDOM_IMG=$(find "$HOME/Immagini/imp/fastfetch_wallpapers" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)
    if [ -n "$RANDOM_IMG" ]; then
        fastfetch --logo-type kitty --logo "$RANDOM_IMG" --logo-width 28 --logo-height 12 --logo-padding-top 1
    else
        fastfetch
    fi
else
    fastfetch
fi

# Elenco file iniziale
ls

# Aggancio finale di ble.sh
[[ ${BLE_VERSION-} ]] && ble-attach