local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
pcall(function()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end)

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"jsonls",
		"pyright",
		"ts_ls",
		"gopls",
		"clangd",
		"rust_analyzer",
		"tailwindcss",
		"cssls",
		"bashls",
		"dockerls",
		"yamlls",
		"html",
		"golangci_lint_ls",
		"zls",
	},
	handlers = {
		function(server)
			require("lspconfig")[server].setup({
				-- on_attach = function(client, bufnr)
				-- 	lsp_keymaps(bufnr)
				-- end,
				capabilities = capabilities,
			})
		end,
	},
})

-- global, dependable LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local buf = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end

		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, noremap = true, desc = desc })
		end

		-- don’t use "<cmd>lua ...<CR>" strings; bind the functions
		local cap = client.server_capabilities

		if cap.definitionProvider then
			map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
			map("n", "gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", "LSP: Go to declaration")
			map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
		end

		if cap.hoverProvider then
			map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
		end

		if cap.referencesProvider then
			map("n", "gr", vim.lsp.buf.references, "LSP: References")
		end

		if cap.renameProvider then
			map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename symbol")
		end

		if cap.codeActionProvider then
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
		end

		map("n", "gl", vim.diagnostic.open_float, "Diag: Line diagnostics")
		map("n", "[d", function()
			vim.diagnostic.goto_prev({ border = "rounded" })
		end, "Diag: Prev")
		map("n", "]d", function()
			vim.diagnostic.goto_next({ border = "rounded" })
		end, "Diag: Next")
	end,
})

-- handlers.setup()

-- lspconfig.lua_ls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- })

-- lspconfig.gopls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- 	settings = {
-- 		gopls = {
-- 			codelenses = {
-- 				generate = true,
-- 				gc_details = true,
-- 				test = true,
-- 				tidy = true,
-- 				upgrade_dependency = true,
-- 				vendor = true,
-- 			},
-- 			hints = {
-- 				constantValues = true,
-- 				assignVariableTypes = true,
-- 				functionTypeParameters = true,
-- 				rangeVariableTypes = true,
-- 			},
-- 			gofumpt = true,
-- 		},
-- 	},
-- })

-- lspconfig.golangci_lint_ls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- 	init_options = {
-- 		command = {
-- 			"golangci-lint",
-- 			"run",
-- 			"--output.json.path",
-- 			"stdout",
-- 			"--show-stats=false",
-- 			"--issues-exit-code=1",
-- 		},
-- 	},
-- })

-- lspconfig.jsonls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- 	-- settings = require("jsonls").settings,
-- 	setup = require("jsonls").setup,
-- })

-- lspconfig.ts_ls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- 	settings = {
-- 		typescript = {
-- 			format = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- })

-- lspconfig.pyright.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				typeCheckingMode = "basic",
-- 				useLibraryCodeForTypes = true,
-- 			},
-- 		},
-- 	},
-- })

-- lspconfig.html.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- })

-- lspconfig.cssls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- })

-- lspconfig.bashls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- })

-- lspconfig.dockerls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- })

-- lspconfig.yamlls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- 	settings = {
-- 		yaml = {
-- 			schemas = {
-- 				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
-- 				-- check for both yaml and yml
-- 				-- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.20.13/all.json"] = "/*.{yml,yaml}",
-- 				["https://raw.githubusercontent.com/compose-spec/compose-spec/refs/heads/main/schema/compose-spec.json"] = "docker-compose*.yml",
-- 			},
-- 		},
-- 	},
-- })

-- lspconfig.rust_analyzer.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- })

-- lspconfig.sqlls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- })

-- lspconfig.clangd.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- })

-- lspconfig.tailwindcss.setup({
-- 	on_attach = function(client, bufnr)
-- 		require("tailwindcss-colors").buf_attach(bufnr)
-- 		on_attach(client, bufnr)
-- 	end,
-- 	root_dir = require("lspconfig.util").root_pattern(".git"),
-- 	capabilities = handlers.capabilities,
-- 	settings = {
-- 		tailwindCSS = {
-- 			experimental = {
-- 				classRegex = {
-- 					{ "clsx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
-- 					{ "classnames\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
-- 					":\\s*?[\"'`]([^\"'`]*).*?,",
-- 					"(?:const|let|var)\\s+[\\w$_][_\\w\\d]*\\s*=\\s*['\\\"](.*?)['\\\"]",
-- 					{ "(?:twMerge|twJoin)\\(([^;]*)[\\);]", "[`'\"`]([^'\"`;]*)[`'\"`]" },
-- 				},
-- 			},
-- 			classAttributes = { "class", "className", "classes" },
-- 		},
-- 	},
-- })

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

-- lspconfig.zls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = handlers.capabilities,
-- })
