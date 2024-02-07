M = require "base_plugin"

M.lazy = function()
  return {
    "mfussenegger/nvim-jdtls"
  }
end

M.setup = function()
  vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })
end

return M