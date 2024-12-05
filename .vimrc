" General settings {{{ 
set nocompatible
set nu rnu
set tabstop=4 shiftwidth=4
set scrolloff=0
set linebreak breakindent
set breakindentopt=shift:8,sbr
set showbreak=>
set cpoptions+=n
set smartcase showmatch hlsearch
set wildmenu
set foldmethod=manual
set cursorline
set autoindent cindent
set showcmd
set splitright splitbelow

filetype on
filetype plugin on
filetype indent on

if has('persistent_undo')
	set undodir=$HOME/.vim/undodir
	set undofile
endif

let g:lsp_diagnostics_virtual_text_align = "after"
" }}}

" Colours {{{
set termguicolors
colorscheme rosepine_moon
syntax on

let c_functions=1
let c_function_pointers=1
" }}}

" Mappings {{{ 
let mapleader = ","
nnoremap <expr> j v:count == 0 ? 'gj' : "\<Esc>".v:count.'j'
nnoremap <expr> k v:count == 0 ? 'gk' : "\<Esc>".v:count.'k'
nnoremap gj j
nnoremap gk k
inoremap <C-c> <Esc>
nnoremap <C-j> 8<C-e>
nnoremap <C-k> 8<C-y>
nnoremap / :set hlsearch<CR>/

nnoremap <silent> <leader>q ZQ
nnoremap <silent> <leader>w ZZ
nnoremap <silent> <leader>e :Ex<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>
nnoremap <silent> <leader>s :set hlsearch!<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>m :Marks<CR>
nnoremap <silent> <leader>j :Jumps<CR>
nnoremap <silent> <leader>c :Changes<CR>

nnoremap <silent> <C-w>n :vert new<CR>
nnoremap <silent> <C-w><C-n> :vert new<CR>
nnoremap <silent> <C-w>m :new<CR>
nnoremap <silent> <C-w><C-m> :new<CR>

nnoremap <expr> o (line(".") - line("w0") > winheight(0) / 2) ? '<C-e>o' : 'o'
nnoremap <expr> O (line(".") - line("w0") > winheight(0) / 2) ? '<C-e>O' : 'O'
inoremap <expr> <CR> (line(".") - line("w0") > winheight(0) / 2) ? '<C-x><C-e><CR>' : '<CR>'
"nnoremap <silent> <expr> 'z'.v:count.'<CR>' ':call LineToNumber('.v:count.')<CR>'
" }}}

" Plugins {{{ 
call plug#begin('~/.vim/plugged')
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'sainnhe/everforest'

Plug 'prabirshrestha/vim-lsp'
Plug 'bergercookie/asm-lsp'
Plug 'junegunn/fzf.vim'
Plug 'sharkdp/bat'
Plug 'prabirshrestha/async.vim'
Plug 'mbbill/undotree'
Plug 'vim-scripts/restore_view.vim'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'easymotion/vim-easymotion'
Plug 'tikhomirov/vim-glsl'
call plug#end()
" }}}

" Vimscript {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType help set nu rnu cursorline
	autocmd FileType netrw set nu rnu cursorline
augroup end

augroup curorline_lnums
	autocmd!
	autocmd WinEnter * set cursorline
	autocmd WinLeave * set nocursorline
augroup end

augroup filetype_c
	autocmd!
	autocmd BufRead,BufNewFile *.c set filetype=c
	autocmd BufRead,BufNewFile *.h set filetype=c
augroup end

hi findfasterHighlight guifg=NONE guibg=#f6c177
function! FindFaster_f(str)
	syn keyword findfasterHighlight a:str
endfunction
function! s:findfaster_F()
endfunction

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nnoremap <buffer> gd <plug>(lsp-definition)
    nnoremap <buffer> gs <plug>(lsp-document-symbol-search)
    nnoremap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nnoremap <buffer> gr <plug>(lsp-references)
    nnoremap <buffer> gi <plug>(lsp-implementation)
    nnoremap <buffer> gt <plug>(lsp-type-definition)
    nnoremap <buffer> <leader>r <plug>(lsp-rename)
    nnoremap <buffer> [g <plug>(lsp-previous-diagnostic)
    nnoremap <buffer> ]g <plug>(lsp-next-diagnostic)
    nnoremap <buffer> K <plug>(lsp-hover)
	inoremap <buffer> <C-c> <Esc>
endfunction

augroup vim_glsl
	autocmd!
	autocmd! BufNewFile,BufRead *.glsl,*.vs,*.fs set filetype=glsl
augroup end

augroup lsp_clangd
	autocmd!
	autocmd User lsp_setup call lsp#register_server({
				\ 'name': 'clangd',
				\ 'cmd': { server_info->['clangd'] },
				\ 'allowlist': ['c'],
				\ })
	autocmd FileType c setlocal omnifunc=lsp#complete
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup end
" }}}
