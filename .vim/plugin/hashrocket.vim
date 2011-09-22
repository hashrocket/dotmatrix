" hashrocket.vim
" vim:set ft=vim et tw=78 sw=2:

if $HASHROCKET_DIR == '' && expand('<sfile>') =~# '/dotmatrix/\.vim/plugin/hashrocket\.vim$'
  let $HASHROCKET_DIR = expand('<sfile>')[0 : -38]
endif
if $HASHROCKET_DIR == '' && filereadable(expand('~/.bashrc'))
  let $HASHROCKET_DIR = expand(matchstr("\n".join(readfile(expand('~/.bashrc')),"\n")."\n",'\n\%(export\)\=\s*HASHROCKET_DIR="\=\zs.\{-\}\ze"\=\n'))
endif
if $HASHROCKET_DIR == ''
  let $HASHROCKET_DIR = substitute(system("bash -i -c 'echo \"$HASHROCKET_DIR\"'"),'\n$','','')
endif
if $HASHROCKET_DIR == ''
  let $HASHROCKET_DIR = expand('~/hashrocket')
endif

function! s:HComplete(A,L,P)
  let match = split(glob($HASHROCKET_DIR.'/'.a:A.'*'),"\n")
  return map(match,'v:val[strlen($HASHROCKET_DIR)+1 : -1]')
endfunction
command! -bar -nargs=1 Hcommand :command! -bar -bang -nargs=1 -complete=customlist,s:HComplete H<args> :<args><lt>bang> $HASHROCKET_DIR/<lt>args>

Hcommand cd
Hcommand lcd
Hcommand read
Hcommand edit
Hcommand split
Hcommand saveas
Hcommand tabedit

command! -bar -nargs=* -complete=dir Terrarails :execute 'Rails --template='.system("ruby -rubygems -e 'print Gem.bin_path(%(terraformation))'") . ' ' . <q-args>

command! -bar -range=% Trim :<line1>,<line2>s/\s\+$//e
command! -bar -range=% NotRocket :<line1>,<line2>s/:\(\w\+\)\s*=>/\1:/ge

command! -bar -nargs=* -bang -complete=file Rename :
      \ let v:errmsg = ""|
      \ saveas<bang> <args>|
      \ if v:errmsg == ""|
      \   call delete(expand("#"))|
      \ endif

command! -bar -nargs=0 -bang -complete=file Remove :
      \ let v:errmsg = ''|
      \ let s:removable = expand('%:p')|
      \ bdelete<bang>|
      \ if v:errmsg == ''|
      \   call delete(s:removable)|
      \ endif|
      \ unlet s:removable

function! HTry(function, ...)
  if exists('*'.a:function)
    return call(a:function, a:000)
  else
    return ''
  endif
endfunction

set nocompatible
set autoindent
set autoread
set backspace=indent,eol,start
set complete-=i      " Searching includes can be slow
set display=lastline " When lines are cropped at the screen bottom, show as much as possible
if &grepprg ==# 'grep -n $* /dev/null'
  set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude='*.log'\ --exclude=tags\ $*\ /dev/null
endif
set incsearch
set laststatus=2    " Always show status line
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list            " show trailing whiteshace and tabs
set modelines=5
set scrolloff=1
set sidescrolloff=5
set showcmd
set showmatch
set smarttab
if &statusline == ''
  set statusline=[%n]\ %<%.99f\ %h%w%m%r%{HTry('CapsLockStatusline')}%y%{HTry('rails#statusline')}%{HTry('fugitive#statusline')}%#ErrorMsg#%{HTry('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P
endif
set ttimeoutlen=50  " Make Esc work faster
set wildmenu

if $TERM == '^\%(screen\|xterm-color\)$' && t_Co == 8
  set t_Co=16
endif

let g:is_bash = 1 " Highlight all .sh files as if they were bash
let g:ruby_minlines = 500
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDShutUp = 1
let g:VCSCommandDisableMappings = 1

let g:surround_{char2nr('s')} = " \r"
let g:surround_{char2nr(':')} = ":\r"
let g:surround_indent = 1


if !exists('g:w_sleep')
  let g:w_sleep = 0
endif

function! s:Wall() abort
  let sleep = g:w_sleep ? 'sleep '.g:w_sleep.'m' : ''
  let tab = tabpagenr()
  let win = winnr()
  let seen = {}
  if !&readonly && expand('%') !=# ''
    let seen[bufnr('')] = 1
    write
  endif
  tabdo windo if !&readonly && expand('%') !=# '' && !has_key(seen, bufnr('')) | exe sleep | silent write | let seen[bufnr('')] = 1 | endif
  execute 'tabnext '.tab
  execute win.'wincmd w'
endfunction

command! -bar W              :call s:Wall()

