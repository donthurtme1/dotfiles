let g:wordmotion_spaces=['\S\@<=[->_.]\S\@=']

" Plugins " 
call plug#begin('~/.vim/plugged')
	" essential / simple "
	Plug '~/vimscript/fuzzy_colors' "TODO: rename to moondust or something
	"Plug '~/vimscript/man-resize' "TODO: make it better
	"Plug 'mg979/vim-visual-multi', "TODO: make this not suck

	Plug 'chaoren/vim-wordmotion'
	Plug 'machakann/vim-sandwich'
	Plug 'itchyny/vim-highlighturl'
	Plug 'jasonccox/vim-wayland-clipboard'
	Plug 'tpope/vim-fugitive'
	Plug 'vim-utils/vim-man'

	" non-essential / i don't like "
	" TODO: use ctags instead of coc for everything except errors/warnings
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
	Plug 'mbbill/undotree'
	Plug 'junegunn/fzf.vim'
call plug#end()


" General settings " 
set nu rnu
set tabstop=4 shiftwidth=4 noexpandtab
set smartcase hlsearch
set nocompatible wildmenu signcolumn=no
set foldmethod=manual
set cursorline autoindent cindent showcmd
set cinoptions+=:0,l1,t0
set viewoptions=cursor,slash,unix formatoptions=qjlr
set lazyredraw
set linebreak breakindent breakindentopt=shift:8
set viminfo='256,<256,%64 
set incsearch ignorecase 
set autowriteall noequalalways 
set cpoptions-=z 
set nrformats+=alpha
set undodir=$HOME/.vim/undodir undofile
set ssop=buffers,curdir,folds,help,tabpages,winsize
set ttyscroll=0 title
set statusline=%<%f\ %h%m%r%=pos:%l,%v\ \ \ \ %L\ lines\ \ \ %P
set rulerformat=%38(%=pos:%l,%v\ \ \ \ %L\ lines\ \ \ %P%)
set tags+=./tags
filetype on

" folding "
set fillchars=fold:\ 
set foldtext=substitute(getline(v:foldstart),'\	','\ \ \ \ ',1)
	\.'\ \ \ \ \...\ \ \ \ '
	\.(v:foldend\ -\ v:foldstart\ +\ 1)
	\.'\ lines'

" netrw
let g:netrw_banner = 0
let g:netrw_preview = 1
let g:netrw_alto = 1

" visual multi
let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps['Exit'] = '<C-c>'
let g:VM_maps['Add Cursor Down'] = '<C-j>'
let g:VM_maps['Add Cursor Up'] = '<C-k>'
"let g:VM_maps['Add Cursor At Pos'] = '<Space>'
let g:VM_maps['Visual All'] = '\a'

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

func TabLineSettings()
	let s = ''
	let i = 1
	while i <= tabpagenr('$')
		" select the highlighting
		if i == tabpagenr()
			let title_hi = '%#TabLineSel#'
			let count_hi = '%#Title#'
		else
			let title_hi = '%#TabLine#'
			let count_hi = '%#Title#'
		endif

		let wincount = ''
		if tabpagewinnr(i, '$') > 1
			let wincount .= title_hi . ' ' . count_hi . tabpagewinnr(i,'$')
		endif

		let modified = ''
		let s .= wincount . title_hi . modified . ' '

		let buflist = tabpagebuflist(i)
		let winnr = tabpagewinnr(i)
		let bufnr = buflist[winnr - 1]
		let file = bufname(bufnr)
		let buftype = getbufvar(bufnr, 'buftype')
		if buftype == 'nofile'
			if file =~ '\/.'
				let file = substitute(file, '.*\/\ze.', '', '')
			endif
		else
			let file = fnamemodify(file, ':p:t')
		endif
		if file == ''
			let file = '[No Name]'
		endif
		let s .= file . ' '
		let i += 1
	endwhile

	let s ..= '%#TabLineFill#%T '
	return s
endf
set tabline=%!TabLineSettings()


" Mappings "
map s <Nop>
map  <C-c> <Esc>
imap <C-c> <Esc>
snoremap <C-c> <Esc>
nmap <space>   g
nmap <S-space> g
omap "w "+
xmap sa <Plug>(sandwich-add)
"TODO: improve sandwich delete
xmap sd <Plug>(sandwich-delete)

noremap <C-w><C-c> <C-w><Esc>
noremap <expr> N 'nN'[v:searchforward]
noremap <expr> n 'Nn'[v:searchforward]
nnoremap Y _"wy$
nnoremap <C-,> <C-w><
nnoremap <C-.> <C-w>>
nnoremap <C-=> <C-w>+
nnoremap <C-_> <C-w>-
nnoremap <silent> <C-i> <C-i>
nnoremap <silent> <Enter> o<Esc>
nnoremap <silent> <S-Enter> O<Esc>
nnoremap <silent> <Tab> gt
nnoremap <silent> U <CMD>UndotreeToggle<CR>

