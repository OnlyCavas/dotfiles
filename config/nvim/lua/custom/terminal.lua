local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_new_buffer()
  vim.api.nvim_create_autocmd({ "QuitPre" }, {
    callback = function(context)
      vim.api.nvim_buf_delete(state.floating.buf, { force = true })
    end,
  })

  return vim.api.nvim_create_buf(false, true)
end

local function create_floating_terminal(opts)
  local buf = nil

  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.85)
  local height = opts.height or math.floor(vim.o.lines * 0.85)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = create_new_buffer()
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_terminal { buf = state.floating.buf }

    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd "terminal"
    end

    vim.cmd "startinsert"
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- command
vim.api.nvim_create_user_command("FloatTerminal", toggle_terminal, {})

-- keymaps
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "n", "t" }, "<C-ç>", toggle_terminal, { noremap = true, silent = true })