command! -bar -nargs=0 SudoW :setl nomod|silent exe 'write !sudo tee % >/dev/null'|let &mod = v:shell_error

runtime! plugin/matchit.vim
runtime! macros/matchit.vim

map Y       y$
nnoremap <silent> <C-L> :nohls<CR><C-L>
inoremap <C-C> <Esc>`^

cnoremap          <C-O> <Up>
inoremap              ø <C-O>o
inoremap          <M-o> <C-O>o
" Emacs style mappings
inoremap          <C-A> <C-O>^
inoremap     <C-X><C-@> <C-A>
cnoremap          <C-A> <Home>
cnoremap     <C-X><C-A> <C-A>
" If at end of a line of spaces, delete back to the previous line.
" Otherwise, <Left>
inoremap <silent> <C-B> <C-R>=getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"<CR>
cnoremap          <C-B> <Left>
" If at end of line, decrease indent, else <Del>
inoremap <silent> <C-D> <C-R>=col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"<CR>
cnoremap          <C-D> <Del>
" If at end of line, fix indent, else <Right>
inoremap <silent> <C-F> <C-R>=col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"<CR>
inoremap          <C-E> <End>
cnoremap          <C-F> <Right>

noremap           <F1>   <Esc>
noremap!          <F1>   <Esc>

" Enable TAB indent and SHIFT-TAB unindent
vnoremap <silent> <TAB> >gv
vnoremap <silent> <S-TAB> <gv

iabbrev Lidsa     Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
iabbrev rdebug    require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/\\\@<!|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

if !exists('g:syntax_on')
  syntax on
endif
filetype plugin indent on

" Bundle Open command, from Bernerd Schaefer
" Call with :BO <gemname>
function! s:BundleOpen(Gem) abort
  if exists(':Btabedit')
    execute 'Btabedit '.a:Gem
    redraw
    let v:warningmsg = 'Use :Btabedit instead. It has tab complete!'
    echomsg v:warningmsg
    return
  endif
  let path = system('bundle show '.a:Gem)
  if v:shell_error != 0
    echo 'failed to run command'
  else
    exe 'tabedit '.substitute(path, '\v\C\n$', '', '') | :lcd %
  endif
endfunction

" :BO capybara
:command! -nargs=1 BundleOpen :call s:BundleOpen(<q-args>)

augroup hashrocket
  autocmd!

  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
        \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

  autocmd BufNewFile,BufRead *.haml             set ft=haml
  autocmd BufNewFile,BufRead *.feature,*.story  set ft=cucumber
  autocmd BufRead * if ! did_filetype() && getline(1)." ".getline(2).
        \ " ".getline(3) =~? '<\%(!DOCTYPE \)\=html\>' | setf html | endif

  autocmd FileType javascript,coffee      setlocal et sw=2 sts=2 isk+=$
  autocmd FileType html,xhtml,css,scss    setlocal et sw=2 sts=2
  autocmd FileType eruby,yaml,ruby        setlocal et sw=2 sts=2
  autocmd FileType cucumber               setlocal et sw=2 sts=2
  autocmd FileType gitcommit              setlocal spell
  autocmd FileType gitconfig              setlocal noet sw=8
  autocmd FileType ruby                   setlocal comments=:#\  tw=79
  autocmd FileType sh,csh,zsh             setlocal et sw=2 sts=2
  autocmd FileType vim                    setlocal et sw=2 sts=2 keywordprg=:help

  autocmd Syntax   css  syn sync minlines=50

  autocmd FileType ruby nmap <buffer> <leader>bt <Plug>BlockToggle

  autocmd User Rails nnoremap <buffer> <D-r> :<C-U>Rake<CR>
  autocmd User Rails nnoremap <buffer> <D-R> :<C-U>.Rake<CR>
  autocmd User Rails Rnavcommand decorator app/decorators -suffix=_decorator.rb -default=model()
  autocmd User Rails Rnavcommand uploader app/uploaders -suffix=_uploader.rb -default=model()
  autocmd User Rails Rnavcommand steps features/step_definitions -suffix=_steps.rb -default=web
  autocmd User Rails Rnavcommand blueprint spec/blueprints -suffix=_blueprint.rb -default=model()
  autocmd User Rails Rnavcommand factory spec/factories -suffix=_factory.rb -default=model()
  autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=model()
  autocmd User Rails Rnavcommand feature features -suffix=.feature -default=cucumber
  autocmd User Rails Rnavcommand support spec/support features/support -default=env
  autocmd User Rails Rnavcommand worker app/workers -suffix=_worker.rb -default=model()
  autocmd User Fugitive command! -bang -bar -buffer -nargs=* Gpr :Git<bang> pull --rebase <args>
augroup END
