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

-- Bootstrap packer ------------------------------------------------------------

-- Install packer.nvim if not already installed
-- You can also use the following command (with packer bootstrapped) to have
-- packer setup your configuration (or simply run updates) and close once all
-- operations are completed:
--   nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_echo({{'Installing packer.nvim ...', 'Type'}}, true, {})
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command('packadd packer.nvim')
end

local packer = require('packer')

-- Configure packer ------------------------------------------------------------

-- https://github.com/rockerBOO/awesome-neovim

return packer.startup(function(use)
  -- Packer can manage itself
  -- TODO: Lazy-load packer on :Packer* commands?
  use {
    'wbthomason/packer.nvim',
    commit = '4dedd3b08f8c6e3f84afbce0c23b66320cd2a8f2',
  }

  -- Shared --------------------------------------------------------------------

  -- Lua utilities
  use {
    'nvim-lua/plenary.nvim',
    commit = '9c3239bc5f99b85be1123107f7290d16a68f8e64',
  }

  -- Filetype icons
  -- NOTE: Requires nerd font to be installed on system
  use {
    'kyazdani42/nvim-web-devicons',
    commit = '8d2c5337f0a2d0a17de8e751876eeb192b32310e',
    config = function() require('config.web-devicons') end,
  }

  -- Allows plugins to repeat commands with '.'
  use {
    'tpope/vim-repeat',
    commit = '24afe922e6a05891756ecf331f39a1f6743d3d5a',
  }

  -- General -------------------------------------------------------------------

  -- Change surrounding characters
  use {
    'tpope/vim-surround',
    commit = 'bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea',
    requires = {{'tpope/vim-repeat'}},
  }

  -- Toggle comments
  use {
    'terrortylor/nvim-comment',
    commit = '0cd8228cddf40c86185059607a1469ab32c497d2',
    config = function() require('config.comment') end,
  }

  -- Sneak motion
  -- TODO: Try successor: https://github.com/ggandor/leap.nvim
  use {
    'ggandor/lightspeed.nvim',
    commit = 'c5b93fc1d76a708cb698417326e04f4786a38d90',
    requires = {{'tpope/vim-repeat'}},
    config = function() require('config.lightspeed') end,
  }

  -- Use .editorconfig files
  use {
    'editorconfig/editorconfig-vim',
    tag = 'v1.1.1',
    config = function() require('config.editorconfig') end,
  }

  -- UI ------------------------------------------------------------------------

  -- 'lilydjwg/colorizer' (or colorize?)
  -- 'rktjmp/lush.nvim' for colorscheme like 'npxbr/gruvbox.nvim'
  -- 'liuchengxu/vista.vim' or 'preservim/tagbar'?

  -- Indent guide
  use {
    'lukas-reineke/indent-blankline.nvim',
    tag = 'v2.18.4',
    config = function() require('config.indent-blankline') end,
  }

  -- Status line
  use {
    'famiu/feline.nvim',
    tag = 'v1.1.3',
    config = function() require('config.feline') end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }

  -- Buffer list
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.2.1',
    config = function() require('config.bufferline') end,
  }

  -- Extra functionality -------------------------------------------------------

  -- 'sbdchd/neoformat'
  -- 'L3MON4D3/LuaSnip'
  -- 'mfussenegger/nvim-dap'

  -- Session wrapper
  -- 'Shatur/neovim-session-manager'

  -- Database access
  -- 'tpope/vim-dadbod'
  -- 'kristijanhusak/vim-dadbod-ui'
  -- 'kristijanhusak/vim-dadbod-completion'

  -- Terminal wrapper
  -- Others:
  --   'akinsho/nvim-toggleterm.lua'
  --   'vimlab/split-term.vim'
  use {
    'kassio/neoterm',
    commit = '4881d6428bcaa524ad4686431ce184c6fb9bfe59',
    cmd = {'T', 'Topen', 'Texec'},
    config = function() require('config.neoterm') end,
  }

  -- Fuzzy finder
  --[[
  use {
    'nvim-telescope/telescope.nvim',
    commit = 'e6b69b1488c598ff7b461c4d9cecad57ef708f9b',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        commit = '59e38e1661ffdd586cb7fc22ca0b5a05c7caf988',
        run = 'make',
      },
      -- 'nvim-telescope/telescope-frecency.nvim'?
    },
    config = function() require('config.telescope') end,
  }

  -- Parser for highlighting, etc
  use {
    'nvim-treesitter/nvim-treesitter',
    commit = '9e8df1b3ca576eeaca4e8d48e3d67119b32adb99',
    -- Update parsers when treesitter is installed or updated
    run = ':TSUpdateSync',
    config = function() require('config.treesitter') end,
  }
  --]]

  -- 'romgrk/nvim-treesitter-context'?

  -- Git -----------------------------------------------------------------------

  -- 'TimUntersberger/neogit'?

  -- Git wrapper
  use {
    'tpope/vim-fugitive',
    tag = 'v3.7',
  }

  -- Git signs and hunk tools
  use {
    'lewis6991/gitsigns.nvim',
    tag = 'v0.4',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require('config.gitsigns') end,
  }

  -- LSP -----------------------------------------------------------------------

  -- 'windwp/nvim-autopairs'
  -- 'nvim-lua/lsp-status.nvim'?
  -- 'glepnir/lspsaga.nvim'? (no longer maintained, look for fork)
  -- 'kosayoda/nvim-lightbulb' (lspsaga has lightbulb?)
  -- 'ray-x/lsp_signature.nvim' (lspsaga has sig help?)
  -- 'folke/trouble.nvim'?

  --[[
  -- LSP configuration
  use {
    'neovim/nvim-lspconfig',
    commit = '66659884c36dadd1f445f9012fcf4e7600286d3e',
    -- TODO: nvim-lspinstall for auto-install
    -- after = 'nvim-lspinstall',
    ft = {'lua', 'yaml'},
    config = function() require('config.lspconfig') end,
  }

  -- Completion
  -- DEPRECATED: Keep an eye on 'hrsh7th/nvim-cmp', compe's successor.
  use {
    'hrsh7th/nvim-compe',
    commit = 'd186d739c54823e0b010feb205c6f97792322c08',
    ft = {'lua', 'yaml'},
    -- load compe in insert mode only
    event = 'InsertEnter',
    config = function() require('config.compe') end,
  }

  -- Icons for symbol types in autocomplete list
  use {
    'onsails/lspkind-nvim',
    commit = '0df591f3001d8c58b7d71a8dc7e006b8cea4959d',
    ft = {'lua', 'yaml'},
    config = function() require('config.lspkind') end,
  }
  --]]

  -- Language specific ---------------------------------------------------------

  -- 'fatih/vim-go'

  -- Packer ---------------------------------------------------------

  -- Do an initial sync if packer was just bootstrapped
  -- Must be at the end of packer startup - after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)

