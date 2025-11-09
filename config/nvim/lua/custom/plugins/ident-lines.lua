return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = {
      char = "╎",
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)

    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#5c4d7d" })
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#9d7cd8" })
  end,
}
