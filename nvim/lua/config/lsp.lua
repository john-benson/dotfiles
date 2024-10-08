local lsp_zero = require('lsp-zero')
local nvim_lsp = require('cmp_nvim_lsp')
local cmp_action = lsp_zero.cmp_action()

local lsp_attach = function(client, bufnr) 
  local opts = {buffer = bfnr}

  vim.keymap.set('n', '<Leader>cK', '<Cmd>lua vim.lsp.buf.hover()<Cr>', opts)
  vim.keymap.set('n', '<Leader>cd', '<Cmd>lua vim.lsp.buf.definition()<Cr>', opts)
  vim.keymap.set('n', '<Leader>cD', '<Cmd>lua vim.lsp.buf.declaration()<Cr>', opts)
  vim.keymap.set('n', '<Leader>ci', '<Cmd>lua vim.lsp.buf.implementation()<Cr>', opts)
  vim.keymap.set('n', '<Leader>ct', '<Cmd>lua vim.lsp.buf.type_definition()<Cr>', opts)
  vim.keymap.set('n', '<Leader>cr', '<Cmd>lua vim.lsp.buf.references()<Cr>', opts)
  vim.keymap.set('n', '<Leader>cs', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', opts)
  vim.keymap.set('n', '<Leader>crn', '<Cmd>lua vim.lsp.buf.rename()<Cr>', opts)
  vim.keymap.set({'n', 'x'}, '<Leader>cf', '<Cmd>lua vim.lsp.buf.format({async = true})<Cr>', opts)
  vim.keymap.set('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', opts)
  vim.keymap.set('n', '<Leader>co', '<Cmd>lua vim.diagnostic.open_float()<Cr>', opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = nvim_lsp.default_capabilities()
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  snippet = {
    expand = function(args) 
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-f>'] = cmp_action.vim_snippet_jump_forward(),
    ['<C-b>'] = cmp_action.vim_snippet_jump_backward(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
})


local lspconfig = require('lspconfig')

-- Rust
lspconfig.rust_analyzer.setup({})

-- TypeScript
lspconfig.tsserver.setup({})

-- Go
lspconfig.gopls.setup({})

-- Lua
lspconfig.lua_ls.setup({
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
})

-- Java
lspconfig.jdtls.setup({})
