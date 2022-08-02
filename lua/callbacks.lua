-- Override lsp goToDefinition to open it up in a new tab
-- https://www.reddit.com/r/neovim/comments/j2ny8b/is_there_a_way_to_open_a_new_tab_when_using_lua/g76ogzr/
local api = vim.api
local util = vim.lsp.util
local handlers = vim.lsp.handlers
local log = require 'vim.lsp.log'

-- open a result in an existing tab, failing that, a new tab
local tab_drop_result = function(result)
  local uri = result.uri or result.targetUri
  -- tab drop sees uris as unique from currently open files in tabs
  local fname = vim.uri_to_fname(uri)
  api.nvim_command("tab drop "..fname)
end

local location_handler = function(_, result, ctx, _)
  if result == nil or vim.tbl_isempty(result) then
    local _ = log.info() and log.info(ctx.method, 'No location found')
    return nil
  end
  -- textDocument/definition can return Location or Location[]
  -- https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition
  if vim.tbl_islist(result) then
    local target_result
    target_result = result[1]
    tab_drop_result(target_result)
    util.jump_to_location(target_result)
    if #result > 1 then
      util.set_qflist(util.locations_to_items(result))
      -- open alternate locations
      api.nvim_command("copen")
    end
  else
    tab_drop_result(result)
    util.jump_to_location(result)
  end
end

-- don't warn about the document already being edited, apply the changes
vim.lsp.util.apply_text_document_edit = function(text_document_edit, index, offset_encoding)
  local text_document = text_document_edit.textDocument
  local bufnr = vim.uri_to_bufnr(text_document.uri)

  vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
end

handlers['textDocument/declaration']    = location_handler
handlers['textDocument/definition']     = location_handler
handlers['textDocument/typeDefinition'] = location_handler
handlers['textDocument/implementation'] = location_handler
