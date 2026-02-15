# initialization
autoload -U compinit; compinit

# environment variables
export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export XDG_CONFIG_HOME="$HOME/.config/"
export TMPDIR="/tmp/"
export PATH="$PATH:/home/iliya/.lmstudio/bin"
export PATH="$PATH:/home/iliya/.dotnet/tools"
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# shell integration
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# appearance
PS1='%F{white}%m %F{green}%d %F{cyan}%# %f'
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

# plugins
plugins=(git)

# aliases
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

# functions
ffcompress() {
  local input_file="$1"
  local output_file="${input_file%.*}_comp.${input_file##*.}"

  ffmpeg -y -v verbose -i "$input_file" -c:v libx265 -crf 30 -c:a copy "$output_file"
}
