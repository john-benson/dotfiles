local lsp_zero = require('lsp-zero')
local nvim_lsp = require('cmp_nvim_lsp')

local lsp_attach = function(client, bufnr) 
  local opts = {buffer = bfnr}

  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<Cr>', opts)
  vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<Cr>', opts)
  vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<Cr>', opts)
  vim.keymap.set('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<Cr>', opts)
  vim.keymap.set('n', 'go', '<Cmd>lua vim.lsp.buf.type_definition()<Cr>', opts)
  vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<Cr>', opts)
  vim.keymap.set('n', 'gs', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', opts)
  vim.keymap.set('n', '<F2>', '<Cmd>lua vim.lsp.buf.rename()<Cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F3>', '<Cmd>lua vim.lsp.buf.format({async = true})<Cr>', opts)
  vim.keymap.set('n', '<F4>', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', opts)
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
  mapping = cmp.mapping.preset
})


local lspconfig = require('lspconfig')

-- Rust
lspconfig.rust_analyzer.setup({
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enabled = true
      }
    }
  }
})


