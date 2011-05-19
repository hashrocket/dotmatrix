runtime! autoload/pathogen.vim
if exists('g:loaded_pathogen')
  call pathogen#runtime_prepend_subdirectories(expand('~/.vimbundles'))
endif

syntax on
filetype plugin indent on

set visualbell

augroup vimrc
  autocmd!
  autocmd GuiEnter * set guifont=Monaco:h16 guioptions-=T columns=120 lines=70 number
  autocmd GuiEnter * colorscheme ir_black
augroup END

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
