set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set nowrap
set noswapfile
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set colorcolumn=100
set signcolumn=yes
set background=dark

call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'
Plug 'wadackel/vim-dogrun'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'whatyouhide/vim-gotham'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
call plug#end()

colorscheme gotham

let mapleader =  " "


fun! TrimWhiteSpaces()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup DRAGO
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpaces()
augroup END
