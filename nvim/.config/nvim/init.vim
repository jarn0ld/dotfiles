set fileformat=unix
set encoding=utf-8

set guicursor=
" Workaround some broken plugins which set guicursor indiscriminately.
autocmd OptionSet guicursor noautocmd set guicursor=

set bs=indent,eol,start
set noruler
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
set completeopt-=preview
set wildignore+=dumps
set wildignore+=*.pyc
set wildignore+=tmp
set wildchar=<Tab> wildmenu wildmode=full
set tags=tags;/
set hidden
set nobackup
set nowritebackup
set noswapfile
set signcolumn=yes
set background=dark

set softtabstop=4
set shiftwidth=4
set expandtab

autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal expandtab

autocmd FileType cpp setlocal shiftwidth=4
autocmd FileType cpp setlocal softtabstop=4
autocmd FileType cpp setlocal expandtab

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_sorting = "none"
let g:gruvbox_guisp_fallback = "bg"
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1
let g:isort_command = 'isort'

function FormatBuffer()
  if !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction

augroup dtracker
    au BufRead,BufEnter */dtracker/radio/* set tabstop=2 shiftwidth=2 noexpandtab
    au BufRead,BufEnter */dtracker/common/* set tabstop=2 shiftwidth=2 noexpandtab
    au BufRead,BufEnter */dtracker-*/radio/* set tabstop=2 shiftwidth=2 noexpandtab
    au BufRead,BufEnter */dtracker-*/common/* set tabstop=2 shiftwidth=2 noexpandtab
    "autocmd BufWritePre *.cpp,*.h,*.hpp :call FormatBuffer()
augroup END

highlight Normal ctermbg=none
highlight ColorColumn ctermbg=darkred

call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'neovim/nvim-lspconfig'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'nvim-lua/completion-nvim'
Plug 'tell-k/vim-autopep8'
Plug 'stsewd/isort.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

colorscheme gruvbox

" fzf
nnoremap <C-p> :Files<cr>

"vnoremap y "0y
"vnoremap p "0p

"
" Fast split switching
"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader>w f,wi<BS><CR><ESC>

lua << EOF

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=false }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>zz', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>zz', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  require'completion'.on_attach(client, bufnr)
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches

nvim_lsp["pyright"].setup {
  on_attach = on_attach;
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = false
      }
    }
  };
}
nvim_lsp["jsonls"].setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}
nvim_lsp["clangd"].setup { on_attach = on_attach }
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Disable signs
    virtual_text = false,
  }
)
-- local servers = { "pyright", "clangd" }
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup { on_attach = on_attach }
-- end

EOF
