vim.opt.textwidth = 110
vim.opt.formatoptions = 'cqrol'

-- use only filetype.lua and not filetype.vim
vim.g.do_filetype_lua = 1
vim.g.did_load_filetype = 0

-- needed for gui nvims other than vimr
--vim.o.guifont = "InconsolataGo"

vim.opt.showmatch = true
vim.opt.hls = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.zenburn_high_Contrast = 1
vim.cmd('colorscheme zenburn')

-- Pymode stuff
vim.g.python_host_prog = '/Users/kevin/.local/share/virtualenvs/neovim2/bin/python'
vim.g.python3_host_prog = '/Users/kevin/.local/share/virtualenvs/neovim3/bin/python'

-- Adjust zenburn's garish search/visual colors.
vim.api.nvim_set_hl(0, 'IncSearch', { fg = 'NONE', bg = '#545449' })
vim.api.nvim_set_hl(0, 'Search', { fg = 'NONE', bg = '#545449' })
vim.api.nvim_set_hl(0, 'Visual', { fg = 'NONE', bg = '#444444' })
vim.api.nvim_set_hl(0, 'VisualNOS', { fg = 'NONE', bg = '#444444' })
vim.api.nvim_set_hl(0, 'IndentGuidesOdd', { bg = '#353535' })
vim.api.nvim_set_hl(0, 'IndentGuidesEven', { bg = '#494949' })

vim.keymap.set('', 'w', '<Plug>CamelCaseMotion_w', { silent = true })
vim.keymap.set('', 'W', '<Plug>CamelCaseMotion_b', { silent = true })
vim.keymap.set('', 'e', '<Plug>CamelCaseMotion_e', { silent = true })
vim.keymap.set('', 'E', '<Plug>CamelCaseMotion_ge', { silent = true })

-- tab navigation
vim.keymap.set('n', '<C-S-tab>', ':tabprevious<cr>')
vim.keymap.set('n', '<C-tab>', ':tabnext<cr>')
vim.keymap.set('', '<C-S-tab>', ':tabprevious<cr>')
vim.keymap.set('', '<C-tab>', ':tabnext<cr>')
vim.keymap.set('i', '<C-S-tab>', '<ESC>:tabprevious<cr>i')
vim.keymap.set('i', '<C-tab>', '<ESC>:tabnext<cr>i')
vim.keymap.set('n', '<C-t>', ':tabnew<cr>')
vim.keymap.set('i', '<C-t>', '<ESC>:tabnew<cr>')


-- vim.keymap.set('n', '<C-b>', ':Telescope find_files<cr>')
vim.keymap.set('n', '<C-p>', ':FZF<cr>')
vim.keymap.set("n", "<C-g>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set('n', '<C-b>', ':Telescope buffers<cr>')

vim.opt.wildignore:append({ '*.swp', '*.swo', '*.swn', '*.pyc' })
vim.opt.rtp:append({ '/usr/local/opt/fzf/' })

local make_group = vim.api.nvim_create_augroup('make', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = make_group,
  pattern = 'make',
  callback = function()
    vim.opt.expandtab = false
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 0
  end
})

vim.keymap.set('n', '<Space>', ':call nerdcommenter#Comment("n", "Toggle")<cr>')
vim.keymap.set('v', '<Space>', ':call nerdcommenter#Comment("n", "Toggle")<cr>')

vim.g.python_highlight_all = 1
vim.g.mapleader = ','

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '*.py' },
  command = 'silent !/Users/kevin/.local/bin/black % &'
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '*.ts', '*.html', '*.json', '*.js' },
  command = 'silent !/Users/kevin/code/tbcode/tbjs/node_modules/.bin/prettier --loglevel error --write % &'
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = '*.ts',
  command = [[silent !cd /Users/kevin/code/tbcode/tbjs && /Users/kevin/code/tbcode/tbjs/node_modules/.bin/eslint --plugin 'simple-import-sort' --parser '@typescript-eslint/parser' --fix --no-eslintrc --rule '"simple-import-sort/sort": [ "error", { "groups": [ ["^\\u0000"], ["^@?\\w"], ["^@tb/.*"], ["^\\."] ] } ]' %:p &]]
})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '*.bazel', '*.star', 'WORKSPACE' },
  command = 'silent !/usr/local/bin/buildifier % &'
})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = '*.rs',
  command = 'silent !/Users/kevin/.cargo/bin/rustfmt % &'
})

