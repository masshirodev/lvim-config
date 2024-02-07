M = require "base_plugin"

M.lazy = function()
  return {
    {
      "kevinhwang91/nvim-ufo",
      dependencies = {
        "kevinhwang91/promise-async",
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' }
      }
    },
  }
end

return M