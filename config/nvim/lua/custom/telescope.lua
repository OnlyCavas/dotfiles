local data = assert(vim.fn.stdpath "data") --[[@as string]]
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      "dune.lock",
      ".git",
      "_build",
      "node_modules",
      "deps",
      ".elixir_ls",
    },
  },
  pickers = {
    find_files = {
      -- theme = "cursor",
      hidden = true,
      no_ignore = true,
      mappings = {
        i = {
          ["<m-cr>"] = function(prompt_bufnr)
            local entry = action_state.get_selected_entry()
            local file_path = entry.path or entry.filename
            actions.close(prompt_bufnr)
            vim.cmd("vsplit " .. file_path)
          end,
        },
      },
    },
  },
  extensions = {
    wrap_results = true,

    fzf = {},

    ["ui-select"] = {
      require("telescope.themes").get_ivy {},
    },
  },
}

pcall(require("telescope").load_extension, "fzf")
-- pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require "telescope.builtin"

vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>fg", function()
  return builtin.git_files { cwd = vim.fn.expand "%:h" }
end)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
-- vim.keymap.set("n", "<leader>fg", require "custom.telescope.multi-ripgrep")
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)

vim.keymap.set("n", "<leader>fw", builtin.grep_string)

vim.keymap.set("n", "<leader>fa", function()
  ---@diagnostic disable-next-line: param-type-mismatch
  builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
end)

-- Open current configuration
vim.keymap.set("n", "<leader>en", function()
  builtin.find_files { cwd = vim.fn.stdpath "config" }
end)

vim.keymap.set("n", "<leader>eo", function()
  builtin.find_files { cwd = "~/.config/nvim-backup/" }
end)

vim.keymap.set("n", "<leader>fp", function()
  builtin.find_files { cwd = "~/dev/" }
end)
