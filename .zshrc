# initialization
autoload -U compinit; compinit
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# environment variables
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export XDG_CONFIG_HOME="$HOME/.config/"
export DOCKER_HOST="unix:///var/run/docker.sock"
export CHROOT="$HOME/chroot/"
export TMPDIR="/tmp/"
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.lmstudio/bin:$HOME/.rive/bin:$PATH"
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export PNPM_HOME='/home/iliya/.local/share/pnpm'
case ":$PATH:" in
  ":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh";
if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

# appearance
PS1='%F{white}%m %F{green}%d %F{cyan}λ %f'
ZSH_THEME="terminalparty"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

# history
HIST_SIZE=2000
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# bindings
bindkey -e
setopt autocd extendedglob nomatch
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion
zstyle :compinstall filename '/home/iliya/.zshrc'
zstyle ':completion:*:*:cp:*' file-sort size
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' verbose yes
zstyle ':completion:*' complete-options true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7
zmodload zsh/complist

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias isonow='date -u +"%Y-%m-%dT%H:%M:%S"Z'
alias upd='doas pacman -Syyu --noconfirm --needed'
alias updsh='doas pacman -Syyu --noconfirm --needed && shutdown now'
alias zshconfig='nvim ~/.zshrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'
alias fucking='doas'
alias fuckthis='doas shutdown now'
alias brew='paru'
alias ge='WINEFSYNC=1 WINEPREFIX="$HOME/.steam/steam/steamapps/compatdata/999999999/pfx/" "$HOME/.steam/steam/compatibilitytools.d/GE-Proton10-25/files/bin/wine"'
alias gel='SteamDeck=1 PROTON_ENABLE_WAYLAND=1 WINEFSYNC=1 WINEPREFIX="$HOME/.steam/steam/steamapps/compatdata/999999999/pfx/" "$HOME/.steam/steam/compatibilitytools.d/Proton-GE Latest/files/bin/wine"'
alias gex='WINEFSYNC=1 WINEPREFIX="$HOME/.steam/steam/steamapps/compatdata/999999999/pfx/" gamescope -W 2560 -H 1080 -S stretch -f --force-grab-cursor -- "$HOME/.steam/steam/compatibilitytools.d/Proton-GE Latest/files/bin/wine"'

# functions
ffcompress() {
  local input_file="$1"
  local output_file="${input_file%.*}_comp.${input_file##*.}"
  ffmpeg -y -v verbose -i "$input_file" -c:v libx265 -crf 30 -c:a copy "$output_file"
}
ffuncompress() {
  local input_file="$1"
  local output_file="${input_file%.*}_uncomp.mov"
  ffmpeg -y -v verbose -i "$input_file" -c:v dnxhd -b:v 185M -c:a pcm_s16le -b:a 128k "$output_file"
}

