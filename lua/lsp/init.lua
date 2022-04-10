local setup_ok, _ = pcall(require, "lspconfig")
if not setup_ok then
	return
end

require("lsp.lsp-installer")
require("lsp.handlers").setup()
