M = require "base_plugin"

M.lazy = function()
  return {
    {
      "danymat/neogen",
      dependencies = "nvim-treesitter/nvim-treesitter",
      config = true,
      -- Uncomment next line if you want to follow only stable versions
      -- version = "*"
    }
  }
end

return M