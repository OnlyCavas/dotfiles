local M = {}

M.colors = {}

local function parse_colors()
  local colors_file = vim.fn.expand("~/.cache/wal/colors.json")

  if vim.fn.filereadable(colors_file) == 1 then
    local json = vim.fn.json_decode(vim.fn.readfile(colors_file))
    if json and json.colors then
      M.colors = json.colors
      M.colors.special = {
        background = json.special.background,
        foreground = json.special.foreground,
        cursor = json.special.cursor,
      }
      return true
    end
  end

  return false
end

local function apply_colors()
  if not M.colors or vim.tbl_isempty(M.colors) then
    return
  end

  vim.cmd('hi clear')
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end
  vim.g.colors_name = 'pywal'

  local c = M.colors
  local hi = vim.api.nvim_set_hl

  -- ===== EDITOR COLORS =====
  hi(0, 'Normal', { fg = c.color7, bg = c.color0 })
  hi(0, 'NormalFloat', { fg = c.color7, bg = c.color0 })
  hi(0, 'NormalNC', { fg = c.color7, bg = c.color0 })
  hi(0, 'SignColumn', { fg = c.color7, bg = c.color0 })
  hi(0, 'EndOfBuffer', { fg = c.color0, bg = c.color0 })
  hi(0, 'ColorColumn', { bg = c.color8 })
  hi(0, 'Conceal', { fg = c.color8 })
  hi(0, 'Cursor', { fg = c.color0, bg = c.color7 })
  hi(0, 'CursorIM', { fg = c.color0, bg = c.color7 })
  hi(0, 'CursorColumn', { bg = c.color8 })
  hi(0, 'CursorLine', { bg = c.color8 })
  hi(0, 'Directory', { fg = c.color4 })
  hi(0, 'DiffAdd', { fg = c.color2, bg = c.color0 })
  hi(0, 'DiffChange', { fg = c.color3, bg = c.color0 })
  hi(0, 'DiffDelete', { fg = c.color1, bg = c.color0 })
  hi(0, 'DiffText', { fg = c.color4, bg = c.color0 })

  -- ===== UI ELEMENTS =====
  hi(0, 'VertSplit', { fg = c.color8, bg = c.color0 })
  hi(0, 'WinSeparator', { fg = c.color8, bg = c.color0 })
  hi(0, 'Folded', { fg = c.color8, bg = c.color0 })
  hi(0, 'FoldColumn', { fg = c.color8, bg = c.color0 })
  hi(0, 'LineNr', { fg = c.color8, bg = c.color0 })
  hi(0, 'LineNrAbove', { fg = c.color8, bg = c.color0 })
  hi(0, 'LineNrBelow', { fg = c.color8, bg = c.color0 })
  hi(0, 'CursorLineNr', { fg = c.color4, bg = c.color8, bold = true })
  hi(0, 'MatchParen', { fg = c.color1, bg = c.color8, bold = true })
  hi(0, 'ModeMsg', { fg = c.color2 })
  hi(0, 'MoreMsg', { fg = c.color2 })
  hi(0, 'NonText', { fg = c.color8 })
  hi(0, 'Question', { fg = c.color4 })
  hi(0, 'SpecialKey', { fg = c.color8 })
  hi(0, 'Title', { fg = c.color4, bold = true })
  hi(0, 'Visual', { bg = c.color8 })
  hi(0, 'VisualNOS', { bg = c.color8 })
  hi(0, 'WarningMsg', { fg = c.color3 })
  hi(0, 'Whitespace', { fg = c.color8 })
  hi(0, 'WildMenu', { fg = c.color0, bg = c.color4 })

  -- ===== SEARCH =====
  hi(0, 'Search', { fg = c.color0, bg = c.color3 })
  hi(0, 'IncSearch', { fg = c.color0, bg = c.color4 })
  hi(0, 'CurSearch', { fg = c.color0, bg = c.color1 })
  hi(0, 'Substitute', { fg = c.color0, bg = c.color2 })

  -- ===== SYNTAX HIGHLIGHTING =====
  hi(0, 'Comment', { fg = c.color8, italic = true })
  hi(0, 'Constant', { fg = c.color1 })
  hi(0, 'String', { fg = c.color2 })
  hi(0, 'Character', { fg = c.color2 })
  hi(0, 'Number', { fg = c.color3 })
  hi(0, 'Boolean', { fg = c.color3 })
  hi(0, 'Float', { fg = c.color3 })
  hi(0, 'Identifier', { fg = c.color4 })
  hi(0, 'Function', { fg = c.color4 })
  hi(0, 'Statement', { fg = c.color5 })
  hi(0, 'Conditional', { fg = c.color5 })
  hi(0, 'Repeat', { fg = c.color5 })
  hi(0, 'Label', { fg = c.color5 })
  hi(0, 'Operator', { fg = c.color5 })
  hi(0, 'Keyword', { fg = c.color5 })
  hi(0, 'Exception', { fg = c.color5 })
  hi(0, 'PreProc', { fg = c.color6 })
  hi(0, 'Include', { fg = c.color6 })
  hi(0, 'Define', { fg = c.color6 })
  hi(0, 'Macro', { fg = c.color6 })
  hi(0, 'PreCondit', { fg = c.color6 })
  hi(0, 'Type', { fg = c.color6 })
  hi(0, 'StorageClass', { fg = c.color6 })
  hi(0, 'Structure', { fg = c.color6 })
  hi(0, 'Typedef', { fg = c.color6 })
  hi(0, 'Special', { fg = c.color7 })
  hi(0, 'SpecialChar', { fg = c.color7 })
  hi(0, 'Tag', { fg = c.color4 })
  hi(0, 'Delimiter', { fg = c.color7 })
  hi(0, 'SpecialComment', { fg = c.color8, italic = true })
  hi(0, 'Debug', { fg = c.color1 })
  hi(0, 'Underlined', { fg = c.color4, underline = true })
  hi(0, 'Ignore', { fg = c.color8 })
  hi(0, 'Error', { fg = c.color1, bg = c.color0, bold = true })
  hi(0, 'Todo', { fg = c.color3, bg = c.color0, bold = true })

  -- ===== STATUSLINE =====
  hi(0, 'StatusLine', { fg = c.color7, bg = c.color8 })
  hi(0, 'StatusLineNC', { fg = c.color8, bg = c.color0 })
  hi(0, 'StatusLineTerm', { fg = c.color7, bg = c.color8 })
  hi(0, 'StatusLineTermNC', { fg = c.color8, bg = c.color0 })

  -- ===== TABLINE =====
  hi(0, 'TabLine', { fg = c.color7, bg = c.color8 })
  hi(0, 'TabLineFill', { bg = c.color0 })
  hi(0, 'TabLineSel', { fg = c.color0, bg = c.color4, bold = true })

  -- ===== POPUP MENU =====
  hi(0, 'Pmenu', { fg = c.color7, bg = c.color8 })
  hi(0, 'PmenuSel', { fg = c.color0, bg = c.color4 })
  hi(0, 'PmenuSbar', { bg = c.color8 })
  hi(0, 'PmenuThumb', { bg = c.color4 })

  -- ===== MESSAGES =====
  hi(0, 'ErrorMsg', { fg = c.color1, bold = true })
  hi(0, 'MsgArea', { fg = c.color7 })
  hi(0, 'MsgSeparator', { fg = c.color8 })

  -- ===== LSP =====
  hi(0, 'DiagnosticError', { fg = c.color1 })
  hi(0, 'DiagnosticWarn', { fg = c.color3 })
  hi(0, 'DiagnosticInfo', { fg = c.color4 })
  hi(0, 'DiagnosticHint', { fg = c.color6 })
  hi(0, 'DiagnosticOk', { fg = c.color2 })
  hi(0, 'DiagnosticUnderlineError', { sp = c.color1, underline = true })
  hi(0, 'DiagnosticUnderlineWarn', { sp = c.color3, underline = true })
  hi(0, 'DiagnosticUnderlineInfo', { sp = c.color4, underline = true })
  hi(0, 'DiagnosticUnderlineHint', { sp = c.color6, underline = true })

  -- LSP Semantic Tokens
  hi(0, '@lsp.type.class', { link = 'Type' })
  hi(0, '@lsp.type.decorator', { link = 'Function' })
  hi(0, '@lsp.type.enum', { link = 'Type' })
  hi(0, '@lsp.type.enumMember', { link = 'Constant' })
  hi(0, '@lsp.type.function', { link = 'Function' })
  hi(0, '@lsp.type.interface', { link = 'Type' })
  hi(0, '@lsp.type.macro', { link = 'Macro' })
  hi(0, '@lsp.type.method', { link = 'Function' })
  hi(0, '@lsp.type.namespace', { link = 'Type' })
  hi(0, '@lsp.type.parameter', { link = 'Identifier' })
  hi(0, '@lsp.type.property', { link = 'Identifier' })
  hi(0, '@lsp.type.struct', { link = 'Type' })
  hi(0, '@lsp.type.type', { link = 'Type' })
  hi(0, '@lsp.type.typeParameter', { link = 'Type' })
  hi(0, '@lsp.type.variable', { link = 'Identifier' })

  -- ===== TREESITTER =====
  hi(0, '@attribute', { fg = c.color6 })
  hi(0, '@boolean', { fg = c.color3 })
  hi(0, '@character', { fg = c.color2 })
  hi(0, '@comment', { fg = c.color8, italic = true })
  hi(0, '@conditional', { fg = c.color5 })
  hi(0, '@constant', { fg = c.color1 })
  hi(0, '@constant.builtin', { fg = c.color1 })
  hi(0, '@constant.macro', { fg = c.color1 })
  hi(0, '@constructor', { fg = c.color4 })
  hi(0, '@error', { fg = c.color1 })
  hi(0, '@exception', { fg = c.color5 })
  hi(0, '@field', { fg = c.color4 })
  hi(0, '@float', { fg = c.color3 })
  hi(0, '@function', { fg = c.color4 })
  hi(0, '@function.builtin', { fg = c.color4 })
  hi(0, '@function.macro', { fg = c.color6 })
  hi(0, '@include', { fg = c.color6 })
  hi(0, '@keyword', { fg = c.color5 })
  hi(0, '@keyword.function', { fg = c.color5 })
  hi(0, '@keyword.operator', { fg = c.color5 })
  hi(0, '@label', { fg = c.color5 })
  hi(0, '@method', { fg = c.color4 })
  hi(0, '@namespace', { fg = c.color6 })
  hi(0, '@number', { fg = c.color3 })
  hi(0, '@operator', { fg = c.color5 })
  hi(0, '@parameter', { fg = c.color7 })
  hi(0, '@property', { fg = c.color4 })
  hi(0, '@punctuation.bracket', { fg = c.color7 })
  hi(0, '@punctuation.delimiter', { fg = c.color7 })
  hi(0, '@punctuation.special', { fg = c.color7 })
  hi(0, '@repeat', { fg = c.color5 })
  hi(0, '@string', { fg = c.color2 })
  hi(0, '@string.escape', { fg = c.color6 })
  hi(0, '@string.regex', { fg = c.color6 })
  hi(0, '@tag', { fg = c.color4 })
  hi(0, '@tag.attribute', { fg = c.color6 })
  hi(0, '@tag.delimiter', { fg = c.color7 })
  hi(0, '@text', { fg = c.color7 })
  hi(0, '@text.strong', { bold = true })
  hi(0, '@text.emphasis', { italic = true })
  hi(0, '@text.underline', { underline = true })
  hi(0, '@text.title', { fg = c.color4, bold = true })
  hi(0, '@text.literal', { fg = c.color2 })
  hi(0, '@text.uri', { fg = c.color4, underline = true })
  hi(0, '@type', { fg = c.color6 })
  hi(0, '@type.builtin', { fg = c.color6 })
  hi(0, '@variable', { fg = c.color7 })
  hi(0, '@variable.builtin', { fg = c.color1 })

  -- ===== GIT =====
  hi(0, 'GitSignsAdd', { fg = c.color2 })
  hi(0, 'GitSignsChange', { fg = c.color3 })
  hi(0, 'GitSignsDelete', { fg = c.color1 })
  hi(0, 'diffAdded', { fg = c.color2 })
  hi(0, 'diffRemoved', { fg = c.color1 })
  hi(0, 'diffChanged', { fg = c.color3 })
  hi(0, 'diffOldFile', { fg = c.color1 })
  hi(0, 'diffNewFile', { fg = c.color2 })
  hi(0, 'diffFile', { fg = c.color4 })
  hi(0, 'diffLine', { fg = c.color8 })
  hi(0, 'diffIndexLine', { fg = c.color8 })

  -- ===== TELESCOPE =====
  hi(0, 'TelescopeBorder', { fg = c.color4, bg = c.color0 })
  hi(0, 'TelescopePromptBorder', { fg = c.color4, bg = c.color0 })
  hi(0, 'TelescopeResultsBorder', { fg = c.color8, bg = c.color0 })
  hi(0, 'TelescopePreviewBorder', { fg = c.color8, bg = c.color0 })
  hi(0, 'TelescopeSelection', { fg = c.color0, bg = c.color4 })
  hi(0, 'TelescopeSelectionCaret', { fg = c.color1 })
  hi(0, 'TelescopeMultiSelection', { fg = c.color2 })
  hi(0, 'TelescopeNormal', { fg = c.color7, bg = c.color0 })
  hi(0, 'TelescopeMatching', { fg = c.color4, bold = true })
  hi(0, 'TelescopePromptPrefix', { fg = c.color4 })

  -- ===== NVIM-TREE =====
  hi(0, 'NvimTreeNormal', { fg = c.color7, bg = c.color0 })
  hi(0, 'NvimTreeFolderIcon', { fg = c.color4 })
  hi(0, 'NvimTreeFolderName', { fg = c.color4 })
  hi(0, 'NvimTreeOpenedFolderName', { fg = c.color4, bold = true })
  hi(0, 'NvimTreeRootFolder', { fg = c.color5, bold = true })
  hi(0, 'NvimTreeSpecialFile', { fg = c.color3 })
  hi(0, 'NvimTreeGitDirty', { fg = c.color3 })
  hi(0, 'NvimTreeGitNew', { fg = c.color2 })
  hi(0, 'NvimTreeGitDeleted', { fg = c.color1 })

  -- ===== WHICH-KEY =====
  hi(0, 'WhichKey', { fg = c.color4 })
  hi(0, 'WhichKeyGroup', { fg = c.color6 })
  hi(0, 'WhichKeyDesc', { fg = c.color7 })
  hi(0, 'WhichKeySeparator', { fg = c.color8 })
  hi(0, 'WhichKeyFloat', { bg = c.color0 })

  -- ===== INDENT-BLANKLINE =====
  hi(0, 'IndentBlanklineChar', { fg = c.color8 })
  hi(0, 'IndentBlanklineContextChar', { fg = c.color4 })

  -- ===== MISC PLUGINS =====
  hi(0, 'NeoTreeNormal', { fg = c.color7, bg = c.color0 })
  hi(0, 'NeoTreeNormalNC', { fg = c.color7, bg = c.color0 })
  hi(0, 'BufferLineFill', { bg = c.color0 })
  hi(0, 'BufferLineBackground', { fg = c.color8, bg = c.color0 })
  hi(0, 'BufferLineBufferSelected', { fg = c.color0, bg = c.color4, bold = true })
  hi(0, 'LspReferenceText', { bg = c.color8 })
  hi(0, 'LspReferenceRead', { bg = c.color8 })
  hi(0, 'LspReferenceWrite', { bg = c.color8 })
end

function M.load()
  if parse_colors() then
    apply_colors()
    return true
  else
    vim.notify("Pywal colors not found!", vim.log.levels.WARN)
    return false
  end
end

function M.setup(opts)
  opts = opts or {}

  M.load()

  if opts.auto_reload ~= false then
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
        M.load()
      end,
    })
  end

  vim.api.nvim_create_user_command('PywalReload', function()
    M.load()
    vim.notify("Pywal colors reloaded!", vim.log.levels.INFO)
  end, {})
end

return M
