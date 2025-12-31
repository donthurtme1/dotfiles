" Plugins " 
call plug#begin('~/.vim/plugged')
Plug 'rose-pine/vim', { 'as': 'rosepine' }
Plug 'ntk148v/vim-horizon'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'mbbill/undotree'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'machakann/vim-sandwich'
Plug 'itchyny/vim-highlighturl'
Plug 'rust-lang/rust.vim'
"Plug '~/c/vimsession' " Must be after vim-lsp
Plug '~/vimscript/fuzzy_colors'
call plug#end()


" General settings " 
set nu rnu
set tabstop=4 shiftwidth=4 noexpandtab
set smartcase hlsearch
set nocompatible wildmenu signcolumn=no
set foldmethod=manual
set cursorline autoindent cindent showcmd
set viewoptions=cursor,slash,unix
set viminfo='256,<256,%64
set incsearch ignorecase
set autowriteall noequalalways
set cpoptions+=n
set undodir=$HOME/.vim/undodir undofile
set ssop=buffers,curdir,folds,help,tabpages,winsize
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

" undotree "
let g:undotree_HelpLine = 0
let g:undotree_StatusLine = 0

" highlight url "
let g:highlighturl_guifg = "#a0f0f0"

packadd nohlsearch
let g:hlyank_duration = 400
let g:vim_man_cmd = '/usr/bin/man'
let g:asyncomplete_auto_popup = 0


" Mappings "
nmap s <Nop>
xmap s <Nop>
xmap sa <Plug>(sandwich-add)
nnoremap <C-=> <C-w>+
nnoremap <C-_> <C-w>-
nnoremap <C-.> <C-w>>
nnoremap <C-,> <C-w><
nnoremap <C-w><C-c> <C-w><Esc>
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
nnoremap <silent> U <CMD>UndotreeToggle<CR>
nnoremap <silent> <Enter> o<Esc>
nnoremap <silent> <S-Enter> O<Esc>
nnoremap <silent> <Tab> <CMD>tabn<CR>
nnoremap <silent> <C-i> <C-i>

command! H Help
command! F Files
command! B Buffers
imap <C-c> <Esc>


" Colour "
au ColorScheme * call s:on_change_colorscheme()
func! s:on_change_colorscheme() abort
	if g:colors_name == 'rosepine_moon'
		hi Normal guibg=#232136
		hi NormalCurrentWindow guibg=#232135 guifg=#e0def4
		"hi Normal guibg=#191724
		"hi NormalCurrentWindow guibg=#191724 guifg=#e0def4

		hi Macro guifg=#f6c177
		hi Include guifg=#3e8fb0
		hi Structure guifg=#3e8fb0
		hi Typedef guifg=#3e8fb0
		hi StorageClass guifg=#3e8fb0
		hi SpecialChar guifg=#3e8fb0
		hi StatusLineNC guibg=#232135
		hi Folded guifg=#6e6a86
		hi ModeMsg guifg=#e0def4

		hi Search guifg=#eb6f92
		hi IncSearch guibg=#eb6f92

		"set list lcs=tab:│\ 
		"hi SpecialKey guifg=#44415a
	endif

	if g:colors_name == 'rosepine'
		hi! link Structure keyword
		hi! link StorageClass keyword
	endif

	if g:colors_name == 'horizon'
		"hi link Macro Special
		hi Macro guifg=#f6c177
		hi! link PreProc StorageClass
		"hi! link Type Normal
		set t_md=""
	endif

	if g:colors_name == 'fuzzy_colors'
		hi Macro guifg=#f6c177
		hi Search guifg=#eb6f92 guibg=#272c42
		hi IncSearch guifg=#272c42 guibg=#eb6f92 cterm=NONE
		set t_md=""
	endif

	hi! link CocErrorSign Error
	hi! link CocWarningSign WarningMsg
endf

set termguicolors
syn on
color rosepine_moon
hi MatchParen guifg=NONE


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
endf

au User CocNvimInit call s:on_coc_start()
func! s:on_coc_start() abort
	nnoremap gd <Plug>(coc-definition)
	nnoremap <silent> <C-c> :call coc#float#close_all(0)<CR>
	nnoremap <expr> K CocHasProvider('hover') ? CocActionAsync('definitionHover') : "K"
	inoremap <expr> <C-d> coc#pum#visible() ? coc#pum#scroll(1) : "\<C-d>"
	inoremap <expr> <C-u> coc#pum#visible() ? coc#pum#scroll(0) : "\<C-u>"
	inoremap <expr> <C-y> coc#pum#visible() ? coc#pum#select_confirm() : coc#start()

	hi! link CocErrorSign Error
	hi! link CocWarningSign WarningMsg
endf

au FileType help,netrw setl nu rnu cursorline
au FileType c call s:on_filetype_c()
func! s:on_filetype_c() abort
	hi link cDefine Define
	"hi link cSeparator Operator

	syn keyword Macro true false 
	syn keyword Conditional case default
	syn match Function "\<\h\w*\>\ze\_s*("
	syn match Macro "\<[A-Z_][0-9A-Z_]*\>"
	"syn match cSeparator "[\(){}\[\],;:?]"

	syn match Type "\(#\s*\)\@<!\<\h\w*\ze[ 	\n*]\+\(\h\w*[ 	\n]*[=;,(){}\[\]]\)"
	"syn match Type "^\(#\s*\)\@<!.\{-}\(\<\h\w*\)\ze[ 	\n*]\+\(\h\w*[ 	\n]*[=;,(){}\[\]]\)"
	"syn match Type "([a-zA-Z0-9_ 	*]*\zs\<\h\w*\ze[ 	\n]*)[ 	\n]*{"
	syn match Type "^struct[ 	\n]\+\zs\(\<\h\w*\)\ze[ 	\n]\+{"

	setlocal signcolumn=yes
	color fuzzy_colors
	call s:on_change_colorscheme()
endf

au BufEnter *.S set filetype=asm
au FileType asm call s:on_filetype_asm()
func! s:on_filetype_asm() abort
	set ts=8		" tab_stop
endf

au FileType rust call s:on_filetype_rust()
func! s:on_filetype_rust() abort
	set noet

	hi link rustEscape SpecialChar

	setlocal signcolumn=yes
	color fuzzy_colors
endf
