local lsp_installer = require "nvim-lsp-installer"

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
    "emmet_ls",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

lsp_installer.on_server_ready(function(server)
  local opts = {
  }

  server:setup(opts)
end)