-- enable True Color support in terminal
vim.opt.termguicolors = true
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indent_guides_auto_colors = 1
vim.opt.colorcolumn = '+0'

vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#4E4E4E' })

vim.g.indent_guides_auto_colors = 0

-- Need this for vim commit editing to make backspace work for some reason
vim.opt.backspace = { 'indent', 'eol', 'start' }

if vim.fn.has('gui_vimr') then
  vim.keymap.set('n', '<D-S-{>', ':tabprevious<cr>')
  vim.keymap.set('n', '<D-S-}>', ':tabnext<cr>')
  vim.keymap.set('', '<D-S-{>', ':tabprevious<cr>')
  vim.keymap.set('', '<D-S-}>', ':tabnext<cr>')
  vim.keymap.set('i', '<D-S-{>', '<ESC>:tabprevious<cr>')
  vim.keymap.set('i', '<D-S-}>', '<ESC>:tabnext<cr>')

  -- delete the buffer rather than just closing the tab
  -- frees the LSP resources behind closed tabs
  vim.keymap.set('n', '<D-w>', ':bd<cr>')
  vim.keymap.set('', '<D-w>', ':bd<cr>')
end

-- https://unix.stackexchange.com/a/383044
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.api.nvim_command('checktime')
    end
  end
})

vim.api.nvim_create_autocmd({ 'FileChangedShellPost' }, {
  pattern = '*',
  callback = function()
    vim.api.nvim_echo({{ 'File changed on disk. Buffer reloaded.', 'WarningMsg' }}, false, {})
  end
})

-- https://stackoverflow.com/questions/52780939/disable-vim-e211-file-no-longer-available
vim.api.nvim_create_autocmd({ 'FileChangedShell' }, {
  pattern = '*',
  command = 'execute'
})

vim.keymap.set('n', '<leader>g', ':lgrep<space>', { silent = true })
vim.keymap.set('n', '[f', ':lprevious<cr>', { silent = true })
vim.keymap.set('n', ']f', ':lnext<cr>', { silent = true })

vim.g.fzf_action = {
	enter = 'drop',
	['ctrl-t'] = 'tab drop',
	['ctrl-x'] = 'split',
	['ctrl-v'] = 'vsplit',
}

-- Required for operations modifying multiple buffers like rename.
vim.opt.hidden = true

vim.opt.signcolumn = 'yes'

vim.opt.grepprg = 'rg -s --vimgrep --no-heading'
vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'

-- remove snipmate deprecation message
vim.g.snipMate = { snippet_version = 1 }

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'lua',
  callback = function()
    require('cmp').setup.buffer({
      sources = {
        { name = 'buffer' },
        { name = 'nvim_lua' },
      }
    })
  end
})


-- lsp logs are located at ~/.cache/nvim/lsp.log or ~/.local/state/nvim/lsp.log
-- depending on if you're v7 or v8
-- vim.lsp.set_log_level('debug')
-- import local callbacks module to override goToDefinition behavior
require('callbacks')
require('plugins')
require('compe-config')
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


  -- Mappings.
  local opts = { noremap=true, silent=true, buffer=bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>h', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<leader>l', vim.diagnostic.goto_next, opts)
end

local lsp_flags = { debounce_text_changes = 150 }

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "ruff_lsp", "rust_analyzer", "gopls", "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
  on_attach = on_attach,
  flags = lsp_flags,
}
end

-- https://github.com/cameron-martin/bazel-lsp
nvim_lsp.starlark_rust.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { "bazel-lsp" },
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = { "typescript" },
}

require('telescope').setup {
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- or `ignore_case` or `respect_case`
			case_mode = "smart_case", -- the default case_mode is `smart_case`
		}
	}
}

vim.g.snipMate = { snippet_version = 1 }
