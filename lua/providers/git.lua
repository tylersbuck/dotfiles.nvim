-- Provider for git information

-- NOTE: Requires 'lewis6991/gitsigns.nvim'

local M = {}

-- Local

local function git_diff_count(winid, type)
  winid = winid or 0
  local ok, gsd = pcall(vim.api.nvim_buf_get_var, vim.api.nvim_win_get_buf(winid), 'gitsigns_status_dict')
  if (ok and gsd[type] and gsd[type] > 0) then
    return gsd[type]
  end
  return 0
end

-- Public

function M.has_git(winid)
  winid = winid or 0
  return vim.g.gitsigns_head or
        pcall(vim.api.nvim_buf_get_var, vim.api.nvim_win_get_buf(winid), 'gitsigns_head') or
        pcall(vim.api.nvim_buf_get_var, vim.api.nvim_win_get_buf(winid), 'gitsigns_status_dict')
end

function M.branch_name(winid)
  winid = winid or 0
  local ok, head = pcall(vim.api.nvim_buf_get_var, vim.api.nvim_win_get_buf(winid), 'gitsigns_head')
  if (not ok) then
    head = vim.g.gitsigns_head or ''
  end
  return head
end

function M.diff_added(winid)
  return git_diff_count(winid, 'added')
end

function M.diff_changed(winid)
  return git_diff_count(winid, 'changed')
end

function M.diff_removed(winid)
  return git_diff_count(winid, 'removed')
end

return M

