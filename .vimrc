" General settings " 
set nu rnu
set tabstop=4 shiftwidth=4 noexpandtab
set smartcase hlsearch
set nocompatible wildmenu signcolumn=no
set foldmethod=manual
set cursorline autoindent cindent showcmd
set viewoptions=cursor,slash,unix
set viminfo='256,<256,%64
set fo=qjl
set incsearch ignorecase
set autowriteall noequalalways
set cpoptions+=n
set undodir=$HOME/.vim/undodir undofile
set ssop+=localoptions
set ttyscroll=0
filetype on

" folding "
set fillchars=fold:\ 
set foldtext=substitute(getline(v:foldstart),'\	','\ \ \ \ ',1)
\.'\ \ \ \ \...\ \ \ \ '
\.(v:foldend\ -\ v:foldstart\ +\ 1)
\.'\ lines'

let g:netrw_banner = 0
let g:netrw_preview = 1

" lsp diagnostics "
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_virtual_text_align = "after"
let g:lsp_diagnostics_virtual_text_prefix = " ~ "
let g:lsp_diagnostics_virtual_text_wrap = "truncate"
let g:lsp_diagnostics_virtual_text_delay = 0
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
let g:lsp_diagnostics_signs_insert_mode_enabled = 1

" lsp document "
let g:lsp_document_highlight_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0

let g:lsp_completion_documentation_enabled = 1
let g:lsp_signature_help_enabled = 0
let g:lsp_signature_help_delay = 0
let g:lsp_semantic_enabled = 1
let g:lsp_semantic_delay = 0
let g:lsp_use_native_client = 1
let g:lsp_use_lua = 1
let g:lsp_format_sync_timeout = 500
let g:lsp_preview_keep_focus = 0
let g:lsp_float_max_width = float2nr(winwidth(0) * 0.6)

" lsp settings "
let g:lsp_settings = {
\	'clangd': {
\		'cmd': ['clangd',
\		'--header-insertion=never'],
\	},
\}
"\		'--completion-style=detailed',

packadd nohlsearch
let g:hlyank_duration = 400
let g:vim_man_cmd = '/usr/bin/man'
let g:asyncomplete_auto_popup = 0


" Plugins " 
call plug#begin('~/.vim/plugged')
Plug 'rose-pine/vim', { 'as': 'rosepine' }
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'mbbill/undotree'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'machakann/vim-sandwich'
call plug#end()


" Mappings "
nmap s <Nop>
xmap s <Nop>
xmap sa <Plug>(sandwich-add)
nnoremap <C-=> <C-w>+
nnoremap <C-_> <C-w>-
nnoremap <C-.> <C-w>>
nnoremap <C-,> <C-w><
nnoremap <C-w><C-c> <C-w><Esc>
nnoremap <silent> U <cmd>UndotreeToggle<cr>
nnoremap <silent> <Enter> o<Esc>
nnoremap <silent> <S-Enter> O<Esc>
command! H Help
command! F Files
command! B Buffers
inoremap <C-c> <Esc>
inoremap <expr> <C-x> pumvisible() ? asyncomplete#cancel_popup() : "\<C-x>"
" TODO: improve speed of these mappings
xnoremap J dpV
xnoremap K dkPV


" Vim Session Settings "
command NewSession au VimLeave * call WriteSession()

au VimEnter * call LoadSession()
func! LoadSession() abort
	if argc() == 0 || !filereadable('.vim_session')
		if filereadable('.vim_session') && argc() == 0
			so .vim_session
		endif
		au VimLeave * call WriteSession()
	endif
endf
func! WriteSession() abort
	if filereadable('.vim_session')
		call delete('.vim_session')
	endif
	mks! .vim_session
endf


" Colour "
set termguicolors
"set t_ZH= " disable italics
syn on
color rosepine_moon
if g:colors_name == 'rosepine_moon'
	hi Normal guibg=#232136
	hi NormalCurrentWindow guibg=#232135 guifg=#e0def4

	hi Macro guifg=#f6c177
	hi Include guifg=#3e8fb0
	hi SpecialChar guifg=#3e8fb0
	hi StatusLineNC guibg=#232135
	hi MatchParen guifg=NONE
	hi Folded guifg=#6e6a86
	hi ModeMsg guifg=#e0def4
	hi link Function Normal

	hi Search guifg=#eb6f92
	hi IncSearch guibg=#eb6f92

	"set list lcs=tab:│\ 
	"hi SpecialKey guifg=#44415a
endif


" Autocommands "
aug clearhlsearch
	au!
	au ModeChanged *:[xi]* call feedkeys("\<cmd>nohl\<cr>")
	au TextChanged * call feedkeys("\<cmd>nohl\<cr>")
	"au CmdlineEnter : set nohls
	au CmdlineEnter [/?] set hls
aug end

aug current_window
	au!
	au BufEnter,WinEnter * set cursorline
	au WinLeave * set nocursorline
	if g:colors_name == 'rosepine_moon'
		au BufEnter,WinEnter * set wincolor=NormalCurrentWindow
		au BufLeave,WinLeave * set wincolor=Normal
	endif
aug end

au WinResized * call s:on_winresize()
au VimResized * call s:on_winresize()
func! s:on_winresize() abort
	let g:lsp_float_max_width = float2nr(winwidth(0) * 0.6)
endf

au FileType help,netrw setl nu rnu cursorline
au FileType c call s:on_filetype_c()
func! s:on_filetype_c() abort
	hi link cdefine Define
	hi link LspSemanticVariable Normal
	hi link LspSemanticProperty Normal
	hi link LspSemanticParameter Normal

	syn keyword Macro true false 
	syn keyword Type GLuint SDL_Event SDL_Window SDL_GLContext
	syn keyword Type uchar ushort uint ulong
	syn match Type "\<\(\u[a-z0-9]\+\)\+\>"
	syn match Type "\<\w\+_t\>"
	syn match Operator "[(){}\[\].,:;]"

	inoremap <silent> <c-h> <c-o><plug>(lsp-signature-help)
	setlocal signcolumn=yes
	setlocal omnifunc=lsp#complete complete=o
endf

au BufEnter *.S set filetype=asm
au FileType asm call s:on_filetype_asm()
func! s:on_filetype_asm() abort
	set ts=8		" tab_stop
	inoremap <silent> <c-h> <c-o><plug>(lsp-signature-help)
endf

au FileType rust call s:on_filetype_rust()
func! s:on_filetype_rust() abort
	let g:lsp_diagnostics_virtual_text_align = "after"
	let g:lsp_diagnostics_virtual_text_wrap = "truncate"
	let g:lsp_diagnostics_virtual_text_delay = 200
	let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
	let g:lsp_document_highlight_enabled = 0
	let g:lsp_semantic_enabled = 1
	let g:lsp_semantic_delay = 200

	set noet

	hi link rustEscape SpecialChar
	hi link LspSemanticVariable Normal
	hi link LspSemanticProperty Normal
	hi link LspSemanticParameter Normal
	syn match Operator "[(){}\[\].,:;]"

	inoremap <silent> <c-h> <c-o><plug>(lsp-signature-help)
endf

au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
func! s:on_lsp_buffer_enabled() abort
	nnoremap <buffer> K <plug>(lsp-hover)
	nnoremap <buffer> gd <plug>(lsp-definition)
	nnoremap <buffer> <silent> R :LspRename<cr>
endf
