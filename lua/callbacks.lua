-- Override lsp goToDefinition to open it up in a new tab
-- https://www.reddit.com/r/neovim/comments/j2ny8b/is_there_a_way_to_open_a_new_tab_when_using_lua/g76ogzr/
local api = vim.api
local util = vim.lsp.util
local handlers = vim.lsp.handlers
local log = vim.lsp.log

-- open a result in an existing tab, failing that, a new tab
local tab_drop_result = function(result)
  local uri = result.uri or result.targetUri
  -- tab drop sees uris as unique from currently open files in tabs
  local fname = vim.uri_to_fname(uri)
  api.nvim_command("tab drop "..fname)
end

local location_handler = function(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
  local _ = log.info() and log.info(method, 'No location found')
  return nil
  end
  local target_result

  -- Save position in jumplist
  vim.cmd "normal! m'"

  --api.nvim_command('tab split')

  if vim.tbl_islist(result) then
    target_result = result[1]
    tab_drop_result(target_result)
    util.jump_to_location(target_result)
    if #result > 1 then
      util.set_qflist(util.locations_to_items(result))
      api.nvim_command("copen")
      api.nvim_command("wincmd p")
    end
  else
    target_result = result
    tab_drop_result(target_result)
    util.jump_to_location(target_result)
  end

  api.nvim_buf_set_option(0, 'buflisted', true)
  local range = target_result.range or target_result.targetSelectionRange
  local row = range.start.line
  local col = util._get_line_byte_from_position(0, range.start)
  api.nvim_win_set_cursor(0, {row + 1, col})
end

vim.lsp.util.apply_text_document_edit = function(text_document_edit, index)
  local text_document = text_document_edit.textDocument
  local bufnr = vim.uri_to_bufnr(text_document.uri)

  vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr)
end

handlers['textDocument/declaration']    = location_handler
handlers['textDocument/definition']     = location_handler
handlers['textDocument/typeDefinition'] = location_handler
handlers['textDocument/implementation'] = location_handler
