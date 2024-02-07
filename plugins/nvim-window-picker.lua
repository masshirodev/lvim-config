M = require "base_plugin"

M.lazy = function()
  return {
    {
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      config = function()
        require 'window-picker'.setup()
      end,
    }
  }
end

return M