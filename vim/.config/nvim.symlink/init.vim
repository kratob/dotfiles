set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if exists("g:neovide")
  source ~/.gvimrc
  set guifont=MonoLisa:h12
  set mouse=a
end
