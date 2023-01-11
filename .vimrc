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
set number

set visualbell

set wildmenu
set wildmode=list:longest,full

set splitright
set splitbelow

set hidden

set guifont=Monaco:h16
set guioptions-=T guioptions-=e guioptions-=L guioptions-=r
set shell=bash

set conceallevel=0
let g:vim_json_syntax_conceal = 0

augroup vimrc
  autocmd!
  autocmd GuiEnter * set columns=120 lines=70 number
augroup END

" shows the output from prettier - useful for syntax errors
nnoremap <leader>pt :!prettier %<CR>

" Plugin Configuration: {{{

  " ALE: {{{
    let g:ale_sign_error = 'X'
    let g:ale_sign_warning = '!'
    highlight link ALEWarningSign ErrorMsg
    highlight link ALEErrorSign WarningMsg
    nnoremap <silent> <leader>ne :ALENextWrap<CR>
    nnoremap <silent> <leader>pe :ALEPreviousWrap<CR>

    let g:ale_fixers = {
          \   'bash': ['shfmt'],
          \   'elixir': ['mix_format'],
          \   'javascript': ['prettier'],
          \   'javascript.jsx': ['prettier'],
          \   'json': ['prettier'],
          \   'ruby': ['rubocop'],
          \   'scss': ['prettier'],
          \   'zsh': ['shfmt'],
          \}

    let g:ale_fix_on_save = 1
  " }}}

" }}}

" Allow different drivers to quickly re-source their personal configurations
" for ease of navigation and code manipulation
fu! Driver(name)
  let fname='~/.vimrc.' . a:name
  if filereadable(expand(fname))
    exec "source " . fname
  else
    echomsg "Cannot read configuration " . fname . ", please ensure that you have your developer config present on this machine."
  endif
endfu

:command! -nargs=1 Driver :call Driver(<q-args>)

" this may no longer be required.
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif