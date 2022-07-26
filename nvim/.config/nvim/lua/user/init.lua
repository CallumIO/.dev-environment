local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme
  colorscheme = "catppuccin",

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
    },
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = function(C)
      C.fg = "#abb2bf"
      C.telescope_green = C.green
      C.telescope_red = C.red
      C.telescope_fg = C.fg
      C.telescope_bg = C.black_1
      C.telescope_bg_alt = C.bg_1
      return C
    end,
    -- Modify the highlight groups
    highlights = function(highlights)
      local C = require "default_theme.colors"
      highlights.Normal = { fg = C.fg, bg = C.bg }
      highlights.TelescopeBorder = { fg = C.telescope_bg_alt, bg = C.telescope_bg }
      highlights.TelescopeNormal = { bg = C.telescope_bg }
      highlights.TelescopePreviewBorder = { fg = C.telescope_bg, bg = C.telescope_bg }
      highlights.TelescopePreviewNormal = { bg = C.telescope_bg }
      highlights.TelescopePreviewTitle = { fg = C.telescope_bg, bg = C.telescope_green }
      highlights.TelescopePromptBorder = { fg = C.telescope_bg_alt, bg = C.telescope_bg_alt }
      highlights.TelescopePromptNormal = { fg = C.telescope_fg, bg = C.telescope_bg_alt }
      highlights.TelescopePromptPrefix = { fg = C.telescope_red, bg = C.telescope_bg_alt }
      highlights.TelescopePromptTitle = { fg = C.telescope_bg, bg = C.telescope_red }
      highlights.TelescopeResultsBorder = { fg = C.telescope_bg, bg = C.telescope_bg }
      highlights.TelescopeResultsNormal = { bg = C.telescope_bg }
      highlights.TelescopeResultsTitle = { fg = C.telescope_bg, bg = C.telescope_bg }
      return highlights
    end,
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
      {
        "andweeb/presence.nvim"
      },
      {
        "simrat39/rust-tools.nvim",
        config = function()
          require('rust-tools').setup({})
        end,
      },
      {
       "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup()
        end,
      }
    },
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.rufo,
        null_ls.builtins.formatting.black.with({
          extra_args = {"--line-length", "101"}
        }),
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.fixjson,
        -- Set a linter
        null_ls.builtins.diagnostics.rubocop,
      }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table
    end,
    treesitter = {
      ensure_installed = { "lua" },
    },
    ["nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua" },
    },
    packer = {
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- which-key registration table for normal mode, leader prefix
          -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
        },
      },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without lsp-installer
    servers = {
      -- "pyright"
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  mappings = {
    -- first key is the mode
    n = {
      -- UNBINDS
      ["<C-s>"] = false,
      ["<C-q>"] = false,
      ["jk"] = false,
      -- BINDS
      -- easy buffer
      [ "<Tab>" ] = { ":bnext<cr>", desc = "Next file in buffer" },
      [ "<S-Tab>" ] = { ":bprevious<cr>", desc = "Previous file in buffer" },
      -- arrow resize
      ["<C-Up>"] = {
        function()
          require("smart-splits").resize_up(2)
        end,
        desc = "Resize split up",
      },
      ["<C-Down>"] = {
        function()
          require("smart-splits").resize_down(2)
        end,
        desc = "Resize split down",
      },
      ["<C-Left>"] = {
        function()
          require("smart-splits").resize_left(2)
        end,
        desc = "Resize split left",
      },
      ["<C-Right>"] = {
        function()
          require("smart-splits").resize_right(2)
        end,
        desc = "Resize split right",
      },
      -- arrow move 
      ["<Up>"] = {
        function()
          require("smart-splits").move_cursor_up(2)
        end,
        desc = "Move to split up",
      },
      ["<Down>"] = {
        function()
          require("smart-splits").move_cursor_down(2)
        end,
        desc = "Move to split down",
      },
      ["<Left>"] = {
        function()
          require("smart-splits").move_cursor_left(2)
        end,
        desc = "Move to split left",
      },
      ["<Right>"] = {
        function()
          require("smart-splits").move_cursor_right(2)
        end,
        desc = "Move to split right",
      },
      -- splits
      ["\\"] = { "<cmd>vsplit<cr>", desc = "Vertical split" },
      ["|"] = { "<cmd>split<cr>", desc = "Horizontal split" },
      -- inc / dec
      ["-"] = { "<c-x>", desc = "Descrement number" },
      ["+"] = { "<c-a>", desc = "Increment number" },
      -- nav wrapped lines
      j = { "gj", desc = "Navigate down" },
      k = { "gk", desc = "Navigate down" },
      -- goto end
      ["ge"] = { "g$", desc = "End of line" },
    },
    t = {
      ["<esc>"] = false,
      ["jk"] = false,
      ["<esc><esc>"] = { "<c-\\><c-n>:q<cr>", desc = "Terminal quit" },
      ["<c-q>"] = { "<c-\\><c-n>", desc = "Terminal normal mode" },
    },
    v = {
      -- nav wrapped lines
      j = { "gj", desc = "Navigate down" },
      k = { "gk", desc = "Navigate down" },
    },
    i = {
      ["jk"] = false,
    }
  },

  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

vim.g.catppuccin_flavour = "macchiato"

return config
