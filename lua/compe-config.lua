vim.o.completeopt = "menuone,noselect"

local cmp = require('cmp')

cmp.setup {
  sources = {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lsp' },
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
  },
}
