return {
  "folke/flash.nvim",
  config = function(_, opts)
    require("flash").setup(opts)

    -- Override backdrop highlight so text doesn't get greyed out
    --vim.api.nvim_set_hl(0, "FlashBackdrop", { link = "NONE" })
    -- Override match highlight so 'f'-like search is the same as '/'-like search
    --vim.api.nvim_set_hl(0, "FlashLabel", { link = "Search" })
  end,
}
