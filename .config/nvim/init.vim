call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pboettch/vim-cmake-syntax'
Plug 'kien/ctrlp.vim'

call plug#end()

filetype plugin indent on
syntax on

set t_Co=256
set background=dark
colorscheme gruvbox

set fileformat=unix
set encoding=utf-8

set bs=indent,eol,start

set laststatus=2
set statusline+=%F

set ruler
set number
set relativenumber

set nohlsearch
set incsearch
set ignorecase
set smartcase

set listchars=trail:·,tab:>>
set list

set colorcolumn=120
highlight ColorColumn ctermbg=black

set clipboard+=unnamedplus

set complete=.,w,b,u,t
set wildignore+=dumps
set wildignore+=*.pyc
set wildignore+=tmp
set wildchar=<Tab> wildmenu wildmode=full

set tags=tags;/

"vnoremap y "0y
"vnoremap p "0p

augroup ProjectSetup
au BufRead,BufEnter /home/julian/source/dtracker* set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
augroup END

set shiftwidth=4
set softtabstop=4
set expandtab

autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal expandtab

"
" Clang-format hook
"
map <C-K> :py3f ~/clang-format.py<cr>

"
" Fast split switching
"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"
" ctrp-p
"
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 1

"
" jedi-vim
"
" no docstring popups
autocmd FileType python setlocal completeopt-=preview

"
" coc
"
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" add download status to vim's status line
set statusline+=" %{coc#status()}"
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
