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
set nowrap
set clipboard+=unnamedplus
set updatetime=200
set listchars=trail:·
set list

let mapleader =  " "

" disable arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" telescope
nnoremap <leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>fj :lua require('telescope.builtin').live_grep()<CR>

" harpoon
nnoremap <C-a> :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

" lsp
nnoremap <leader>d :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>1 :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>w :lua vim.diagnostic.open_float()<CR>
nnoremap <leader>r :lua vim.lsp.buf.rename()<CR>

" splits
nnoremap <leader>sh :split<CR>
nnoremap <leader>sv :vsplit<CR>

" git
nmap [d <Plug>(GitGutterPreviewHunk)
nmap [u <Plug>(GitGutterUndoHunk)
nmap [a <Plug>(GitGutterStageHunk)

" moves
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" open definition on the side
nnoremap <leader>od :vsplit<CR> <C-w>L :lua vim.lsp.buf.definition()<CR>

" disable auto foramtting for zig
let g:zig_fmt_autosave = 0

" ocaml stuff
set rtp+=home/drago/.opam/default/share/merlin/vim"

call plug#begin('~/.vim/plugged')
" colorschemes
Plug 'whatyouhide/vim-gotham'

" tools
Plug 'vim-airline/vim-airline'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ThePrimeagen/harpoon'
Plug 'tpope/vim-commentary'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'shurizzle/inlay-hints.nvim'
" i guess you need a beefy cpu for tabnine
" Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
" Plug 'Exafunction/codeium.vim'
Plug 'sourcegraph/sg.nvim', { 'do': 'nvim -l build/init.lua' }
Plug 'scalameta/nvim-metals'


" git
Plug 'airblade/vim-gitgutter'

" random dep?
Plug 'mfussenegger/nvim-dap'

" languages
Plug 'elixir-editors/vim-elixir'
Plug 'ziglang/zig.vim'
Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'
Plug 'gleam-lang/gleam.vim'
Plug 'jfecher/vale.vim'

" snippets
Plug 'rafamadriz/friendly-snippets'

call plug#end()

colorscheme gotham256
syntax on
filetype plugin indent on

fun! TrimWhiteSpaces()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup DRAGO
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpaces()
augroup END

set completeopt=menu,menuone,noselect

lua <<EOF
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
end
EOF
