M = require "base_plugin"

M.lazy = function()
  return {
    {
      "masshirodev/rayso-snap.nvim",
      init = function()
        require 'raysosnap'.setup({
          theme = 'midnight',
          background = 'true',
          darkMode = 'true',
          padding = '16',
          language = 'auto'
        })
      end,
    }
  }
end

return M