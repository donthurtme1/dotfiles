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
set viminfo='256,<256,%64
set formatoptions-=o formatoptions+=t
"set winwidth=100
set listchars=tab:\|\ 
set incsearch
set ignorecase
set autowriteall
set noequalalways

" line wraping "
set breakindent
set breakindentopt=shift:-100,sbr
set showbreak=>\ 
set wrap
set cpoptions+=n

" folding "
set fillchars=fold:\ 
set foldtext=substitute(getline(v:foldstart),'\	','\ \ \ \ ',1).'\ \ \ \ \...\ \ \ \ '.(v:foldend\ -\ v:foldstart\ -\ 1).'\ lines'

filetype on
filetype plugin on
filetype indent on

if has('persistent_undo')
	set undodir=$HOME/.vim/undodir
	set undofile
endif

" vim "
let g:netrw_banner = 0
let g:ft_man_open_mode = "vert"

" vim-lsp "
let g:lsp_completion_docuentation_delay = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_highlights_delay = 250
let g:lsp_diagnostics_signs_delay = 250
let g:lsp_diagnostics_virtual_text_align = 0
let g:lsp_diagnostics_virtual_text_prefix = "~ "
let g:lsp_diagnostics_virtual_text_wrap = "truncate"
let g:lsp_document_highlight_enabled = 1
let g:lsp_signature_help_enabled = 0

" semantic "
let g:lsp_semantic_delay = 10
let g:lsp_semantic_enabled = 0
let g:lsp_max_buffer_size = 500000

" preview window "
let g:lsp_hover_ui = "preview"
let g:lsp_preview_autoclose = 1
let g:lsp_preview_float = 0
let g:lsp_preview_max_width = 40

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
set t_ZH= " disable italics
syntax on
colorscheme rosepine_moon

hi link LspSemanticVariable Normal
hi link LspSemanticProperty Normal
hi link LspSemanticParameter Define
hi link cdefine Define
hi link cmacro Macro
hi link ctypedef_type Type

if g:colors_name == 'rosepine_moon'
	hi Normal guibg=#232136
	hi NormalCurrentWindow guibg=#232135 guifg=#e0def4
	hi SignColumn guibg=#232136
	hi SignColumnCurrentWindow guibg=#232135 guifg=#e0def4

	hi Macro guifg=#f6c177
	hi Include guifg=#3e8fb0
	hi SpecialChar guifg=#3e8fb0
	hi StatusLineNC guibg=#232135
	hi MatchParen guifg=NONE
	hi Folded guifg=#6e6a86
	hi ModeMsg guifg=#e0def4

	" 'rose' search highlight
	hi Search guifg=#ea9a97
	" 'love' search highlight
	hi Search guifg=#eb6f92
	hi IncSearch guibg=#eb6f92

	augroup rosepine_moon_window_colour
		autocmd!
		autocmd BufEnter,WinEnter * set wincolor=NormalCurrentWindow
		autocmd BufLeave,WinLeave * set wincolor=Normal
	augroup end
endif

" Mappings "
let mapleader = ","
inoremap <C-c> <Esc>
nnoremap <C-j> gj
nnoremap <C-k> gk
"nnoremap _ ^ " this is default
nnoremap + $
nnoremap <C-=> <C-w>+
nnoremap <C-_> <C-w>-
nnoremap <C-.> <C-w>>
nnoremap <C-,> <C-w><
nnoremap <C-w><C-c> <C-w><Esc>

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

" fold all lines in current indent
function! FoldIndent() abort
	" get indent of current line
	let cur_pos = getcurpos()[1]
	let cur_indent = indent(cur_pos)
	let idx = 1
	while indent(cur_pos + idx) > cur_indent
		let idx += 1
	endwhile
	return idx
endfunction
nnoremap <expr> z<CR> 'zf'.FoldIndent().'j'

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

" Functions "
function! s:glsl_file() abort
	syn keyword Keyword layout location binding in out smooth struct
	syn keyword Define #version

	"syn region glslFuncDef transparent start="\(\h\w*\s*\)\{2,}(" end=")" contains=glslFuncParamHolder
	"syn match glslFuncParamHolder transparent "\h\w*\s*\(\[\d*\]\)*\s*[,)]" contains=glslFuncParam,Operator
	"syn match glslFuncParam "\h\w*" contained
	"hi link glslFuncParam Define

	syn match glslFunction "\h\w*\s*(" contains=glslFuncName,Operator transparent
	syn match glslFuncName "\h\w*" contained
	hi link glslFuncName Function

	syn match Operator "\V\[=+\-*/<>.,:;(){}]"
	syn match Type "\.\@<=\h\w*"
	syn match Define 'std\d\+'

	syn region Comment start="/\*" end="\*/" extend
	syn match Comment "//.*$"
endfunction

function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal tagfunc=lsp#tagfunc
	setlocal formatoptions-=o formatoptions+=t
	setlocal signcolumn=no
	"setlocal textwidth=82

	syn keyword Macro true false 
	syn keyword Define #define 
	syn keyword Type GLuint SDL_Event SDL_Window SDL_GLContext
	syn match cmacro "\<\u\+\>"
	syn match ctypedef_type "\<\(\u[a-z0-9]\+\)\+\>"
	syn match Type "\<\w\+_t\>"

	nnoremap <buffer> K <plug>(lsp-hover)
	nnoremap <buffer> <silent> <C-c> :call execute(":close" . bufwinnr('LspHoverPreview'))<CR>
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

" Autocommands "
let g:clearhls_return_search_str = ""
function! s:clearhls() abort
	"let g:clearhls_return_search_str = @/
	"let @/ = ""
	"nnoremap <silent> n :let @/ = g:clearhls_return_search_str<CR>n
	call feedkeys("\<cmd>nohl\<cr>")
endfunc
augroup clearhlsearch | au! | au CursorMoved * call s:clearhls() | augroup end

augroup current_window
	autocmd BufEnter,WinEnter * set wrap
	autocmd BufLeave,WinLeave * set nowrap
	autocmd BufEnter,WinEnter * set cursorline
	autocmd WinLeave * set nocursorline
augroup end

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

augroup vim_glsl
	autocmd!
	autocmd BufNewFile,BufRead *.glsl,*.vs,*.fs set filetype=glsl
augroup end

augroup lsp_clangd
	autocmd!
	autocmd User lsp_setup call lsp#register_server({ 'name': 'clangd', 'cmd': { server_info->['clangd'] }, 'allowlist': ['c'], })
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
	autocmd FileType c call s:on_lsp_buffer_enabled()
augroup end

function! s:pokedex_highlight()
	syn keyword BlkType Drk Dra Gho
	syn keyword RedType Fir
	syn keyword GrnType Gra
	syn keyword YlwType Bug Ele
	syn keyword BluType Wtr Ice
	syn keyword PurType Psy Fae Poi
	syn keyword BrnType Gnd Rck Fgh
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
augroup pokedex | au! | au BufRead,BufEnter *.dex call s:pokedex_highlight() | augroup end
