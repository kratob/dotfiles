bindkey -e

source ~/.zkbd/$TERM
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[C-Left]}"  ]]  && bindkey  "${key[C-Left]}"  emacs-backward-word
[[ -n "${key[C-Right]}"  ]]  && bindkey  "${key[C-Right]}"  emacs-forward-word

bindkey "^R" history-incremental-search-backward
