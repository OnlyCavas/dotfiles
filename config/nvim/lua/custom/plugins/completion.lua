return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "1.*",
    build = 'cargo build --release',
    opts = {
      keymap = {
        preset = "default",

        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },

        ["<S-Tab>"] = { "snippet_forward", "fallback" },
        ["<C-S-Tab>"] = { "snippet_backward", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      completion = {
        menu = {
          border = 'rounded', -- 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
          winblend = 0,       -- Transparency (0-100)
          winhighlight =
          'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
          scrollbar = true,
          draw = {
            columns = {
              { "label",     "label_description", gap = 1 },
              { "kind_icon", "kind",              gap = 1 },
            },
          },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = {
            border = 'rounded',
            winblend = 0,
            winhighlight =
            'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
          },
        },
        signature = {
          enabled = true,
          window = {
            border = 'rounded',
            winblend = 0,
            winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
          },
        },
        ghost_text = {
          enabled = true,
          show_with_menu = false,
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },
      fuzzy = {
        implementation = "prefer_rust",
        frecency = {
          enabled = false,
        },
      }
    },
    opts_extend = { "sources.default" },
  },
}
