return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",

	config = function()
		require("luasnip/loaders/from_vscode").load()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		ls.add_snippets("typescriptreact", {
			s("package", {
				t({ "/**", "* @package", "*/" }),
			}),
		})
	end,
}
