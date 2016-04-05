python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

execute pathogen#infect()
"set t_Co=256
"let g:solarized_termcolors=256
"set mouse=a
set colorcolumn=80
syntax enable
filetype plugin indent on
set cursorline

set background=dark
colorscheme solarized

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set laststatus=2
set spell spelllang=en_us
set clipboard=unnamed

set listchars=tab:▸\ ,eol:¬
set list

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
