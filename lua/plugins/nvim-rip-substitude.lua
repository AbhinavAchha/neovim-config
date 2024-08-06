return {
	"chrisgrieser/nvim-rip-substitute",
	cmd = "RipSubstitute",
	opts = {
		prefill = {
			normal = "cursorWord", -- "cursorWord"|false
			visual = "selectionFirstLine", -- "selectionFirstLine"|false
			startInReplaceLineIfPrefill = true,
		},
	},
	keys = {
		{
			"<leader>s",
			function()
				require("rip-substitute").sub()
			end,
			mode = { "n", "x" },
			desc = " rip substitute",
		},
	},
}
