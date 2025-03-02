" General settings " 
set nocompatible
set nu rnu
set tabstop=4 shiftwidth=4 textwidth=0
set scrolloff=0
set linebreak breakindent
set breakindentopt=shift:8,sbr
set showbreak=>
set wrap
set cpoptions+=n
set smartcase showmatch hlsearch
set wildmenu
set foldmethod=manual
set cursorline
set autoindent cindent
set showcmd
set splitright
set viewoptions=cursor,slash,unix
set formatoptions-=o
set winwidth=60

filetype on
filetype plugin on
filetype indent on

if has('persistent_undo')
	set undodir=$HOME/.vim/undodir
	set undofile
endif

let g:netrw_banner = 0

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
let g:lsp_preview_autoclose = 0
let g:lsp_preview_float = 0
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
"Plug 'neoclide/coc.nvim', { 'branch': 'release' }
"Plug 'Maxattax97/coc-ccls'
"Plug 'm-pilia/vim-ccls'
Plug 'rhysd/vim-healthcheck'

Plug 'junegunn/fzf.vim'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'prabirshrestha/async.vim'
Plug 'mbbill/undotree'
Plug 'vim-scripts/restore_view.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
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
nnoremap <C-j> 8<C-e>
nnoremap <C-k> 8<C-y>
" why the fuck do i need this, fuck vim
"inoremap k k
"cnoremap k k
"vnoremap k k
"onoremap k k
"nnoremap <C-w>k <C-w>k
"nnoremap <C-o> <C-o>

nnoremap <C-=> <C-w>+
nnoremap <C-_> <C-w>-
nnoremap <C-.> <C-w>>
nnoremap <C-,> <C-w><

"nnoremap <silent> <leader>e :Ex<CR>
"nnoremap <silent> <leader>q ZQ
"nnoremap <silent> <leader>w ZZ
nnoremap <silent> <leader>p "+p
nnoremap <silent> <leader>P "+P
nnoremap <silent> <leader>s :setlocal nowrap<CR>
nnoremap <silent> <leader>S :setlocal wrap<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>
nnoremap <silent> <C-c> :let @/=""<CR>
nnoremap <leader>, qq
nnoremap <leader>. @q

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
	autocmd BufEnter,WinEnter  * set wincolor=NormalCurrentWindow
	autocmd BufLeave,WinLeave * set wincolor=Normal
    "autocmd WinEnter * setlocal signcolumn=yes
    "autocmd WinLeave * setlocal signcolumn=no

	" Cursorline "
	autocmd BufEnter,WinEnter * set cursorline
	autocmd WinLeave * set nocursorline
augroup end

augroup filetype
	autocmd!

	" Vim "
	autocmd FileType help setlocal nu rnu cursorline nowrap
	autocmd WinEnter,WinNew *help* set winwidth=84
	autocmd WinLeave *help* set winwidth=60
	autocmd FileType netrw setlocal nu rnu cursorline nowrap

	" C "
	autocmd BufRead,BufNewFile *.c set filetype=c
	autocmd BufRead,BufNewFile *.h set filetype=c

	" Assembly "
	autocmd BufRead,BufNewFile *.s setlocal lisp

	" Man "
	autocmd BufNew,BufRead,WinEnter *\ manpage set cursorline
augroup end

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal tagfunc=lsp#tagfunc
	setlocal formatoptions-=o
	setlocal signcolumn=no

	syn keyword cdefine #define 
	syn match cmacro "\<\u\+\>"
	syn match ctypedef_type "\<\(\u\l\+\)\+\>"

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
