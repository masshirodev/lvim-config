M = require "base_plugin"

M.lazy = function()
  return {
    "nvim-neotest/neotest",
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
  }
end

return M