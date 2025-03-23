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

local function on_attach(client, bufnr)
	handlers.on_attach(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
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
	-- settings = require("jsonls").settings,
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
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				-- check for both yaml and yml
				-- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.20.13/all.json"] = "/*.{yml,yaml}",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/refs/heads/main/schema/compose-spec.json"] = "docker-compose*.yml",

				["docker-compose*.yaml"] = "https://raw.githubusercontent.com/compose-spec/compose-spec/refs/heads/main/schema/compose-spec.json",
				["docker-compose*.yml"] = "https://raw.githubusercontent.com/compose-spec/compose-spec/refs/heads/main/schema/compose-spec.json",
			},
		},
	},
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
-- 	settings = {
-- 		codeAction = {
-- 			disableRuleComment = {
-- 				enable = true,
-- 				location = "separateLine",
-- 			},
-- 			showDocumentation = {
-- 				enable = true,
-- 			},
-- 		},
-- 		codeActionOnSave = {
-- 			enable = true,
-- 			mode = "all",
-- 		},
-- 		experimental = {
-- 			useFlatConfig = true,
-- 		},
-- 		format = false,
-- 		nodePath = "",
-- 		onIgnoredFiles = "off",
-- 		problems = {
-- 			shortenToSingleLine = false,
-- 		},
-- 		quiet = false,
-- 		rulesCustomizations = {},
-- 		run = "onSave",
-- 		useESLintClass = false,
-- 		validate = "on",
-- 		workingDirectory = {
-- 			mode = "location",
-- 		},
-- 	},
-- 	on_attach = handlers.on_attach,
-- 	capabilities = handlers.capabilities,
-- })

lspconfig.zls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})
