require 'clipboard-image'.setup {
  default = {
    img_name = function()
      vim.fn.inputsave()
      local name = vim.fn.input('Save image as: ')
      vim.fn.inputrestore()
      return name
    end,
  },
  asciidoc = {
    img_dir = function()
      return vim.fn.expand('%:r')
    end,
    img_dir_txt = "{docname}",
    affix = "image::%s[]",
  }
}
