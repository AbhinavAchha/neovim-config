return {
	"Exafunction/codeium.vim",
	event = "BufEnter",
	commit = "9406f13cf3eaa08318b76746bd105a04506cab27",

	config = function()
		vim.keymap.set("i", "<c-l>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true })
		vim.keymap.set("i", "<c-;>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true })
		vim.keymap.set("i", "<c-,>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true })
		vim.keymap.set("i", "<c-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true })
	end,
}
