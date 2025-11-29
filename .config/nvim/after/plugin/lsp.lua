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
        "clojure_lsp",
    },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup { capabilities = capabilities }
lspconfig.vimls.setup { capabilities = capabilities }
lspconfig.bashls.setup { capabilities = capabilities }
lspconfig.pyright.setup { capabilities = capabilities }
lspconfig.gopls.setup { capabilities = capabilities }
lspconfig.ts_ls.setup { capabilities = capabilities }
lspconfig.clangd.setup { capabilities = capabilities }
lspconfig.cssls.setup { capabilities = capabilities }
lspconfig.dockerls.setup { capabilities = capabilities }
lspconfig.html.setup { capabilities = capabilities }
--lspconfig.rust_analyzer.setup { capabilities = capabilities }  rust-tools does this
lspconfig.zls.setup { capabilities = capabilities }
lspconfig.elixirls.setup {
    cmd = {"/home/drago/.local/share/nvim/mason/packages/elixir-ls/language_server.sh", "elixir-ls"},
    capabilities = capabilities
}
lspconfig.clojure_lsp.setup { capabilities = capabilities }
lspconfig.ocamllsp.setup { capabilities = capabilities }
lspconfig.gleam.setup { capabilities = capabilities }

--
-- METALS
local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

metals_config.init_options.statusBarProvider = "on"
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

local api = vim.api
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

require'lspconfig'.phpactor.setup{
    on_attach = on_attach,
    init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
    }
}
