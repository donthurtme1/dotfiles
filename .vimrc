" General settings {{{ 
set nocompatible
set nu rnu
set tabstop=4 shiftwidth=4 textwidth=0
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
set splitright
set viewoptions=cursor,slash,unix

filetype on
filetype plugin on
filetype indent on

if has('persistent_undo')
	set undodir=$HOME/.vim/undodir
	set undofile
endif


let g:lsp_completion_docuentation_delay = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 0
let g:lsp_diagnostics_highlights_delay = 250
let g:lsp_diagnostics_signs_delay = 250
let g:lsp_diagnostics_virtual_text_align = "after"
let g:lsp_diagnostics_virtual_text_prefix = "~ "
let g:lsp_diagnostics_virtual_text_wrap = "truncate"
let g:lsp_document_highlight_enabled = 0
let g:lsp_preview_autoclose = 0
let g:lsp_preview_float = 1
let g:lsp_semantic_delay = 10
let g:lsp_semantic_enabled = 1
let g:lsp_max_buffer_size = 1000000
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
" why the fuck do i need this, fuck vim
inoremap k k
cnoremap k k
vnoremap k k
nnoremap <C-w>k <C-w>k

nnoremap <C-=> <C-w>+
nnoremap <C-_> <C-w>-
nnoremap <C-.> <C-w>>
nnoremap <C-,> <C-w><

nnoremap <silent> <leader>q ZQ
nnoremap <silent> <leader>w ZZ
nnoremap <silent> <leader>e :Ex<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>
nnoremap <silent> <leader>s :let @/=""<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>m :Marks<CR>
nnoremap <silent> <leader>j :Jumps<CR>
nnoremap <silent> <leader>c :Changes<CR>
nnoremap <silent> <leader>t :Lines<CR>
nnoremap <silent> <leader>/ :History/<CR>
nnoremap <silent> <leader>p "+p
nnoremap <silent> <leader>P "+P

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
" }}}

" Plugins {{{ 
call plug#begin('~/.vim/plugged')
Plug 'rose-pine/vim', { 'as': 'rosepine' }
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'sainnhe/everforest'

Plug 'prabirshrestha/vim-lsp'
Plug 'junegunn/fzf.vim'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'prabirshrestha/async.vim'
Plug 'mbbill/undotree'
Plug 'vim-scripts/restore_view.vim'
call plug#end()
" }}}

" Colours {{{
set termguicolors
colorscheme rosepine_moon
syntax on

set t_ZH= " disable italics
hi Normal guibg=#232135
hi Macro guifg=#f6c177
hi Include guifg=#3e8fb0
hi SpecialChar guifg=#3e8fb0
hi SignColumn guibg=#232135
hi StatusLineNC guibg=#232135
hi MatchParen guifg=NONE
hi Folded guifg=#c4a7e7

hi link LspSemanticVariable Normal
hi link LspSemanticProperty Normal
hi link LspSemanticParameter Define
" }}}

" Vimscript {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType help set nu rnu cursorline
	autocmd FileType netrw set nu rnu cursorline
augroup end

augroup curorline
	autocmd!
	autocmd WinEnter * set cursorline
	autocmd WinLeave * set nocursorline
augroup end

augroup filetype_c
	autocmd!
	autocmd BufRead,BufNewFile *.c set filetype=c
	autocmd BufRead,BufNewFile *.h set filetype=c
augroup end

augroup filetype_s
	autocmd!
	autocmd BufRead,BufNewFile *.s setlocal lisp
augroup end

hi findfasterHighlight guifg=NONE guibg=#f6c177
function! FindFaster_f(str)
	syn keyword findfasterHighlight a:str
endfunction

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal tagfunc=lsp#tagfunc
    setlocal signcolumn=yes
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
    nnoremap <buffer> K <plug>(lsp-hover-float)
	inoremap <buffer> <C-c> <Esc>
endfunction

augroup lsp_clangd
	autocmd!
	autocmd User lsp_setup call lsp#register_server({ 'name': 'clangd', 'cmd': { server_info->['clangd'] }, 'allowlist': ['c'], })
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
	autocmd FileType c call s:on_lsp_buffer_enabled()
augroup end
" }}}
