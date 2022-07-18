set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if exists("g:neovide")
  source ~/.gvimrc
  set guifont=MonoLisa:h12
  set mouse=a
  let g:neovide_scroll_animation_length=0.1
end
