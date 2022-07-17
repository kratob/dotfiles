find-up() {
  path=$(pwd)
  while [[ "$path" != "" && ! -e "$path/$1" ]]; do
    path=${path%/*}
  done
  echo "$path"
}

automatic-nvm-use() {
  NVM_PATH=$(find-up .nvmrc | tr -d '[:space:]')

  if [[ $NVM_PATH == $NVM_PATH_WAS ]]; then
    return
  fi

  NVM_PATH_WAS=$NVM_PATH

  if [[ -f "$NVM_PATH/.nvmrc" ]]; then
    nvm use $(<"$NVM_PATH/.nvmrc")
  else
    nvm use default
  fi
}

[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions automatic-nvm-use)
