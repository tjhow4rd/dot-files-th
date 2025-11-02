return {

    -- autocomplete etc.
    {"hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP source
      "L3MON4D3/LuaSnip",         -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet completions
    },
    config = function()
	local cmp = require("cmp")
	    cmp.setup({
		snippet = {
	    	    expand = function(args)
	    	    require("luasnip").lsp_expand(args.body)
	    	    end,},
	    	mapping = cmp.mapping.preset.insert({
	    	    ["<C-Space>"] = cmp.mapping.complete(),
            	    ["<Tab>"] = cmp.mapping.select_next_item(),
            	    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            	    ["<CR>"] = cmp.mapping.confirm({ select = true }),
	    	}),
	    	sources = {
            	  { name = "nvim_lsp" },
            	  { name = "luasnip" },
            	},
	    })
    end,},

    -- lsp
    {"neovim/nvim-lspconfig",
    config = function()
        -- Optional: basic setup for pylsp
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function()
                vim.lsp.start({
                    name = "pylsp",
		    cmd = { "pylsp" },
		    root_dir = vim.fs.dirname(vim.fs.find({ "pyproject.toml", "setup.py", ".git" }, { upward = true })[1]),
		})
            end,
	})
    end,},

    -- treesitter
    {"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
	local configs = require("nvim-treesitter.configs")
	configs.setup({
	    highlight = {enable = true},
	    indent = {enable = true},
	    ensure_installed = {"lua", "python"},
	    auto_install = false,
	})
    end},

    -- telescope
    {'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
	vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end},

    -- slime pasting
    {"jpalardy/vim-slime",
    config = function()
	vim.g.slime_target = "tmux"
	vim.g.slime_bracketed_paste = 1
	vim.g.slime_default_config = {
	    socket_name = "default",
	    target_pane = "0",}
    end},

    -- surround
    {"tpope/vim-surround"},

    -- colourscheme
    {'projekt0n/github-nvim-theme',
      name = 'github-theme',
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      -- priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        require('github-theme').setup({
          -- options here
        })
    
        vim.cmd('colorscheme github_dark')
      end,
    },

    -- python docstrings
    {"heavenshell/vim-pydocstring",
    ft = { "python" },
    init = function()
        vim.g.pydocstring_doq_path = "/home/th25/Projects/pykot/tempvenv/bin/doq"
        vim.g.pydocstring_formatter = "google"
    end,
    keys = {{ "<leader>s", ":Pydocstring<CR>", desc = "Generate Python docstring" },},
    },

}


