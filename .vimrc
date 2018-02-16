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

  " NeoFormat: {{{
    " shows the output from prettier - useful for syntax errors
    nnoremap <leader>pt :!prettier %<CR>

    " ONLY PRETTIER (don't run any other formatters for these file types)
    let g:neoformat_enabled_javascript = ['prettier']
    let g:neoformat_enabled_css = ['prettier']
    let g:neoformat_enabled_scss = ['prettier']
    let g:neoformat_enabled_json = ['prettier']

    " default settings for prettier on javascript
    let g:neoformat_javascript_prettier = {
      \ 'exe': 'prettier',
      \ 'args': ['--stdin', '--print-width 80', '--single-quote', '--trailing-comma es5'],
      \ 'stdin': 1,
      \ }

    " OPT-IN - to run neoformat when saving certain files copy the following
    " into your .vimrc.local:
    "
    " augroup NeoformatAutoFormat
    "   autocmd!
    "   autocmd BufWritePre *.{js,jsx,css,scss,json,ex,exs} Neoformat
    " augroup END
  " }}}
" }}}

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
