
  
  lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
  table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

  vim.g.copilot_no_tab_map = true
  vim.g.copilot_assume_mapped = true
  vim.g.copilot_tab_fallback = ""
  local cmp = require "cmp"

  lvim.builtin.cmp.mapping["<A-e>"] = function(fallback)
    cmp.mapping.abort()
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
      vim.api.nvim_feedkeys(copilot_keys, "i", true)
    else
      fallback()
    end
  end

  local copilot_indicator = function()
    local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
    if client == nil then
      return ""
    end

    if vim.tbl_isempty(client.requests) then
      return "idle" -- default icon whilst copilot is idle
    end

    local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners

    return spinners[frame + 1]
  end

  -- lvim.builtin.lualine.sections.lualine_x[#lvim.builtin.lualine.sections.lualine_x + 1] = { copilot_indicator }
  return {
    "zbirenbaum/copilot-cmp",
    "github/copilot.vim"
  }