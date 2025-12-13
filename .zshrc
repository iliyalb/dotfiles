autoload -Uz compinit

export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export TMPDIR="/tmp/"
export PATH="$PATH:/home/iliya/.lmstudio/bin"
export PATH="$PATH:/home/iliya/.dotnet/tools"

PS1='%F{white}%m %F{green}%d %F{cyan}%# %f'
ZSH_THEME="terminalparty"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
HIST_SIZE=2000
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

compinit
bindkey -e
setopt autocd extendedglob nomatch
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
zstyle :compinstall filename '/home/iliya/.zshrc'
zstyle ':omz:update' mode auto     
zstyle ':omz:update' frequency 7

plugins=(git)

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias isonow='date -u +"%Y-%m-%dT%H:%M:%S"Z'
alias upd='doas pacman -Syyu --noconfirm --needed'
alias updsh='doas pacman -Syyu --noconfirm --needed && shutdown now'
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias fucking="doas"
alias fuckthis="doas shutdown now"
alias brew="paru"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

ffcompress() {
  local input_file="$1"
  local output_file="${input_file%.*}_comp.${input_file##*.}"

  ffmpeg -y -v verbose -i "$input_file" -c:v libx265 -crf 30 -c:a copy "$output_file"
}
