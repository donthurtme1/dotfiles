" General settings " 
set nocompatible
set nu rnu
set tabstop=4 shiftwidth=4
set scrolloff=0
set linebreak
set smartcase showmatch hlsearch
set wildmenu
set foldmethod=manual
set cursorline
set autoindent cindent
set showcmd
set splitright
set viewoptions=cursor,slash,unix
set formatoptions-=o formatoptions+=t
set winwidth=86 "textwidth=82
set listchars=tab:\|\ 

" line wraping "
set breakindent
set breakindentopt=shift:-100,sbr
set showbreak=>\ 
set wrap
set cpoptions+=n

filetype on
filetype plugin on
filetype indent on

if has('persistent_undo')
	set undodir=$HOME/.vim/undodir
	set undofile
endif

let g:netrw_banner = 0
let g:ft_man_open_mode = 'vert'

let g:lsp_completion_docuentation_delay = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 0
let g:lsp_diagnostics_highlights_delay = 250
let g:lsp_diagnostics_signs_delay = 250
let g:lsp_diagnostics_virtual_text_align = "after"
let g:lsp_diagnostics_virtual_text_prefix = "~ "
let g:lsp_diagnostics_virtual_text_wrap = "truncate"
let g:lsp_document_highlight_enabled = 1
let g:lsp_signature_help_enabled = 0
" TODO: make fix to vim-lsp to keep hover info open while moving in line and
" while in insert mode on current line. "
let g:lsp_preview_autoclose = 0
let g:lsp_preview_float = 1
let g:lsp_semantic_delay = 10
let g:lsp_semantic_enabled = 0
let g:lsp_max_buffer_size = 1000000

" Plugins " 
call plug#begin('~/.vim/plugged')
Plug 'rose-pine/vim', { 'as': 'rosepine' }
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'sainnhe/everforest'

Plug 'prabirshrestha/vim-lsp'
Plug 'rhysd/vim-healthcheck'

Plug 'junegunn/fzf.vim'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'prabirshrestha/async.vim'
Plug 'mbbill/undotree'
Plug 'vim-scripts/restore_view.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'

" Custom "
Plug '~/c/vimhook'
call plug#end()

" Colours "
set termguicolors
colorscheme rosepine_moon
syntax on

set t_ZH= " disable italics
hi Normal guibg=#232136
hi NormalCurrentWindow guibg=#232135 guifg=#e0def4
hi SignColumn guibg=#232136
hi SignColumnCurrentWindow guibg=#232135 guifg=#e0def4

hi Macro guifg=#f6c177
hi Include guifg=#3e8fb0
hi SpecialChar guifg=#3e8fb0
hi StatusLineNC guibg=#232135
hi MatchParen guifg=NONE
hi Folded guifg=#c4a7e7

hi link LspSemanticVariable Normal
hi link LspSemanticProperty Normal
hi link LspSemanticParameter Define
hi link cdefine Define
hi link cmacro Macro
hi link ctypedef_type Type

" Mappings "
let mapleader = ","
nnoremap <Space> :
inoremap <C-c> <Esc>
nnoremap <C-j> gj
nnoremap <C-k> gk
"nnoremap _ ^ " this is default
nnoremap + $
nnoremap <C-=> <C-w>+
nnoremap <C-_> <C-w>-
nnoremap <C-.> <C-w>>
nnoremap <C-,> <C-w><

nnoremap <silent> <leader>p "+p
nnoremap <silent> <leader>P "+P
nnoremap <silent> <leader>s <cmd>setlocal nowrap<CR>
nnoremap <silent> <leader>S <cmd>setlocal wrap<CR>
nnoremap <silent> <leader>u <cmd>UndotreeToggle<CR>
nnoremap <silent> <C-c> <cmd>let @/=""<CR>

nnoremap <silent> <C-w>n :new<CR>
nnoremap <silent> <C-w><C-n> :new<CR>
nnoremap <silent> <C-w>m :vert new<CR>
nnoremap <silent> <C-w><C-m> :vert new<CR>

nnoremap <expr> o (line(".") - line("w0") > winheight(0) * 2 / 3) ? '<C-e>o' : 'o'
nnoremap <expr> O (line(".") - line("w0") > winheight(0) * 2 / 3) ? '<C-e>O' : 'O'
inoremap <expr> <CR> (line(".") - line("w0") > winheight(0) * 2 / 3) ? '<C-x><C-e><CR>' : '<CR>'
"nnoremap <silent> <expr> 'z'.v:count.'<CR>' ':call LineToNumber('.v:count.')<CR>'

" fzf-vim stuff "
nnoremap <silent> <leader>f :GFiles<CR>
nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>h :Help<CR>
nnoremap <silent> <leader>v :Buffers<CR>
nnoremap <silent> <leader>m :Marks<CR>
nnoremap <silent> <leader>j :Jumps<CR>
nnoremap <silent> <leader>c :Commits<CR>
nnoremap <silent> <leader>C :Changes<CR>
nnoremap <silent> <leader>t :Lines<CR>
nnoremap <silent> <leader>/ :History/<CR>
"nnoremap <leader>g :Git 
nnoremap <silent> <leader>ne :LspNextError<CR>
" }}}

" Vimscript "
augroup aesthetics
	autocmd!

	" Current window "
	autocmd BufEnter,WinEnter * set wincolor=NormalCurrentWindow
	autocmd BufLeave,WinLeave * set wincolor=Normal
	"autocmd WinEnter * setlocal signcolumn=yes
	"autocmd WinLeave * setlocal signcolumn=no
	autocmd BufEnter,WinEnter * set wrap
	autocmd BufLeave,WinLeave * set nowrap

	" Cursorline "
	autocmd BufEnter,WinEnter * set cursorline
	autocmd WinLeave * set nocursorline
