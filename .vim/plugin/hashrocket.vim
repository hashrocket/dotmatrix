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

command! -bar -range=% Trim :<line1>,<line2>s/\s\+$//e
command! -bar -range=% NotRocket :<line1>,<line2>s/:\(\w\+\)\s*=>/\1:/ge

function! HTry(function, ...)
  if exists('*'.a:function)
    return call(a:function, a:000)
  else
    return ''
  endif
endfunction

if &grepprg ==# 'grep -n $* /dev/null'
  set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude='*.log'\ --exclude=tags\ $*\ /dev/null
endif
set list            " show trailing whiteshace and tabs
if &statusline == ''
  set statusline=[%n]\ %<%.99f\ %h%w%m%r%{HTry('CapsLockStatusline')}%y%{HTry('rails#statusline')}%{HTry('fugitive#statusline')}%#ErrorMsg#%{HTry('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P
endif

if has('persistent_undo')
  set undofile
  set undodir^=~/.vim/tmp//,~/Library/Vim/undo
endif

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

if !exists('g:rails_projections')
  let g:rails_projections = {}
endif

call extend(g:rails_projections, {
      \  "app/presenters/*.rb": {
      \     "command": "presenter",
      \     "test": "spec/presenter/%s_spec.rb",
      \     "alternate": "spec/presenter/%s_spec.rb",
      \     "template": "class %S\nend" }
      \ }, 'keep')

if !exists('g:rails_gem_projections')
  let g:rails_gem_projections = {}
endif

call extend(g:rails_gem_projections, {
      \ "active_model_serializers": {
      \   "app/serializers/*_serializer.rb": {
      \     "command": "serializer",
      \     "template": "class %SSerializer < ActiveModel::Serializer\nend",
      \     "affinity": "model"}},
      \ "rspec": {
      \    "spec/support/*.rb": {
      \      "command": "support"}},
      \ "cucumber": {
      \   "features/*.feature": {
      \     "command": "feature",
      \     "template": "Feature: %h"},
      \   "features/support/*.rb": {
      \     "command": "support"},
      \   "features/support/env.rb": {
      \     "command": "support"},
      \   "features/step_definitions/*_steps.rb": {
      \     "command": "steps"}},
      \ "carrierwave": {
      \   "app/uploaders/*_uploader.rb": {
      \     "command": "uploader",
      \     "template": "class %SUploader < CarrierWave::Uploader::Base\nend"}},
      \ "draper": {
      \   "app/decorators/*_decorator.rb": {
      \     "command": "decorator",
      \     "affinity": "model",
      \     "template": "class %SDecorator < ApplicationDecorator\nend"}},
      \ "fabrication": {
      \   "spec/fabricators/*_fabricator.rb": {
      \     "command": ["fabricator", "factory"],
      \     "alternate": "app/models/%s.rb",
      \     "related": "db/schema.rb#%p",
      \     "test": "spec/models/%s_spec.rb",
      \     "template": "Fabricator :%s do\nend",
      \     "affinity": "model"}},
      \ "factory_girl": {
      \   "spec/factories/*_factory.rb": {
      \     "command": "factory",
      \     "alternate": "app/models/%s.rb",
      \     "related": "db/schema.rb#%p",
      \     "test": "spec/models/%s_spec.rb",
      \     "template": "FactoryGirl.define do\n  factory :%s do\n  end\nend",
      \     "affinity": "model"},
      \   "spec/factories.rb": {
      \      "command": "factory"},
      \   "test/factories.rb": {
      \      "command": "factory"}}
      \ }, 'keep')

inoremap <C-C> <Esc>`^

" Enable TAB indent and SHIFT-TAB unindent
vnoremap <silent> <TAB> >gv
vnoremap <silent> <S-TAB> <gv

" Open the OSX color picker and insert the hex value of the choosen color.
" Depends on: https://github.com/jnordberg/color-pick
inoremap <C-X>c #<C-R>=system('colorpick')<CR>

iabbrev Lidsa     Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
iabbrev rdebug    require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger
iabbrev bpry      require 'pry'; binding.pry

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

" Cursor shapes
if exists("g:use_cursor_shapes") && g:use_cursor_shapes
  if exists("$TMUX")
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

function! s:unused_steps(bang) abort
  let savegp = &grepprg

  let prg = "hr unused"
  if a:bang | let prg = prg.' -f' | endif
  let &grepprg = prg

  try
    silent grep!
  finally
    let &grepprg = savegp
  endtry

  copen
  redraw!
endfunction

command! -bang UnusedSteps call <SID>unused_steps("<bang>")

augroup hashrocket
  autocmd!

  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
        \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

  autocmd BufRead * if ! did_filetype() && getline(1)." ".getline(2).
        \ " ".getline(3) =~? '<\%(!DOCTYPE \)\=html\>' | setf html | endif

  autocmd FileType gitcommit              setlocal spell
  autocmd FileType ruby                   setlocal comments=:#\  tw=79

  autocmd Syntax   css  syn sync minlines=50

  autocmd FileType ruby nmap <buffer> <leader>bt <Plug>BlockToggle
  autocmd BufRead *_spec.rb map <buffer> <leader>l <Plug>ExtractRspecLet

  autocmd User Rails nnoremap <buffer> <D-r> :<C-U>Rake<CR>
  autocmd User Rails nnoremap <buffer> <D-R> :<C-U>.Rake<CR>
  autocmd User Fugitive command! -bang -bar -buffer -nargs=* Gpr :Git<bang> pull --rebase <args>
augroup END
