function _G.write_buf_with_sudo()
  if not vim.bo.modified then
    return
  end
  vim.bo.modified = false
  vim.cmd('write !sudo tee > /dev/null "%"')
  if vim.v.shell_error ~= 0 then
    vim.bo.modified = true
  end
end

vim.api.nvim_command [[command W call v:lua.write_buf_with_sudo()]]
