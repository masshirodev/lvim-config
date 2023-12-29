return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      { 'neoclide/coc.nvim',               branch = 'master',  build = 'yarn install --frozen-lockfile' },
      { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' }
    }
    --   event = "BufReadPost", -- needed for folds to load properly
    --   keys = {
    --     {
    --       "zr",
    --       function() require("ufo").openFoldsExceptKinds { "comment" } end,
    --       desc = "󰘖 󱃄 Open All Folds except comments",
    --     },
    --     { "zm", function() require("ufo").closeAllFolds() end, desc = "󰘖 󱃄 Close All Folds" },
    --     {
    --       "z1",
    --       function() require("ufo").closeFoldsWith(1) end,
    --       desc = "󰘖 󱃄 Close Level 1 Folds",
    --     },
    --     {
    --       "z2",
    --       function() require("ufo").closeFoldsWith(2) end,
    --       desc = "󰘖 󱃄 Close Level 2 Folds",
    --     },
    --     {
    --       "z3",
    --       function() require("ufo").closeFoldsWith(3) end,
    --       desc = "󰘖 󱃄 Close Level 3 Folds",
    --     },
    --     {
    --       "z4",
    --       function() require("ufo").closeFoldsWith(4) end,
    --       desc = "󰘖 󱃄 Close Level 4 Folds",
    --     },
    --   },
    --   init = function()
    --     -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
    --     -- auto-closing them after leaving insert mode, however ufo does not seem to
    --     -- have equivalents for zr and zm because there is no saved fold level.
    --     -- Consequently, the vim-internal fold levels need to be disabled by setting
    --     -- them to 99
    --     vim.opt.foldlevel = 99
    --     vim.opt.foldlevelstart = 99
    --   end,
    --   opts = {
    --     provider_selector = function(_, ft, _)
    --       -- INFO some filetypes only allow indent, some only LSP, some only
    --       -- treesitter. However, ufo only accepts two kinds as priority,
    --       -- therefore making this function necessary :/
    --       local lspWithOutFolding =
    --       { "markdown", "bash", "sh", "bash", "zsh", "css", "html", "python" }
    --       if vim.tbl_contains(lspWithOutFolding, ft) then
    --         return { "treesitter", "indent" }
    --       else
    --         return { "lsp", "indent" }
    --       end
    --     end,
    --     -- open opening the buffer, close these fold kinds
    --     -- use `:UfoInspect` to get available fold kinds from the LSP
    --     close_fold_kinds = { "imports" },
    --     open_fold_hl_timeout = 500,
    --     fold_virt_text_handler = foldTextFormatter,
    --   },
  },
}
