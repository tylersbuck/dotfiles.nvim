local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then
  return
end

-- TODO: setup per-buffer only
require('config.indent-blankline-treesitter')

-- Note: This is highly experimental, and folding can break on some types of
--       edits. If you encounter such breakage, hiting `zx` should fix folding.
--       In any case, feel free to open an issue with the reproducing steps.
--vim.g.foldmethod = expr
--vim.g.foldexpr = nvim_treesitter#foldexpr()

local ensure_installed = {
  'bash', 'css', 'dockerfile', 'go', 'html', 'javascript', 'json',
  'lua', 'rust', 'scss', 'typescript', 'yaml',
}

if (vim.env.HOSTNAME == 'FDVMPRDLIN1') then
  ensure_installed = {
    'bash', 'dockerfile', 'json', 'lua', 'yaml',
  }
end

treesitter.setup {
  -- If parser is not installed for the listed filetypes and a file of that type
  -- is opened, the parser will be automatically installed. Upon re-opening the
  -- file treesitter will be enabled.
  -- TODO: Anyway to have it enabled without re-opening?
  ensure_installed = ensure_installed,
  highlight = {
    enable = true
  },
  -- NOTE: Experimental
  --[[
  indent = {
    enable = true
  },
  --]]
}

