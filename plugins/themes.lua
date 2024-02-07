M = require "base_plugin"

M.lazy = function()
  return {
    "rebelot/kanagawa.nvim",
    "rmehri01/onenord.nvim",
    "patstockwell/vim-monokai-tasty",
    {
      'AlexvZyl/nordic.nvim',
      lazy = false,
      priority = 1000,
      config = function()
        require 'nordic'.load()
      end
    },
    "nyoom-engineering/nyoom.nvim",
    "tomasr/molokai",
    'rktjmp/lush.nvim',
    "scysta/pink-panic.nvim",
  }
end

return M