M = require "base_plugin"

M.lazy = function()
  return {
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        keywords = {
          OKAY = {
            icon = " ",
            color = "okay",
            alt = { "OK", "OKAY" },
          },
        },
        colors = {
          okay = { "Identifier", "#76FFCD" }
        }
      }
    }
  }
end

return M