M = require "base_plugin"

M.lazy = function()
  return {
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",       -- required
        "sindrets/diffview.nvim",      -- optional - Diff integration
        "nvim-telescope/telescope.nvim", -- optional
      },
      config = true
    }
  }
end

return M