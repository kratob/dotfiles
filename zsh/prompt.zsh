autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_prompt() {
  local git_dir branch state st info merge_branch
  state=""
  git_dir=$(/usr/bin/git rev-parse --git-dir 2> /dev/null) || return

  if test -d "$git_dir/rebase-apply"; then
    if test -f "$git_dir/rebase-apply/rebasing"; then
      state="rebase"
    elif test -f "$git_dir/rebase-apply/applying"; then
      state="am"
    else
      state="am/rebase"
    fi
    branch="$(cat $git_dir/rebase-apply/head-name 2>/dev/null)"
  elif test -f "$git_dir/rebase-merge/interactive"; then
    state="rebase -i"
    branch="$(cat "$git_dir/rebase-merge/head-name")"
  elif test -d "$git_dir/rebase-merge"; then
    state="rebase -m"
    branch="$(cat "$git_dir/rebase-merge/head-name")"
  elif test -f "$git_dir/MERGE_HEAD"; then
    merge_branch="$(git describe `cat $git_dir/MERGE_HEAD` --all 2>/dev/null)"
    state="merge with ${merge_branch#heads/}"
    branch="$(git symbolic-ref HEAD 2>/dev/null)"
  else
    if test -f "$git_dir/BISECT_LOG"; then
      state="bisect"
    fi
    branch="$(git symbolic-ref HEAD 2>/dev/null)" || \
      branch="$(git describe --exact-match HEAD 2>/dev/null)" || \
      branch="$(cut -c1-7 "$git_dir/HEAD")..."
  fi

  if [[ $state == "" ]] 
  then
    info="${branch#refs/heads/}"
  else
    info="${branch#refs/heads/} [$state]"
  fi

  st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "nothing to commit (working directory clean)" ]]
  then
    echo "on %{$fg_bold[green]%}$info%{$reset_color%}"
  else
    echo "on %{$fg_bold[red]%}$info%{$reset_color%}"
  fi
}


git_prompt_info () {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

local_ref () {
  /usr/bin/git show-ref $(git_branch) --heads --hash 2>/dev/null
}

remote_ref () {
  /usr/bin/git show-ref origin/$(git_branch) --hash 2>/dev/null
}

need_push () {
  if [[ $(local_ref) != $(remote_ref) ]]
  then
    echo "%{$fg_bold[cyan]%}(unpushed)%{$reset_color%}"
  fi
}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if $(which todo.sh &> /dev/null)
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

directory_name(){
  echo "%{$fg_bold[magenta]%}${PWD/#$HOME/~}%{$reset_color%}"
}


export PROMPT=$'\n$(directory_name) $(git_prompt) $(need_push)\n› '

set_prompt(){
  export RPROMPT="%{$fg[green]%}$(rvm-prompt 2>/dev/null)%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
