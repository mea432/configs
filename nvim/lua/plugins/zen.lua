return {
  "folke/zen-mode.nvim",
  -- This ensures the keybinding is registered by lazy.nvim
  keys = {
    { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
  },
  -- This part ensures tmux is fixed on exit
  init = function()
    vim.api.nvim_create_autocmd("VimLeave", {
      callback = function()
        -- Only run if we are actually inside a tmux session
        if os.getenv("TMUX") ~= nil then
          os.execute("tmux set-option status on")
        end
      end,
    })
  end,
  opts = {
    window = {
      backdrop = 0.95,
      width = 1, -- Changed from 200 to 0.85 so you can actually see the effect
      height = 1,
      options = {
        signcolumn = "no",
        number = false,
        relativenumber = true,
        laststatus = 0, -- hides the statusline
      },
    },
    plugins = {
      tmux = { enabled = true },
      twilight = { enabled = true },
    },
  },
}
