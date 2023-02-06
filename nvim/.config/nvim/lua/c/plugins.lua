local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Package manager
  use "nvim-lua/popup.nvim" -- PopupAPI
  use "nvim-lua/plenary.nvim" -- Library code
  use "jiangmiao/auto-pairs" -- Auto Brackets
  use {
    "nvim-neo-tree/neo-tree.nvim", -- File Explorer
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }
  use "lewis6991/gitsigns.nvim" -- Git integration

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0', -- Fuzzy Finder
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use "nvim-telescope/telescope-media-files.nvim" -- Media Preview for Telescope
  use "rebelot/heirline.nvim" -- Status Line
  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function() require("toggleterm").setup() end
  }

  use "lunarvim/colorschemes" -- Colour schemes

  -- Completion --
  use "hrsh7th/nvim-cmp" -- Autocompletion
  use "hrsh7th/cmp-buffer" -- Buffer Autocompletion
  use "hrsh7th/cmp-path" -- Path Autocompletion
  use "hrsh7th/cmp-cmdline" -- Command Line Autocompletion
  use "hrsh7th/cmp-nvim-lsp" -- LSP Autocompletion
  use "saadparwaiz1/cmp_luasnip" -- Snippet Autocompletion

  -- Snippets --
  use "L3MON4D3/LuaSnip" -- Snippet Engine
  use "rafamadriz/friendly-snippets" -- Useful Snippets

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"

  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use 'simrat39/rust-tools.nvim'
  use "jose-elias-alvarez/null-ls.nvim"

  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"

  use "ggandor/leap.nvim"
  use "tpope/vim-repeat"

  use 'andweeb/presence.nvim'

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
