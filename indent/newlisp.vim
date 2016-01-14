" Vim indent file
" Language:    newlisp
" Author:      nkmathew <kipkoechmathew@gmail.com>
" URL:         https://github.com/nkmathew/vim-newlisp-yasi
" License:     Same as Vim
" Last Change: 2016-01-15

if !has('python')
  finish
endif

if exists('*GetNewLispIndent')
  finish
endif

python import yasi

if !exists('g:newlisp_maxlines')
  let g:newlisp_maxlines = 50
endif


func! s:SyntaxName(line, col)
  let _line = (a:line == '.') ? line(a:line) : a:line
  let _col = (a:col == '.') ? col(a:col) : a:col
  return synIDattr(synID(_line, _col, 0), 'name')
endfunc


" Whole point is to take the previous 20 or so lines defined in g:newlisp_maxlines
" pass it to yasi as if we're indenting the code and store the list of open brackets
" where the value at the end of the list will determine the indentation amount
func! GetNewLispIndent()
  let lnum = line('.') - 1
  let lstop = lnum - g:newlisp_maxlines
  let lstop = (lstop < 1) ? 1 : lstop
  let code = ''
  while lnum >= lstop
    let code = getline(lnum) . "\n" . code
    let lnum -= 1
  endwhile
  " Build a new string ignoring any newlisp string literals os that they don't
  " get evaluated should the stopping line happen to be inside one
  let new_code = ''
  let seen_string = 0
  let _col = 0
  let _line = lstop
  let characters = split(code, '\zs')
  for char in characters
    let _col += 1
    if char == "\n"
      let _col = 0
      let _line += 1
    endif
    if s:SyntaxName(_line, _col) =~ 'string'
      if !seen_string
        " Add some dummy value to represent the whole string as it's not going to
        " affect the indentation
        let new_code = new_code . '000'
      endif
      let seen_string = 1
    else
      let new_code = new_code . char
      let seen_string = 0
    endif
  endfor
  let escaped_code = escape(new_code, "\"'")
  let escaped_code = substitute(escaped_code, '\n', '\\n', 'g')
  let escaped_code = printf("yasi.indent_code('%s', '--no-compact')", escaped_code)
  let open_brackets = pyeval(escaped_code)[-4]
  if open_brackets == []
    return 0
  else
    return open_brackets[-1].indent_level
  endif
endfunc

setlocal noautoindent
setlocal nosmartindent
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal indentkeys=!,o,O

au filetype newlisp setlocal indentexpr=GetNewLispIndent()