augroup end

function! s:glsl_file() abort
	syn keyword Keyword layout location binding in out smooth

	"syn region glslFuncDef transparent start="\(\h\w*\s*\)\{2,}(" end=")" contains=glslFuncParamHolder
	"syn match glslFuncParamHolder transparent "\h\w*\s*\(\[\d*\]\)*\s*[,)]" contains=glslFuncParam,Operator
	"syn match glslFuncParam "\h\w*" contained
	"hi link glslFuncParam Define

	syn match glslFunction transparent "\h\w*\s*(" contains=glslFuncName,Operator
	syn match glslFuncName "\h\w*" contained
	hi link glslFuncName Function
	syn match Operator "\W\+"

	syn region Comment start="\s*/\*" end="\*/"
	syn match Comment "\s*//.*$"
endfunction

augroup filetype
	autocmd!

	" Vim "
	autocmd FileType help setlocal nu rnu cursorline nowrap
	autocmd FileType netrw setlocal nu rnu cursorline nowrap
	"autocmd WinEnter,WinNew *help* set winwidth=84
	"autocmd WinLeave,BufLeave *help* set winwidth=60

	" C "
	autocmd BufRead,BufNewFile *.c set filetype=c
	autocmd BufRead,BufNewFile *.h set filetype=c

	" Other "
	autocmd BufRead,BufNewFile *.s setlocal lisp
	autocmd BufNew,BufRead,WinEnter *\ manpage set cursorline
	autocmd BufRead,BufNewFile *.glsl set filetype=glsl
	autocmd FileType glsl call s:glsl_file()
augroup end

function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal tagfunc=lsp#tagfunc
	setlocal formatoptions-=o formatoptions+=t
	setlocal signcolumn=no
	setlocal textwidth=82

	syn keyword Macro true false 
	syn keyword Define #define 
	syn keyword Type GLuint SDL_Event SDL_Window SDL_GLContext
	syn match cmacro "\<\u\+\>"
	syn match ctypedef_type "\<\(\u\l\+\)\+\>"
	syn match Type "\<\w\+_t\>"

	syn keyword Argument argc argv
	hi link Argument Define

	nnoremap <buffer> K <plug>(lsp-hover-float)
	nnoremap <buffer> gd <plug>(lsp-definition)
	nnoremap <buffer> gD <plug>(lsp-declaration)
	nnoremap <buffer> gs <plug>(lsp-document-symbol-search)
	nnoremap <buffer> gS <plug>(lsp-workspace-symbol-search)
	nnoremap <buffer> gr <plug>(lsp-references)
	nnoremap <buffer> gi <plug>(lsp-implementation)
	nnoremap <buffer> gt <plug>(lsp-type-definition)
	nnoremap <buffer> <leader>r <plug>(lsp-rename)
	nnoremap <buffer> [g <plug>(lsp-previous-diagnostic)
	nnoremap <buffer> ]g <plug>(lsp-next-diagnostic)
	nnoremap <buffer> <leader>d <plug>(lsp-document-diagnostics)

	inoremap <buffer> <C-c> <Esc>
	nnoremap <silent> <C-c> :let @/=""<CR>
endfunction

augroup lsp_clangd
	autocmd!
	autocmd User lsp_setup call lsp#register_server({ 'name': 'clangd', 'cmd': { server_info->['clangd'] }, 'allowlist': ['c'], })
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
	autocmd FileType c call s:on_lsp_buffer_enabled()
augroup end

function! WindowColourOn() abort
	hi NormalCurrentWindow guibg=#232135
	hi SignColumn guibg=#232135
endfunction

function! WindowColourOff() abort
	hi NormalCurrentWindow guibg=#232136
	hi SignColumn guibg=#232136
endfunction

" Custom commands "
function! s:help_current_window(subject)
	let buftype = &buftype
	let &buftype = 'help'
	let v:errmsg = ''
	let cmd = "help " . a:subject
	silent! execute  cmd
	if v:errmsg != ''
		let &buftype = buftype
		return cmd
	else
		call setbufvar('#', '&buftype', buftype)
	endif
endfunction
command! -nargs=? -bar -complete=help H execute <SID>help_current_window(<q-args>)

function! s:man_current_window(subject)
	let buftype = &buftype
	let &buftype = 'nofile'
	let v:errmsg = ''
	let cmd = "Man " . a:subject
	silent! execute  cmd
	if v:errmsg != ''
		let &buftype = buftype
		return cmd
	else
		call setbufvar('#', '&buftype', buftype)
	endif
endfunction
command! -nargs=? -bar -complete=help M execute <SID>man_current_window(<q-args>)

" Pokedex thing "
function! s:dex_highlight()
	syn keyword BlkType Drk Dra Gho
	syn keyword RedType Fir
	syn keyword GrnType Gra
	syn keyword YlwType Bug Ele
	syn keyword BluType Wtr Ice
	syn keyword PurType Psy Fae Poi
	syn keyword BrnType Grn Rck Fgh
	syn keyword WhtType Nor Fly Stl
	hi BlkType guifg=#908caa
	hi RedType guifg=#eb6f92
	hi GrnType guifg=#3e8fb0
	hi YlwType guifg=#f6c177
	hi BluType guifg=#9ccfd8
	hi PurType guifg=#c4a7e7
	hi BrnType guifg=#ea9a97
	hi WhtType guifg=#c0bed4
endfunction

augroup pokedex
	autocmd!
	autocmd BufRead,BufEnter *.dex call s:dex_highlight()
augroup end
