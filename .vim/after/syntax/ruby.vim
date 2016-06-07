" Save buffer's current syntax
let s:bcs = b:current_syntax
unlet b:current_syntax

" Magic happens here.
syntax include @SQL syntax/pgsql.vim

" Restore buffer's current syntax
let b:current_syntax = s:bcs

" Match Ruby heredoc format (`<<`, `<<-`, or `<<~` start tag, whitespace before end tag)
syntax region rubyHereDocSQL matchgroup=Statement start=+<<[-~]\?SQL+ end=+^\s*SQL$+ contains=@SQL
