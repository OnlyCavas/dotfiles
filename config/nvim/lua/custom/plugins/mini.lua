return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.trailspace").setup()
      require("mini.splitjoin").setup()
      require("mini.cursorword").setup {
        delay = 1,
      }
      require("mini.move").setup {
        mappings = {
          -- visual mode
          left = "<M-Left>",
          right = "<M-Right>",
          down = "<M-Down>",
          up = "<M-Up>",

          -- normal mode
          line_left = "<M-Left>",
          line_right = "<M-Right>",
          line_down = "<M-Down>",
          line_up = "<M-Up>",
        },
      }
    end,
  },
}
