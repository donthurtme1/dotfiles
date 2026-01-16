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
set cpoptions-=z
set undodir=$HOME/.vim/undodir undofile
set ssop=buffers,curdir,folds,help,tabpages,winsize
set ttyscroll=0 title
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


" Vimscript "
let g:vmode_y = ""
let g:vy_start_line = ""
let g:vy_start_col = ""
let g:vy_end_line = ""
let g:vy_end_col = ""
func! s:visual_yank() abort
	let g:vmode_y = visualmode()
	let g:vy_start_line = line("'<")
	let g:vy_start_col = virtcol("'<")
	let g:vy_end_line = line("'>")
	let g:vy_end_col = virtcol("'>")
endf

func! s:visual_swap() abort
	let s:vmode_x = visualmode()
	let s:vx_start_line = line("'<")
	let s:vx_start_col = virtcol("'<")
	let s:vx_end_line = line("'>")
	let s:vx_end_col = virtcol("'>")

	exec "norm! ".g:vy_start_line."G".g:vy_start_col."|".g:vmode_y.
				\ g:vy_end_line."G".g:vy_end_col."|p".
				\ s:vx_start_line."G".s:vx_start_col."|"
				"\ .s:vmode_x.
				"\ s:vx_end_line."G".s:vx_end_col."|"
endf

func! s:yank_line(reg) abort
	exec "norm! _\"".a:reg."y$"
endf


" Mappings "
imap <C-c> <Esc>
nmap s <Nop>
nmap Y _"wy$
xmap s <Nop>
xmap sa <Plug>(sandwich-add)
cnoremap <C-x> \%V
nnoremap <C-,> <C-w><
nnoremap <C-.> <C-w>>
nnoremap <C-=> <C-w>+
nnoremap <C-_> <C-w>-
nnoremap <C-w><C-c> <C-w><Esc>
nnoremap <expr> N 'nN'[v:searchforward]
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <silent> <C-i> <C-i>
nnoremap <silent> <Enter> o<Esc>
nnoremap <silent> <S-Enter> O<Esc>
nnoremap <silent> <Tab> <CMD>tabn<CR>
nnoremap <silent> U <CMD>UndotreeToggle<CR>
vnoremap <silent> <C-x> <CMD>call <SID>visual_yank()<CR>p<CMD>call <SID>visual_swap()<CR>

command! H Help
command! F Files
command! B Buffers


" Colour "
au ColorScheme * call s:edit_colorscheme()
func! s:edit_colorscheme() abort
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
		hi Search guifg=#eb6f92 guibg=#272c42
		hi IncSearch guifg=#272c42 guibg=#eb6f92 cterm=NONE
		hi! CocFloating guibg=#36383f
		set t_md=""
	endif
endf

au ColorScheme * call s:coc_highlight()
func! s:coc_highlight() abort
	hi! link CocErrorSign Error
	hi! link CocErrorFloat Error
	hi! link CocWarningSign WarningMsg
	hi! link CocWarningFloat WarningMsg

	hi CocErrorHighlight cterm=underline guisp=#ec6a88
	hi CocWarningHighlight cterm=underline guisp=#f6c177
	hi CocMenuSel guibg=#45474e
	hi clear CocUnderline
endf

set termguicolors
syn on
color fuzzy_colors
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
	nnoremap R <Plug>(coc-rename)
	nnoremap <silent> <C-c> :call coc#float#close_all(0)<CR>
	nnoremap <expr> K CocHasProvider('hover') ? CocAction('definitionHover') : "K"
	inoremap <expr> <C-d> coc#pum#visible() ? coc#pum#scroll(1) : "\<C-d>"
	inoremap <expr> <C-u> coc#pum#visible() ? coc#pum#scroll(0) : "\<C-u>"
	inoremap <expr> <C-y> coc#pum#visible() ? coc#pum#select_confirm() : coc#start()
	inoremap <expr> <C-l> "<CMD>call CocAction('showSignatureHelp')<CR>"
	inoremap <expr> <C-h> coc#float#has_float() ? coc#float#close_all(1) : "<CMD>call CocAction('showSignatureHelp')<CR>"

	" Fix highlight "
	call s:coc_highlight()
endf

au FileType help,netrw setl nu rnu cursorline
au FileType c call s:on_filetype_c()
func! s:on_filetype_c() abort
	call s:coc_highlight()
	hi link cDefine Define
	syn keyword Macro true false 
	syn keyword Conditional case default

	syn match Function "\<\h\w*\>\ze\_s*("
	syn match Macro "\<[A-Z_][0-9A-Z_]*\>"
	syn match Type "\(#\s*\)\@<!\<\h\w*\ze[ 	\n*]\+\(\h\w*[ 	\n]*[=;,(){}\[\]]\)"
	syn match Type "^struct[ 	\n]\+\zs\(\<\h\w*\)\ze[ 	\n]\+{"
	setlocal signcolumn=yes fo=qjlr
endf

au BufEnter *.S set filetype=asm
au FileType asm call s:on_filetype_asm()
func! s:on_filetype_asm() abort
	set ts=8		" tab_stop
endf

au FileType rust call s:on_filetype_rust()
func! s:on_filetype_rust() abort
	call s:coc_highlight()

	hi link rustEscape SpecialChar
	setlocal signcolumn=yes
	au! FileType rust setlocal signcolumn=yes " Call once
endf

au BufWinEnter * call s:check_read_stdin()
func! s:check_read_stdin() abort
	if get(v:argv, len(v:argv) - 1, '') == '-'
		set syntax=pager
		AnsiEsc
		setlocal nowrap
		setlocal concealcursor=nvic

		nmap <buffer> <silent> yy :call <SID>yank_commit_hash()<CR>
		func! s:yank_commit_hash() abort
			let s:lnum = line(".")
			let s:column = getpos(".")[2]
			call cursor(s:lnum, 1)
			if search("\\x\\{7}\\>", "c", s:lnum) == 0
				echo "No commit hash in current line"
				call cursor(s:lnum, s:column)
				return
			endif
			echo 
			norm! "wye
		endf
	endif
	" TODO: fix slow to move on to line with git hash (with j/k)
	" XXX Call only once "
	au! BufWinEnter
endf
