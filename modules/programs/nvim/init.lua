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

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)                -- leader + cd = change directory
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
})



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

-- Theme config

require("gruvbox").setup()
vim.cmd.colorscheme("gruvbox")
--vim.cmd(":hi statusline guibg=NONE")
