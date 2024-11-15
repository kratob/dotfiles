set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if exists("g:neovide")
  source ~/.gvimrc
  set guifont=MonoLisa\ Custom:h13
  set mouse=a
  let g:neovide_scroll_animation_length=0.1
end


let g:coq_settings = { 'auto_start': 'shut-up', 'keymap.pre_select': v:false, 'keymap.repeat': '<C-.>', 'display.ghost_text.enabled': v:false, 'display.pum.fast_close': v:false, 'clients.snippets.warn': [] }

:set completefunc=syntaxcomplete#Complete


luafile ~/.config/nvim/lspconfig.lua

lua require'hop'.setup()
noremap F :HopWord<Enter>
noremap <M-f> F

let g:netrw_keepj=""


imap <silent><script><expr> <C-Tab> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
