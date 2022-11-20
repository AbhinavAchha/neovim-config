local handlers = require("handlers")
local lspconfig = require("lspconfig")

handlers.setup()
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "sumneko_lua", "jsonls", "pyright", "tsserver", "gopls" },
})

lspconfig.sumneko_lua.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig.gopls.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})

lspconfig.jsonls.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
	settings = require("jsonls").settings,
	setup = require("jsonls").setup,
})

lspconfig.tsserver.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
	settings = {
		typescript = {
			validate = {
				linting = false,
			},
		},
		javascript = {
			validate = {
				linting = false,
			},
		},
		document_formatting = false,
	},
})

lspconfig.pyright.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				useLibraryCodeForTypes = true,
			},
		},
	},
})
