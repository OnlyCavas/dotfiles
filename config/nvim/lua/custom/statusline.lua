require("lualine").setup {
  options = {
    theme = 'gruvbox-material',
    component_separators = { left = "\u{e0b9}", right = "\u{e0bf}" },
    section_separators = { left = "\u{e0bc}", right = "\u{e0be}" },
  },
  sections = {
    lualine_a = {
      { 'mode', icon = '' }
    },
    lualine_b = {
      'branch',
      'diff',
    },
    lualine_c = {
      {
        'filename',
        path = 0,
        symbols = {
          modified = ' ●',
          readonly = '',
          unnamed = '[No Name]',
        }
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        symbols = { error = '', warn = '', info = '', hint = '󰺴' },
      },
      'encoding',
      {
        'fileformat',
        symbols = {
          unix = '',
          dos = '',
          mac = '',
        }
      },
    },
    lualine_y = {
      'filetype',
      'progress',
    },
    lualine_z = {
      'location'
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
}
