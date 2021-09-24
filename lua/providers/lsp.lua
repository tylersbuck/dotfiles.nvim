-- Provider for LSP information and diagnostics

-- TODO: Needs a bit of work after a better understanding of the vim.lsp api

local M = {}

-- Local

local function get_clients(winid)
  winid = winid or 0
  local bufnr = vim.api.nvim_win_get_buf(winid) or 0
  return vim.lsp.buf_get_clients(bufnr)
end

local function get_active_clients_for_filetype(winid)
  winid = winid or 0
  local bufnr = vim.api.nvim_win_get_buf(winid) or 0
  local active_clients = vim.lsp.get_active_clients()
  local active_clients_for_filetype = {}
  if (active_clients) then
    local buf_ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
    for _, client in ipairs(active_clients) do
      local ftypes = client.config.filetypes
      if (ftypes and vim.fn.index(ftypes, buf_ft) ~= -1) then
        table.insert(active_clients_for_filetype, client)
      end
    end
  end
  return active_clients_for_filetype
end

local function get_diagnostic_count_for_type(winid, diagnostic_type)
  if (not M.has_client()) then
    return 0
  end
  local active_clients_for_filetype = get_active_clients_for_filetype(winid)
  if (active_clients_for_filetype) then
    local count = 0
    for _, client in ipairs(active_clients_for_filetype) do
      count = count + vim.lsp.diagnostic.get_count(
        vim.api.nvim_get_current_buf(),
        diagnostic_type,
        client.id
      )
    end
    return count
  end
  return 0
end

-- Public

-- True if current buffer has at least one client
function M.has_client(winid)
  return not vim.tbl_isempty(get_clients(winid))
end

-- True if current buffer has at least one active client for it's filetype
function M.has_active_client_for_filetype(winid)
  return not vim.tbl_isempty(get_active_clients_for_filetype(winid))
end

-- Gets total number of errors for current buffer
function M.diagnostic_error_count(winid)
  return get_diagnostic_count_for_type(winid, 'Error')
end

-- Gets total number of warnings for current buffer
function M.diagnostic_warning_count(winid)
  return get_diagnostic_count_for_type(winid, 'Warning')
end

-- Gets total number of hints for current buffer
function M.diagnostic_hint_count(winid)
  return get_diagnostic_count_for_type(winid, 'Hint')
end

-- Gets total number of info diagnostics for current buffer
function M.diagnostic_info_count(winid)
  return get_diagnostic_count_for_type(winid, 'Information')
end

return M

