local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "c.lsp.configs"
require("c.lsp.handlers").setup()
