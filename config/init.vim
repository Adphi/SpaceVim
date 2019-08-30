"=============================================================================
" init.vim --- Language && encoding in SpaceVim
" Copyright (c) 2016-2017 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

let s:SYSTEM = SpaceVim#api#import('system')

"Use English for anything in vim
try
  if s:SYSTEM.isWindows
    silent exec 'lan mes en_US.UTF-8'
  elseif s:SYSTEM.isOSX
    silent exec 'language en_US.UTF-8'
  else
    let s:uname = system('uname -s')
    if s:uname ==# "Darwin\n"
      " in mac-terminal
      silent exec 'language en_US.UTF-8'
    elseif s:uname ==# "SunOS\n"
      " in Sun-OS terminal
      silent exec 'lan en_US.UTF-8'
    elseif s:uname ==# "FreeBSD\n"
      " in FreeBSD terminal
      silent exec 'lan en_US.UTF-8'
    else
      " in linux-terminal
      silent exec 'lan en_US.UTF-8'
    endif
  endif
catch /^Vim\%((\a\+)\)\=:E197/
  call SpaceVim#logger#error('Can not set language to en_US.utf8')
endtry

" try to set encoding to utf-8
if s:SYSTEM.isWindows
  " Be nice and check for multi_byte even if the config requires
  " multi_byte support most of the time
  if has('multi_byte')
    " Windows cmd.exe still uses cp850. If Windows ever moved to
    " Powershell as the primary terminal, this would be utf-8
    set termencoding=cp850
    setglobal fileencoding=utf-8
    " Windows has traditionally used cp1252, so it's probably wise to
    " fallback into cp1252 instead of eg. iso-8859-15.
    " Newer Windows files might contain utf-8 or utf-16 LE so we might
    " want to try them first.
    set fileencodings=ucs-bom,utf-8,gbk,utf-16le,cp1252,iso-8859-15,cp936
  endif

else
  set termencoding=utf-8
  set fileencoding=utf-8
  set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
endif
scriptencoding utf-8

set colorcolumn=120
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_generate_tags = 1
let g:go_higlight_format_string = 1
let g:go_higlight_variable_declaration = 1
let g:go_highlight_debug = 1

let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration wn
let g:airline#extensions#ale#enabled = 1
let g:go_auto_type_info = 1
"let g:spacevim_default_indent = 4
" esc in insert mode
" inoremap kj <esc>
" auto save
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave"]

let g:vimfiler_direction = 'topleft'
let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\)$'

set mmp=5000
autocmd filetype go set tabstop=4
autocmd filetype go set shiftwidth=4

set clipboard=unnamed
" Maintain undo history between sessions<Paste>
set undofile 
set undodir=~/.vim_undodir

call SpaceVim#layers#load('lang#python')
