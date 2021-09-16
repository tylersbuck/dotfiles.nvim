-- lspconfig.lua

-- Configures language servers and other LSP related options, mappings, etc...

-- Diagnostics options
-- See :help vim.lsp.diagnostic.on_publish_diagnostics()
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Apply underlines to diagnostics
    underline = true,
    -- Apply virtual text to line endings
    virtual_text = false,
    --[[
    virtual_text = {
      prefix = '',
      spacing = 0
    },
    --]]
    -- Apply signs for diagnostics
    signs = true,
    -- Update diagnostics in InsertMode or wait until InsertLeave
    update_in_insert = false,
    -- Sort diagnostics by severity (and thus signs and virtual text)
    -- If there are multiple diagnostics for a single line and only one sign or
    -- virtual text is displayed, it will be the most severe.
    severity_sort = true,
  }
)

-- Diagnostics signs
local sign_char = ''
vim.fn.sign_define('LspDiagnosticsSignHint', {text = sign_char})
vim.fn.sign_define('LspDiagnosticsSignInformation', {text = sign_char})
vim.fn.sign_define('LspDiagnosticsSignWarning', {text = ''})
vim.fn.sign_define('LspDiagnosticsSignError', {text = ''})

-- Set keymaps per buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <C-x><C-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    -- Highlights symbol under cursor and clears on cursor move
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Configure lua language server
local lua_settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using
      -- (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
      -- Setup your lua path
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
      disable = {
        --'undefined-global',
        --'lowercase-global',
        'unused-local',
        --'unused-vararg',
        'trailing-space'
      },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file('', true),
      -- Or maybe this instead???
      --[[
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      }
      --]]
      -- Maybe below will add vim module completion if above doesn't
      --library = vim.list_extend(get_lua_runtime(), config.library or {}),
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  },
}

-- yaml language server settings

local yamlSchemas = vim.empty_dict()
local workspace_dir = '/data/tfs_workspaces/'..vim.env.USER..'/'..vim.env.BRANCH
if (vim.env.HOSTNAME == 'FDVMPRDLIN1' and string.match(vim.loop.cwd(), '^'..workspace_dir)) then
  yamlSchemas = {
    [workspace_dir..'/tests/ggc/testSpec.schema.jsonc'] = {'*.yml', '*.yaml'},
  }
end

local yaml_settings = {
  redhat = {
    telemetry = {
      enabled = false,
    },
  },
  yaml = {
    schemas = yamlSchemas,
  },
  --[[
  -- Examples
  yaml = {
    -- Globally set additionalProperties to false for all objects. So if its true,
    -- no extra properties are allowed inside yaml.
    --disableAdditionalProperties = true,
    -- Enable/disable completion feature
    completion = true,
    -- Custom tags for the parser to use
    customTags = {},
    format = {
      -- Print spaces between brackets in objects
      bracketSpacing = true,
      -- Enable/disable default YAML formatter
      enable = true,
      -- Specify the line length that the printer will wrap on
      printWidth = 80,
      -- Always: wrap prose if it exeeds the print width
      -- Never: never wrap the prose
      -- Preserve: wrap prose as-is
      proseWrap = 'preserve',
      -- Use single quotes instead of double quotes
      singleQuote = false,
    },
    -- Enable/disable hover feature
    hover = true,
    -- The maximum number of outline symbols and folding regions computed
    -- (limited for performance reasons).
    maxItemsComputed = 5000,
    schemaStore = {
      -- Automatically pull available YAML schemas from JSON Schema Store
      enable = true,
      -- URL of schema store catalog to use
      url = 'https://www.schemastore.org/api/json/catalog.json',
    },
    -- Associate schemas to YAML files in the current workspace
    -- glob pattern
    --'../relative/path/schema.json': ['/*.yaml'],
    schemas = vim.empty_dict(),
    trace = {
      -- Traces the communication between VSCode and the YAML language service.
      -- enum { 'off', 'messages', 'verbose' }
      server = 'off',
    },
    -- Enable/disable validation feature
    validate = true,
  },
  --]]
}

-- Returns a base config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- Setup language servers with lspconfig
local function setup_servers()
  -- TODO: use lspinstall
  --require('lspinstall').setup()
  -- Get all installed servers
  --local servers = require('lspinstall').installed_servers()
  -- ...And add manually installed servers
  --table.insert(servers, 'clangd')
  --table.insert(servers, 'sourcekit')
  local servers = {'sumneko_lua', 'yamlls'}

  for _, server in pairs(servers) do
    -- Create base config
    local config = make_config()

    -- Language specific configs

    if server == 'sumneko_lua' then
      config.cmd = {
        'lua-language-server', '-E',
        vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server/main.lua'
      }
      config.settings = lua_settings
    end

    if server == 'yamlls' then
      if (vim.env.HOSTNAME == 'FDVMPRDLIN1') then
        config.cmd = {vim.env.HOME..'/.yarn/bin/yaml-language-server', '--stdio'}
      else
        config.cmd = {'yaml-language-server', '--stdio'}
      end
      config.filetypes = {'yaml'}
      config.settings = yaml_settings
    end

    require('lspconfig')[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
--[[
require('lspinstall').post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd('bufdo e') -- this triggers the FileType autocmd that starts the server
end
--]]

-- Suppress error messages from language servers
--[[
vim.notify = function(msg, log_level, _opts)
  if msg:match('exit code') then
    return
  end
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({{msg}}, true, {})
  end
end
--]]

