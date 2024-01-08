local M = {}

function M.meta(x)
  if vim.fn.has('mac') == 1 then
    return '<d-' .. x .. '>'
  end
  return '<m-' .. x .. '>'
end

return M
