# Setup fzf
# ---------
if [[ ! "$PATH" == */home/niklas/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/niklas/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/niklas/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/niklas/.fzf/shell/key-bindings.zsh"
