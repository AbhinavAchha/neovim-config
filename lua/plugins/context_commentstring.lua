return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	config = function()
		require("ts_context_commentstring.internal").update_commentstring({
			key = "__multiline",
		})
	end,
}
