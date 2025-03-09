require("lazy").setup({
	{ -- neovim now supports commenting with gc by default, but this plugin should be a bit better still
		"numToStr/Comment.nvim",
		opts = {},
	},
	{ -- makes delimeters easier to tell apart
		"HiPhish/rainbow-delimiters.nvim",
	},
	{ -- adds markdown preview in browser
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		config = function()
			vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "[M]arkdown [P]review" })
		end,
	},
	{ -- adds handy shorcuts to access lazyvim in neovim. I don't use many function from it, but it's handy
		"kdheepak/lazygit.nvim",
		lazy = false,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim", -- not needed if not using it in a floating window I think
		},
		config = function()
			vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", { noremap = true })
		end,
	},
	{              -- adds s and ys capabilities
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {},
	},
	-- colorschemes
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 998,
		config = function()
			vim.cmd.colorscheme("catppuccin")
			require("catppuccin").setup({
				flavour = "mocha",
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 999,
		config = function()
			require("gruvbox").setup()
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	-- end of colorschemes
	{ -- marks blanklines
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},
	{ -- adds line at the bottom instead of the default vim one
		-- TODO: there's a lot of configuration to be done
		-- TODO: bufferline might be a nice addition
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
		},
	},
	{ -- automatically put another bracket
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	-- file managers
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		keys = {
			{
				"<leader>e",
				"<cmd>Neotree toggle<cr>",
				desc = "Open file [e]xplorer",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	-- end of file managers
	{ -- seamless neovim integration with tmux
		"aserowy/tmux.nvim",
		config = function()
			return require("tmux").setup()
		end,
	},
	{ -- what's the correct shift width? ;)
		"tpope/vim-sleuth",
	},

	{ -- autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			return require("plugins.configs.conform") -- TODO: keys defined in this file load only after first using conform
		end,
		keys = {
			{
				"<leader>ff",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer ([f]ile)",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
			formatters_by_ft = {
				go = { "gofmt" },
				rust = { "rustfmt" },
				c = { "clang_format" },
				lua = { "stylua" },
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
				json = { "prettier" },
				markdown = { "prettier" },
				python = { "black" },
				yaml = { "prettier" },
				ansible = { "prettier" },
				['yaml.ansible'] = {'ansible_lint'}, -- TODO?
				bash = { "shfmt", "shellcheck" },
				zsh = { "shfmt", "shellcheck" },
				sh = { "shfmt", "shellcheck" },
			},
		},
	},
	{ -- legend for keys
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{ -- new UI for neovim
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			return require("plugins.configs.noice")
		end,
	},
	{ -- jumping between git chunks in text, markers what changed
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				vim.keymap.set(
					"n",
					"<leader>gp",
					require("gitsigns").prev_hunk,
					{ buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
				)
				vim.keymap.set(
					"n",
					"<leader>gn",
					require("gitsigns").next_hunk,
					{ buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
				)
				vim.keymap.set(
					"n",
					"<leader>ph",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "[P]review [H]unk" }
				)
			end,
		},
	},
	{ -- telescope!
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			return require("plugins.configs.telescope")
		end,
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			return require("plugins.configs.treesitter")
		end,
	},
	{ -- old-school git vim integration that gives :Gdiffsplit and :GBrowse
		"tpope/vim-fugitive",
	},
	{ -- extends GBrowse for github
		"tpope/vim-rhubarb",
	},
	{ -- extends GBrowse for gitlab
		"shumphrey/fugitive-gitlab.vim",
		config = function()
			-- TODO: https://github.com/shumphrey/fugitive-gitlab.vim/issues/49 API KEY
			vim.g.fugitive_gitlab_domains = { ['ssh://git@gitlab.czk.comarch:2222'] = 'https://gitlab.czk.comarch' }
		end,
	},
  { -- generate permalinks for github/gitlab
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
		config = function(opts)
			opts = opts or {}
			opts.router = {
				browse = {
					["^gitlab.czk.comarch"] = "https://gitlab.czk.comarch/"
						.. "{_A.ORG}/"
						.. "{_A.REPO}/blobs/"
						.. "{_A.CURRENT_BRANCH}/"
						.. "{_A.FILE}"
						.. "#L{_A.LSTART}"
						.. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
				}
			}
			opts.debug = true
			opts.file_log = true
			require("gitlinker").setup(opts)
		end,
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },
	{ -- mark color codes with their colors
		"norcalli/nvim-colorizer.lua",
		config = function()
			return require("colorizer").setup()
		end,
	},
	{ -- leetcode integration
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",

			-- optional
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			lang = "golang",
		},
	},
	{ -- visualise undotree
		"mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>", mode = { "n" }, desc = "Toggle Undotree" },
    },
	},
	{ -- save to files using sudo without reopening neovim
		"lambdalisue/vim-suda"
	},


	-- -- configuring lsp as shown in advent of nvim
	-- TODO: do not show this weird lsp info on top of this file, configure for ansible
	-- {
	-- 	'neovim/nvim-lspconfig',
	-- 	dependencies = {
	-- 		{
	-- 			"folke/lazydev.nvim", -- this configures lsp to know vim. lua module and more
	-- 			ft = "lua", -- only load on lua files
	-- 			opts = {
	-- 				library = {
	-- 					-- See the configuration section for more details
	-- 					-- Load luvit types when the `vim.uv` word is found
	-- 					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		require("lspconfig").lua_ls.setup {}
	-- 		require("lspconfig").ansiblels.setup {}
	-- 	end
	-- },
	-- {
	-- 	'mfussenegger/nvim-ansible',
	-- }

	-- { 'towolf/vim-helm',           ft = 'helm' },

	-- {
	--   'neovim/nvim-lspconfig',
	--   dependencies = {
	--     { 'williamboman/mason.nvim', config = true },
	--     'williamboman/mason-lspconfig.nvim',
	--     { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
	--     'folke/neodev.nvim',
	--   },
	--   config = function() return require('plugins.configs.nvim-lspconfig') end
	-- },
	{ 'sindrets/diffview.nvim' },
	-- { 'akinsho/git-conflict.nvim', version = "*", config = true },
	-- {
	--   -- Autocompletion
	--   'hrsh7th/nvim-cmp',
	--   dependencies = {
	--     -- Snippet Engine & its associated nvim-cmp source
	--     'L3MON4D3/LuaSnip',
	--     'saadparwaiz1/cmp_luasnip',
	--     -- Adds LSP completion capabilities
	--     'hrsh7th/cmp-nvim-lsp',
	--     -- Adds a number of user-friendly snippets
	--     'rafamadriz/friendly-snippets',
	--   },
	-- },
	--lazy
})

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	-- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	-- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	-- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	-- nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
	-- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	-- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	-- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	--
	-- See `:help K` for why this keymap
	-- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	-- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	-- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	-- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	-- nmap('<leader>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, '[W]orkspace [L]ist Folders')
	--
	-- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
	--   vim.lsp.buf.format()
	-- end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	-- tsserver = {},
	-- html = { filetypes = { 'html', 'twig', 'hbs'} },
	bashls = {},

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
-- require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
--
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--       filetypes = (servers[server_name] or {}).filetypes,
--     }
--   end
-- }
--
-- local lspconfig = require('lspconfig')
--
-- -- setup helm-ls
-- lspconfig.helm_ls.setup {
--   settings = {
--     ['helm-ls'] = {
--       yamlls = {
--         path = "yaml-language-server",
--       }
--     }
--   }
-- }
--
-- -- setup yamlls
-- lspconfig.yamlls.setup {}
