-- Override lsp goToDefinition to open it up in a new tab
-- https://www.reddit.com/r/neovim/comments/j2ny8b/is_there_a_way_to_open_a_new_tab_when_using_lua/g76ogzr/
local api = vim.api
local util = vim.lsp.util
local handlers = vim.lsp.handlers
local log = vim.lsp.log
 
local location_handler = function(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
  local _ = log.info() and log.info(method, 'No location found')
  return nil
  end
 
  api.nvim_command('tab split')
 
  if vim.tbl_islist(result) then
    util.jump_to_location(result[1])
    if #result > 1 then
      util.set_qflist(util.locations_to_items(result))
      api.nvim_command("copen")
      api.nvim_command("wincmd p")
    end
  else
    util.jump_to_location(result)
  end
end
 
handlers['textDocument/declaration']    = location_handler
handlers['textDocument/definition']     = location_handler
handlers['textDocument/typeDefinition'] = location_handler
handlers['textDocument/implementation'] = location_handler
