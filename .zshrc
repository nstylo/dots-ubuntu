#
# ~/.zshrc
#
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.config/i3blocks/scripts
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/bin/flac2mp3
export PATH=$PATH:~/.screenlayout
export PATH=$PATH:~/.local/share/neovim/bin
export OPENER=rifle
export EDITOR=nvim
export BROWSER=chromium
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
# JAVA
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
export PATH=$PATH:$JAVA_HOME/bin
# ANDROID
export ANDROID_HOME=$HOME/android
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# NODE
export PATH=$PATH:~/.npm-packages/bin
export PATH="$PATH:$(yarn global bin)"
# NIX
export PATH=$PATH:~/.nix-profile
# Bob (Nvim version manager)
export PATH=$PATH:~/.local/share/bob/nvim-bin
export SUDO_EDITOR=/home/niklas/.local/share/bob/nvim-bin/nvim

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

# rust zsh completion
fpath+=~/.zfunc

# asdf version manager
# source /opt/asdf-vm/asdf.sh

# install plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "plugins/rust", from:oh-my-zsh
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "kiurchv/asdf.plugin.zsh", defer:2
zplug "chisui/zsh-nix-shell"

# zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=magenta,bold'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# vim mode
bindkey -v
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

zstyle :compinstall filename '$HOME/.zshrc'

# autocomplete
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit
_comp_options+=(globdots)           # Include hidden files.


setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt extended_history
setopt complete_aliases

# aliases
alias la='ls --group-directories-first -a --color=auto'
alias ls='ls --group-directories-first --color=auto'
alias ll='ls --human-readable --group-directories-first -lh --color=auto'
alias lla='ll -a'
alias gs='git status'
alias gc='git commit'
alias gcb='git checkout -b'
alias ga='git add'
alias gps='git push'
alias gpl='git pull'
alias gl='git log --oneline'
alias gr='git reset'
alias grep='grep --color=auto'
alias shutdown='shutdown now'
alias suspend='systemctl suspend'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfg='config'
alias vim='nvim'
alias v='vim'
alias pac='sudo pacman'
alias r='ranger'
alias mkd='mkdir -pv'
alias cp='cp -i'
alias df='df -h'
alias du='du -h'
alias o='rifle'
alias t='touch'
alias ns='nix-shell --command zsh'

if [[ $TERM = "xterm-kitty" ]]; then
  alias ssh='TERM=xterm ssh'
fi

# z for fast navigation
# . /usr/share/z/z.sh
eval "$(zoxide init zsh)"

# fzf with fd for super fast fuzzy searching
export FZF_DEFAULT_COMMAND='rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor,Music}/*"'
export FZF_DEFAULT_OPTS="--ansi --layout reverse"
export FZF_CTRL_T_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
export FZF_CTRL_T_COMMAND='rg --files --hidden -g "!{.git}/*" 2> /dev/null'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey -r '\ec'


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# bun completions
[ -s "/home/niklas/.bun/_bun" ] && source "/home/niklas/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
