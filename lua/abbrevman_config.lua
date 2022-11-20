local abbrev_man = require("abbrev-man")

abbrev_man.setup({
	load_natural_dictionaries_at_startup = true,
	load_programming_dictionaries_at_startup = false,
	natural_dictionaries = {
		["nt_en"] = {
			["adn"] = "AND",
			["THe"] = "rm_am",
		},
		["nt_my_slangs"] = {
			["cosnt"] = "const",
		},
	},
	programming_dictionaries = {
		["pr_py"] = {},
	},
})
