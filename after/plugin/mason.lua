local handlers = require("handlers")
local lspconfig = require("lspconfig")

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"jsonls",
		"pyright",
		"ts_ls",
		"gopls",
		"eslint",
		"clangd",
		"rust_analyzer",
		"tailwindcss",
		"sqlls",
		"cssls",
		"bashls",
		"dockerls",
		"yamlls",
		"html",
		"golangci_lint_ls",
		"zls",
	},
})
handlers.setup()

local navic = require("nvim-navic")

local inlay_hints = require("lsp-inlayhints")

local function on_attach(client, bufnr)
	handlers.on_attach(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
	if client.server_capabilities.inlayHintProvider then
		inlay_hints.on_attach(client, bufnr)
	end
end

lspconfig.lua_ls.setup({
	on_attach = on_attach,
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
	on_attach = on_attach,
	capabilities = handlers.capabilities,
	settings = {
		gopls = {
			codelenses = {
				generate = true,
				gc_details = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				constantValues = true,
				assignVariableTypes = true,
				functionTypeParameters = true,
				rangeVariableTypes = true,
			},
			gofumpt = true,
		},
	},
})

lspconfig.golangci_lint_ls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
	settings = require("jsonls").settings,
	setup = require("jsonls").setup,
})

lspconfig.ts_ls.setup({
	on_attach = on_attach,
	root_dir = require("lspconfig.util").root_pattern(".git"),
	capabilities = handlers.capabilities,
	settings = {
		typescript = {
			format = {
				enable = false,
			},
		},
	},
})

lspconfig.pyright.setup({
	on_attach = on_attach,
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

lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.dockerls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.sqlls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.tailwindcss.setup({
	on_attach = function(client, bufnr)
		require("tailwindcss-colors").buf_attach(bufnr)
		on_attach(client, bufnr)
	end,
	root_dir = require("lspconfig.util").root_pattern(".git"),
	capabilities = handlers.capabilities,
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					{ "clsx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
					{ "classnames\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
					":\\s*?[\"'`]([^\"'`]*).*?,",
					"(?:const|let|var)\\s+[\\w$_][_\\w\\d]*\\s*=\\s*['\\\"](.*?)['\\\"]",
					{ "(?:twMerge|twJoin)\\(([^;]*)[\\);]", "[`'\"`]([^'\"`;]*)[`'\"`]" },
				},
			},
			classAttributes = { "class", "className", "classes" },
		},
	},
})

-- lspconfig.eslint.setup({
-- 	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
-- 	-- 		buffer = bufnr,
-- 	-- 		command = "EslintFixAll",
-- 	-- 	})
-- 	-- end,
-- 	on_attach = handlers.on_attach,
-- 	capabilities = handlers.capabilities,
-- 	-- cmd = { "eslint_d", "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--" },
-- 	settings = {
-- 		run = "onSave",
-- 		useFlatConfig = true,
-- 		eslint = {
-- 			run = "onSave",
-- 			useFlatConfig = true,
-- 			experimental = {
-- 				useFlatConfig = true,
-- 			},
-- 		},
-- 	},
-- 	root_dir = require("lspconfig.util").root_pattern(".git"),
-- })
--
lspconfig.zls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})
