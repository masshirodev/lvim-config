M = require "base_plugin"

M.lazy = function()
  return {
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
    }
  }
end

return M
