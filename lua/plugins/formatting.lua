return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				go = { "golines", "goimports" },
				lua = { "stylua" },
				c = { "clang_format" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				sql = { "sql_formatter" },
				toml = { "taplo" },
			},
			format_on_save = {
				timeout_ms = 3000,
				lsp_fallback = true,
			},
			formatters = {
				shfmt = { args = { "-i", "2" } },
				golines = {
					args = { "--max-len", "120", "--base-formatter", "gofumpt" },
				},
				sql_formatter = {
					args = { "--config", "~/.config/sql-formatter.json", "--fix" },
					stdin = false,
				},
			},
		})
	end,
}
