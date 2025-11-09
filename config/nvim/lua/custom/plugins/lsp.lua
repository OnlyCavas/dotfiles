local is_nixos = vim.fn.filereadable('/etc/NIXOS') == 1

local setupMason = function(servers)
  local servers_to_install = vim.tbl_filter(function(key)
    local t = servers[key]
    if type(t) == "table" then
      return not t.manual_install
    else
      return t
    end
  end, vim.tbl_keys(servers))

  require("mason-tool-installer").setup { ensure_installed = servers_to_install }
end

local enable_capabilities = function(servers, capabilities)
  for name, config in pairs(servers) do
    if config == true then
      config = {}
    end
    config = vim.tbl_deep_extend("force", {}, {
      capabilities = capabilities,
    }, config)

    vim.lsp.config(name, config)
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },

      -- Ui element
      { "j-hui/fidget.nvim", opts = {} },

      -- Mason
      {
        "williamboman/mason.nvim",
        enabled = not is_nixos,
        config = true
      },
      {
        "williamboman/mason-lspconfig.nvim",
        enabled = not is_nixos,
      },
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        enabled = not is_nixos,
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        lua_ls = {
          server_capabilities = {
            semanticTokensProvider = vim.NIL,
          },
        },
        gopls = {},
        nixd = {
          settings = {
            nixd = {
              formatting = {
                command = { "nixpkgs-fmt" },
              },
            },
          },
        },
      }

      if not is_nixos then
        setupMason(servers)
      end

      enable_capabilities(servers, capabilities)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua",
          "python",
          "typescript",
          "javascript",
          "rust",
          "go",
          "nix"
        },
        callback = function(args)
          local ft_to_lsp = {
            lua = "lua_ls",
            nix = "nixd",
            go = "gopls",
          }

          local lsp_name = ft_to_lsp[vim.bo[args.buf].filetype]

          if lsp_name then
            vim.lsp.enable(lsp_name)
          end
        end,
      })

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          for _, client in ipairs(vim.lsp.get_clients()) do
            client.stop(true)
          end
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          local settings = servers[client.name]
          if type(settings) ~= "table" then
            settings = {}
          end

          local builtin = require "telescope.builtin"

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
          vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end

          -- Override server capabilities
          if settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                ---@diagnostic disable-next-line: cast-local-type
                v = nil
              end

              client.server_capabilities[k] = v
            end
          end
        end,
      })
    end,
  },
}
