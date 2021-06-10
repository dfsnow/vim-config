local packer = require("packer")
local use = packer.use

return require("packer").startup(
    function()
        -- UI and colors
	use "itchyny/lightline.vim"
	use "mengelbrecht/lightline-bufferline"
	use "maximbaz/lightline-ale"
        use "folke/which-key.nvim"
        use {"dracula/vim", as = "dracula"}
        use "Pocco81/TrueZen.nvim"

	-- Git integration
	use "tpope/vim-fugitive"
	use "mhinz/vim-signify"

        -- Formatting
	use "tpope/vim-sleuth"
	use "tpope/vim-commentary"

	-- Terminal integration
	use "wincent/terminus"

        -- lang stuff
        use "nvim-treesitter/nvim-treesitter"
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-compe"
        use "onsails/lspkind-nvim"
        use "sbdchd/neoformat"
        use "nvim-lua/plenary.nvim"
        use "kabouzeid/nvim-lspinstall"

        use "lewis6991/gitsigns.nvim"
        use "windwp/nvim-autopairs"
        use "alvan/vim-closetag"

        -- snippet support
        use "hrsh7th/vim-vsnip"
        use "rafamadriz/friendly-snippets"

        -- file managing , picker etc
        use "kyazdani42/nvim-tree.lua"
        use "kyazdani42/nvim-web-devicons"
        use "ryanoasis/vim-devicons"
        use "nvim-telescope/telescope.nvim"
        use "nvim-telescope/telescope-media-files.nvim"
        use "nvim-lua/popup.nvim"

        -- misc
        use "tweekmonster/startuptime.vim"
        use "907th/vim-auto-save"
        use "karb94/neoscroll.nvim"
        use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
    end,
    {
        display = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
        }
    }
)
