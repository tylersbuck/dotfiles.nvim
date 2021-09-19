-- plugins.lua

-- Package management via packer
--
-- You must run `PackerCompile` or `PackerSync` whenever you make changes to
-- the startup configuration. Note: Make sure the changes have been sourced.
--
-- Neovim can be configured to automatically run :PackerCompile whenever
-- plugins.lua is updated with an autocommand:
--   autocmd BufWritePost plugins.lua source <afile> | PackerCompile
-- This autocommand can be placed in your init.vim, or any other startup file
-- as per your setup. Placing this in plugins.lua could look like this:
--   vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
--
-- Regenerate compiled loader file
--   :PackerCompile
-- Profiling can be enabled, to see results restart nvim and run :PackerProfile
--   :PackerCompile profile=true
-- Remove any disabled or unused plugins
--   :PackerClean
-- Clean, then install missing plugins
--   :PackerInstall
-- Clean, then update and install plugins
--   :PackerUpdate
-- Perform `PackerUpdate` and then `PackerCompile`
--   :PackerSync
-- Loads opt plugin immediately
--   :PackerLoad completion-nvim ale

local execute = vim.api.nvim_command
local fn = vim.fn

-- Bootstrap packer ------------------------------------------------------------

-- Install packer.nvim if not already installed
-- You can also use the following command (with packer bootstrapped) to have
-- packer setup your configuration (or simply run updates) and close once all
-- operations are completed:
--   nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_echo({{'Installing packer.nvim ...', 'Type'}}, true, {})
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
  -- TODO: initial PackerSync / PackerInstall / PackerCompile ?
end

local packer = require('packer')
local use = packer.use

-- Configure packer ------------------------------------------------------------

-- Using packadd is only required if you have packer configured as `opt` (and
-- packer is not managing itself?).
-- vim.cmd [[packadd packer.nvim]]

-- https://github.com/rockerBOO/awesome-neovim

return packer.startup(function()
  -- Packer can manage itself
  -- TODO: Lazy-load packer on :Packer* commands?
  use 'wbthomason/packer.nvim'

  -- Shared --------------------------------------------------------------------

  -- Lua utilities
  use {
    'nvim-lua/plenary.nvim',
  }

  -- Filetype icons
  -- NOTE: Requires nerd font to be installed on system
  use {
    'kyazdani42/nvim-web-devicons',
    config = function() require('config.web-devicons') end,
  }

  -- Allows plugins to repeat commands with '.'
  use {
    'tpope/vim-repeat',
  }

  -- General -------------------------------------------------------------------

  -- Change surrounding characters
  use {
    'tpope/vim-surround',
    requires = {{'tpope/vim-repeat'}},
  }

  -- Toggle comments
  use {
    'terrortylor/nvim-comment',
    config = function() require('config.comment') end,
  }

  -- Sneak motion
  use {
    'ggandor/lightspeed.nvim',
    requires = {{'tpope/vim-repeat'}},
    config = function() require('config.lightspeed') end,
  }

  -- Use .editorconfig files
  use {
    'editorconfig/editorconfig-vim',
    config = function() require('config.editorconfig') end,
  }

  -- UI ------------------------------------------------------------------------

  -- 'lilydjwg/colorizer' (or colorize?)
  -- 'rktjmp/lush.nvim' for colorscheme like 'npxbr/gruvbox.nvim'
  -- 'liuchengxu/vista.vim' or 'preservim/tagbar'?

  -- Indent guide
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('config.indent-blankline') end,
  }

  -- Status line
  -- Also try: 'Famiu/feline.nvim'
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require('config.galaxyline') end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }

  -- Buffer list
  use {
    'akinsho/bufferline.nvim',
    config = function() require('config.bufferline') end,
  }

  -- File tree
  --[[
  use {
    'kyazdani42/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    config = function() require('plugins.nvimtree') end
  }
  --]]

  -- Extra functionality -------------------------------------------------------

  -- sbdchd/neoformat
  -- L3MON4D3/LuaSnip
  -- mfussenegger/nvim-dap

  -- Session wrapper
  -- 'Shatur/neovim-session-manager'

  -- Terminal wrapper
  -- Others:
  --   'akinsho/nvim-toggleterm.lua'
  --   'vimlab/split-term.vim'
  use {
    'kassio/neoterm',
    cmd = {'T', 'Topen', 'Texec'},
    config = function() require('config.neoterm') end,
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}},
    config = function() require('config.telescope') end,
  }

  -- 'nvim-telescope/telescope-frecency.nvim'?
  -- 'nvim-telescope/telescope-fzf-native.nvim'?

  -- Parser for highlighting, etc
  use {
    'nvim-treesitter/nvim-treesitter',
    ft = {
      'bash', 'css', 'dockerfile', 'go', 'html', 'javascript', 'json',
      'lua', 'rust', 'sh', 'scss', 'typescript', 'yaml',
    },
    -- Update parsers when treesitter is installed or updated
    run = ':TSUpdateSync',
    cmd = {'TSUpdate', 'TSUpdateSync'},
    config = function() require('config.treesitter') end,
  }

  -- romgrk/nvim-treesitter-context?

  -- Git -----------------------------------------------------------------------

  -- 'TimUntersberger/neogit'?

  -- Git wrapper
  use {
    'tpope/vim-fugitive',
  }

  -- Git signs and hunk tools
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require('config.gitsigns') end,
  }

  -- LSP -----------------------------------------------------------------------

  -- windwp/nvim-autopairs
  -- nvim-lua/lsp-status.nvim?
  -- glepnir/lspsaga.nvim?
  -- kosayoda/nvim-lightbulb (lspsaga has lightbulb?)
  -- ray-x/lsp_signature.nvim (lspsaga has sig help?)
  -- folke/trouble.nvim?

  -- LSP configuration
  use {
    'neovim/nvim-lspconfig',
    -- TODO: nvim-lspinstall for auto-install
    --after = 'nvim-lspinstall',
    ft = {'lua', 'yaml'},
    config = function() require('config.lspconfig') end,
  }

  -- Completion
  -- DEPRECATED: Keep an eye on 'hrsh7th/nvim-cmp', compe's successor.
  use {
    'hrsh7th/nvim-compe',
    ft = {'lua', 'yaml'},
    -- load compe in insert mode only
    event = 'InsertEnter',
    config = function() require('config.compe') end,
    --[[
    wants = 'LuaSnip',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        wants = 'friendly-snippets',
        event = 'InsertCharPre',
        config = function() require 'plugins.luasnip' end,
      },
      {
        'rafamadriz/friendly-snippets',
        event = 'InsertCharPre'
      }
    }
    --]]
  }

  -- Icons for symbol types in autocomplete list
  use {
    'onsails/lspkind-nvim',
    ft = {'lua', 'yaml'},
    config = function() require('config.lspkind') end,
  }

  -- Language specific ---------------------------------------------------------

  -- 'fatih/vim-go'

end)

