if $VIM_PLUGINS != 'NO'
  if filereadable(expand('~/.vimbundle'))
    source ~/.vimbundle
  endif
  runtime! ftplugin/man.vim
endif

syntax on
filetype plugin indent on

set ignorecase
set smartcase

set visualbell

set wildmenu
set wildmode=list:longest,full

set splitright
set splitbelow

set hidden

set guifont=Monaco:h16
set guioptions-=T guioptions-=e guioptions-=L guioptions-=r
set shell=bash

augroup vimrc
  autocmd!
  autocmd GuiEnter * set columns=120 lines=70 number
augroup END

" Plugin Configuration: {{{

  " ALE: {{{
    let g:ale_sign_error = 'X'
    let g:ale_sign_warning = '!'
    highlight link ALEWarningSign ErrorMsg
    highlight link ALEErrorSign WarningMsg
    nnoremap <silent> <leader>ne :ALENextWrap<CR>
    nnoremap <silent> <leader>pe :ALEPreviousWrap<CR>
  " }}}

" }}}

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
