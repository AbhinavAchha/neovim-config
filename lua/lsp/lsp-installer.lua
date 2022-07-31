local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	if server.name == "jsonls" then
		local custom_opts = require("lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", custom_opts, opts)
	elseif server.name == "sumneko_lua" then
		local custom_opts = require("lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", custom_opts, opts)
	elseif server.name == "pyright" then
		local custom_opts = require("lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", custom_opts, opts)
	elseif server.name == "tsserver" then
		local custom_opts = require("lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", custom_opts, opts)
	elseif server.name == "gopls" then
		local custom_opts = require("lsp.settings.gopls")
		opts = vim.tbl_deep_extend("force", custom_opts, opts)
	end

	server:setup(opts)
end)
