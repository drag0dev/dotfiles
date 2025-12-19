vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    source = "always",
  },
  underline = true,
  severity_sort = true,
  float = {
    source = "always",
  },
})

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
        "lua_ls",
        "vimls",
        "bashls",
        "pyright",
        "gopls",
        "ts_ls",
        "clangd",
        "cssls",
        "dockerls",
        "html",
        "rust_analyzer",
        "zls",
        "elixirls",
        "clojure_lsp",
        "bashls",
        "coq_lsp",
        "hls",
        "ocamllsp"
    },
}

vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
vim.lsp.enable("lua_ls")
vim.lsp.enable("vimls")
vim.lsp.enable("bashls")
vim.lsp.enable("pyright")
vim.lsp.enable("gopls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("cssls")
vim.lsp.enable("dockerls")
vim.lsp.enable("html")
vim.lsp.enable("zls")
vim.lsp.enable("elixirls")
vim.lsp.enable("clojure_lsp")
vim.lsp.enable("bashls")
vim.lsp.enable("coq_lsp")
vim.lsp.enable("ocamllsp")

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.rs",
    callback = function()
        vim.lsp.buf.format({ async = false})
    end,
})
