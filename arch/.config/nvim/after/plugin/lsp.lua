local mason = require("mason")
mason.setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
 }

require("mason-lspconfig").setup {
    ensure_installed = {
        "sumneko_lua",
        "vimls",
        "bashls",
        "pyright",
        "gopls",
        "tsserver",
        "clangd",
        "cssls",
        "dockerls",
        "html",
        "rust_analyzer",
        "zls",
    },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup { capabilities = capabilities }
lspconfig.vimls.setup { capabilities = capabilities }
lspconfig.bashls.setup { capabilities = capabilities }
lspconfig.pyright.setup { capabilities = capabilities }
lspconfig.gopls.setup { capabilities = capabilities }
lspconfig.tsserver.setup { capabilities = capabilities }
lspconfig.clangd.setup { capabilities = capabilities }
lspconfig.cssls.setup { capabilities = capabilities }
lspconfig.dockerls.setup { capabilities = capabilities }
lspconfig.html.setup { capabilities = capabilities }
--lspconfig.rust_analyzer.setup { capabilities = capabilities }  rust-tools does this
lspconfig.zls.setup { capabilities = capabilities }
lspconfig.elixirls.setup {
    cmd = {"/home/drago/.local/share/nvim/lsp_servers/elixir/elixir-ls/language_server.sh", "elixir-ls"},
    capabilities = capabilities
}
