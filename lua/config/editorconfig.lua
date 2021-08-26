-- editorconfig.lua

-- Configuration for 'editorconfig/editorconfig-vim'.

-- Ensure that this plugin works well with Tim Pope's fugitive
-- Avoid loading editorconfig for remote files over ssh
vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}

-- You can disable this plugin for a specific buffer by setting
-- b:EditorConfig_disable. Therefore, you can disable the plugin for all
-- buffers of a specific filetype. For example, to disable EditorConfig for all
-- git commit messages (filetype gitcommit):
-- au FileType gitcommit let b:EditorConfig_disable = 1

-- In very rare cases, you might need to override some project-specific
-- EditorConfig rules in global or local vimrc in some cases, e.g., to resolve
-- conflicts of trailing whitespace trimming and buffer autosaving. This is not
-- recommended, but you can:
-- vim.g.EditorConfig_disable_rules = {'trim_trailing_whitespace'}