func! s:i_ctrl_enter()
	let pos = getpos('.')
	let save = @n
	let @n = "\n"
	put n
	let @n = save
	call setpos('.', pos)
endf
inoremap <silent> <expr> <C-enter> "<Esc><CMD>call <SID>i_ctrl_enter()<CR>".
			\ (match(getline('.'), "^[ 	]*$") == -1 ? "gi" : "S")

vnoremap > >gv
vnoremap < <gv
vnoremap :s/ :s/\%V
vnoremap <silent> * "vy<CMD>let @/=@v<CR>n
vnoremap <silent> # "vy<CMD>let @/=@v<CR>N
vnoremap <silent> <C-x> <CMD>call <SID>visual_yank()<CR>p<CMD>call <SID>visual_swap()<CR>

" Custom motions "
map <silent> gw <CMD>call search("\\v([0-9A-Za-z]+\|\\_s@<=\\S)", 'W')<CR>
map <silent> gb <CMD>call search("\\v([0-9A-Za-z]+\|\\_s@<=\\S)", 'bW')<CR>
"map <silent> e <CMD>call search("\\v([0-9A-Za-z]+\|\\S\\_s@=)",  'eW')<CR>

vmap <expr> <silent> gw repeat(
			\ "<CMD>call search('\\v([0-9A-Za-z]+\|\\_s@<=\\S)', 'W')<CR>",
			\ max([v:count, 1]))
"vmap <expr> <silent> e repeat(
"			\ "<CMD>call search('\\v([0-9A-Za-z]+\|\\S\\_s@=)', 'eW')<CR>",
"			\ max([v:count, 1]))

omap <expr> <silent> gw "<CMD>norm v".max([v:count, 1])."gw<CR>"
"omap <expr> <silent> e  "<CMD>norm v".max([v:count, 1])."e<CR>"

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
		hi! link CursorLine Normal
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
" TODO how to make this work
"hi! link CursorLineFold CursorLineNr
hi Todo guibg=#1c1e26


" Autocommands "
au TabEnter * norm! :<Esc>

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

au VimResized * exec "norm! \<C-w>=zz"

au User CocNvimInit call s:on_coc_start()
func! s:on_coc_start() abort
	nnoremap gd <Plug>(coc-definition)
	nnoremap <expr> gs winheight(0) * 2.5 < winwidth(0) ?
					\ "<CMD>call CocAction('jumpDefinition', 'vsplit')<CR>" :
					\ "<CMD>call CocAction('jumpDefinition', 'split')<CR>"

	nnoremap R <Plug>(coc-rename)
	nnoremap <silent> <C-c> <CMD>call coc#float#close_all(0)<CR>
	nnoremap <expr> K CocHasProvider('hover') ?
					\ "<CMD>call CocAction('definitionHover')<CR>" : "K"

	inoremap <expr> <C-d> coc#pum#visible() ? coc#pum#scroll(1) : "\<C-d>"
	inoremap <expr> <C-u> coc#pum#visible() ? coc#pum#scroll(0) : "\<C-u>"
	inoremap <expr> <C-y> coc#pum#visible() ? coc#pum#select_confirm() : coc#start()

	inoremap <expr> <C-h> coc#float#has_float() ? coc#float#close_all(1) :
						\ "<CMD>call CocAction('showSignatureHelp')<CR>"

	" Fix highlight "
	call s:coc_highlight()
	au SourcePost .vimrc call s:on_coc_start()
endf

au FileType help,netrw setl nu rnu cursorline
au FileType c call s:on_filetype_c()
func! s:on_filetype_c() abort
	call s:coc_highlight()
	hi link cDefine Define
	syn keyword Macro true false 
	syn keyword Conditional case default
	syn keyword Todo contained NOTE

	syn match Function "\<\h\w*\ze\_s*("
	syn match Macro "\<[A-Z_][0-9A-Z_]*\>"

	" variable or function definition
	syn match Type "\v((\_^|;|\(|,)\_s*((const|static|inline|struct|enum|extern|register)\_s+)*)@<=\h\w*\ze[ \t\n*]+\h\w*"
	" typecast
	syn match Type "\v((<\h\w*\s*)@<!\(\s*((const|static|inline|struct|enum|extern|register)\_s+)*)@<=\h\w*\ze\s*\**\)"
	syn match Type "\v(return\s+\()@<=\h\w*\ze\s*\**\)"
	" struct/enum definition
	syn match Type "\v((struct|enum)\_s+)@<=\h\w*\ze\_s*\{"

	"imap <C-y> <C-x><C-o>

	set path+=include,./include,../include
	set path+=src,./src,../src
	set fo=qjlr
endf

au BufEnter *.S set filetype=asm
au FileType asm call s:on_filetype_asm()
func! s:on_filetype_asm() abort
	"setlocal ts=8		" tab_stop
endf

au FileType rust call s:on_filetype_rust()
func! s:on_filetype_rust() abort
	call s:coc_highlight()

	hi link rustEscape SpecialChar
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
