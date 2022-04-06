local lsp_installer = require "nvim-lsp-installer"
local cmp = require("cmp")

local servers = {
    "bashls",
    "pyright",
    "gopls",
    "tsserver",
    "clangd",
    "cssls",
    "dockerls",
    "html",
    "zk",
    "sqls",
    "rust_analyzer",
}

require('rust-tools').setup({})

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	path = "[Path]",
}

cmp.setup({
    formatting = {
        format = function(entry, vim_item)
            local menu = source_mapping[entry.source.name]
            vim_item.menu = menu
            return vim_item
        end,
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
    }
});

lsp_installer.on_server_ready(function(server)
  local opts = {
  }

  server:setup(opts)
end)
