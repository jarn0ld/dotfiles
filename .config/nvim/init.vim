set fileformat=unix
set encoding=utf-8
set bs=indent,eol,start
set noruler
set laststatus=2
set statusline=%f\ %l\ %c\ %L
set number
set relativenumber
set nohlsearch
set incsearch
set ignorecase
set smartcase
set listchars=trail:·,tab:>>
set list
set colorcolumn=80
set clipboard+=unnamedplus
set complete=.,w,b,u,t
set wildignore+=dumps
set wildignore+=*.pyc
set wildignore+=tmp
set wildchar=<Tab> wildmenu wildmode=full
set shiftwidth=4
set softtabstop=4
set expandtab
set tags=tags;/
set hidden
set nobackup
set nowritebackup
set signcolumn=yes

function FormatBuffer()
  if !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction

augroup dtracker
    au BufRead,BufEnter */dtracker/* set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
    au BufRead,BufEnter */dtracker-*/* set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
    "autocmd BufWritePre *.cpp,*.h,*.hpp :call FormatBuffer()
augroup END

function FormatPython()
    call CocAction('format')
    call CocAction('runCommand', 'python.sortImports')
endfunction

augroup pythonformat
autocmd BufWritePost *.py :call FormatPython()
augroup END


autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal expandtab

highlight Normal ctermbg=none
highlight ColorColumn ctermbg=darkred

call plug#begin()

nnoremap <leader>w f,wi<BS><CR><ESC>

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

let g:gruvbox_guisp_fallback = "bg"
colorscheme gruvbox
set background=dark

" fzf
nnoremap <leader>p :GFiles<cr>

"vnoremap y "0y
"vnoremap p "0p

"
" Clang-format hook
"
map <C-K> :py3f ~/bin/clang-format.py<cr>

"
" Fast split switching
"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"
" center curser after search
"
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz

"
" ctrp-p
"
"let g:ctrlp_by_filename = 1
"let g:ctrlp_regexp = 0
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|venv)$'
"set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

"
" jedi-vim
"
" no docstring popups
" autocmd FileType python setlocal completeopt-=preview

"
" coc
"
nmap <silent> <leader>t :CocCommand clangd.switchSourceHeader<CR>
xmap <silent> <leader>t :CocCommand clangd.switchSourceHeader<CR>
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" add download status to vim's status line
set statusline+=\ %{coc#status()}

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
