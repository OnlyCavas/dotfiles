vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", ":bd<CR>", { noremap = true, silent = true })

-- delete without copying
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true })
vim.keymap.set("n", "dw", '"_dw', { noremap = true, silent = true })

-- windows
vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- fix paste mode
vim.api.nvim_set_keymap("n", "p", '"+p', { noremap = true })

-- window resize

-- save current
vim.api.nvim_set_keymap("n", "<C-S>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-S>", "<Esc>:w<CR>a", { noremap = true, silent = true })

-- save all
vim.api.nvim_set_keymap("n", "<C-S-S>", ":wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-S-S>", ":wa<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json" },
  callback = function()
    vim.api.nvim_set_option_value("formatprg", "jq", { scope = "local" })
  end,
})
