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

let mapleader =  " "
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

nnoremap <leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>d :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>h :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>f :lua vim.diagnostic.open_float()<CR>
nnoremap <leader>r :lua vim.lsp.buf.rename()<CR>
nmap [d <Plug>(GitGutterPreviewHunk)

" show empty chars
set listchars=trail:·
set list
call plug#begin('~/.vim/plugged')
"Plug 'wadackel/vim-dogrun'
"Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'whatyouhide/vim-gotham'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'

Plug 'vim-airline/vim-airline'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

Plug 'airblade/vim-gitgutter'

Plug 'simrat39/rust-tools.nvim'
Plug 'mfussenegger/nvim-dap'

" funny elixir stuff
Plug 'elixir-editors/vim-elixir'

"snippets
Plug 'rust-lang/rust.vim'

call plug#end()

lua require("drago")

colorscheme nord
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
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer', keyword_length = 5 },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig')["bashls"].setup {
    capabilities = capabilities
  }
  require('lspconfig')["pyright"].setup {
    capabilities = capabilities
  }
  require('lspconfig')["gopls"].setup {
    capabilities = capabilities
  }
  require('lspconfig')["tsserver"].setup {
    capabilities = capabilities
  }
  require('lspconfig')["clangd"].setup {
    capabilities = capabilities
  }
  require('lspconfig')["cssls"].setup {
    capabilities = capabilities
  }
  require('lspconfig')["dockerls"].setup {
    capabilities = capabilities
  }
  require('lspconfig')["html"].setup {
    capabilities = capabilities
  }
  require('lspconfig')["sqls"].setup {
    capabilities = capabilities
  }
  require('lspconfig')["elixirls"].setup {
    cmd = {"/home/drago/.local/share/nvim/lsp_servers/elixir/elixir-ls/language_server.sh", "elixir-ls"},
    capabilities = capabilities
  }
EOF
