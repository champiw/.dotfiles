vim.o.number = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)                -- leader + cd = change directory with netrw
vim.keymap.set('n', '<leader>so', ':update<CR> :source<CR>') -- leader + so = source config
vim.keymap.set('i', '<C-BS>', '<C-W>', { noremap = true })   -- ctrl + bksp = delete whole word
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<CR>')    -- leader + y = copy to system clipboard
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)        -- leader + lf = format

vim.pack.add({
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
})

-- Theme config

require("gruvbox").setup()
vim.cmd.colorscheme("gruvbox")

-- LSPs setup
local lsp_servers = {
	"nixd",
	"lua_ls",

	"html",
	"cssls",
	"tailwindcss",
	"svelte",

	"dockerls",
	"docker_compose_language_service",
}

for _, server in ipairs(lsp_servers) do
	vim.lsp.enable(server)
end

-- Treesitter setup

local treesitter_languages = {
	"lua",
	"nix",

	"html",
	"css",
	"javascript",
	"typescript",
	"svelte",

	"go",

	"dockerfile",

	"json",
	"yaml",
	"toml",
	"markdown",
}

require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install(treesitter_languages)

vim.api.nvim_create_autocmd("FileType", {
	pattern = treesitter_languages,
	callback = function(args)
		vim.treesitter.start(args.buf)
	end,
})

-- Blink autocomplete config

require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust" },
	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide" },

		["<CR>"] = { "accept", "fallback" },

		["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
	},
})

-- Mini nvim config

require("mini.pairs").setup()      -- Adds a closing symbol
require("mini.surround").setup()   -- saiw{thing to surround}
require("mini.statusline").setup() -- Better statusline

require("mini.pick").setup()       -- File finder and navigation

vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>g", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")

-- ToggleTerm config

require("toggleterm").setup({
    direction = "float",
    open_mapping = [[<C-t>]],
    float_opts = {
        border = "rounded",
    },
})

--  GitSigns config

require("gitsigns").setup({
    signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
    },
})

require("trouble").setup({
	focus = true,
})

vim.keymap.set("n", "<leader>q", "<CMD>Trouble diagnostics toggle<CR>")


-- Package management ----------------------------------------------------------
-- :PackUpdate - Updates all plugins
-- :PackUpdate blink.cmp - Updates only one 
-- :PackDelete oil.nvim - Removes a plugin
-- :PackClean - Removes installed plugins not present in vim.pack.add()

local function complete_packages(arg_lead)
	arg_lead = arg_lead or ""

	return vim.iter(vim.pack.get())
		:map(function(plugin)
			return plugin.spec.name
		end)
		:filter(function(name)
			return vim.startswith(name, arg_lead)
		end)
		:totable()
end

vim.api.nvim_create_user_command("PackUpdate", function(info)
	if #info.fargs ~= 0 then
		vim.pack.update(info.fargs, { force = info.bang })
	else
		local choice = vim.fn.confirm(
			"Do you want to update ALL packages?",
			"&Yes\n&No",
			2
		)

		if choice == 1 then
			vim.notify("Updating all packages...", vim.log.levels.INFO)
			vim.pack.update(nil, { force = info.bang })
		else
			vim.notify("Update cancelled.", vim.log.levels.WARN)
		end
	end
end, {
	desc = "Update vim.pack packages",
	nargs = "*",
	bang = true,
	complete = complete_packages,
})

vim.api.nvim_create_user_command("PackDelete", function(info)
	vim.pack.del(info.fargs, { force = info.bang })
end, {
	desc = "Delete vim.pack packages",
	nargs = "+",
	bang = true,
	complete = complete_packages,
})

vim.api.nvim_create_user_command("PackClean", function()
	local unused = {}

	for _, plugin in ipairs(vim.pack.get()) do
		if not plugin.active then
			table.insert(unused, plugin.spec.name)
		end
	end

	if #unused == 0 then
		vim.notify("No unused packages.", vim.log.levels.INFO)
		return
	end

	local choice = vim.fn.confirm(
		"Delete unused packages?",
		"&Yes\n&No",
		2
	)

	if choice == 1 then
		vim.pack.del(unused)
	end
end, {
	desc = "Delete inactive vim.pack packages",
})
