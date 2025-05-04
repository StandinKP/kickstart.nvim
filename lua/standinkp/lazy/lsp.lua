return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'j-hui/fidget.nvim',
  },
  event = 'BufReadPre',
  config = function(event)
    local cmp = require 'cmp'
    local cmp_lsp = require 'cmp_nvim_lsp'
    local capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

    require('fidget').setup {}
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'gopls',
        'ruff',
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
          }
        end,

        ['lua_ls'] = function()
          local lspconfig = require 'lspconfig'
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' },
                },
              },
            },
          }
        end,
        ['rust_analyzer'] = function()
          local lspconfig = require 'lspconfig'
          lspconfig.rust_analyzer.setup {
            capabilities = capabilities,
            filetypes = { 'rust' },
            root_dir = lspconfig.util.root_pattern('Cargo.toml', 'rust-project.json'),
            settings = {
              ['rust-analyzer'] = {
                cargo = {
                  allFeatures = true,
                },
              },
            },
          }
        end,
      },
    }
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local kind_icons = {
      Text = '',
      Method = '󰆧',
      Function = '󰊕',
      Constructor = '',
      Field = '󰇽',
      Variable = '󰂡',
      Class = '󰠱',
      Interface = '',
      Module = '',
      Property = '󰜢',
      Unit = '',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰏿',
      Struct = '',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '󰅲',
    }
    cmp.setup {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete(),
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp' }, -- lsp
        { name = 'path', max_item_count = 7 }, -- file system paths
        { name = 'buffer' }, -- text within current buffer
        { name = 'copilot' }, -- Copilot suggestions
        { name = 'luasnip', max_item_count = 5 }, -- snippets
      },
      formatting = {
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
          -- Source
          vim_item.menu = ({
            buffer = '[Buffer]',
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            nvim_lua = '[Lua]',
            latex_symbols = '[LaTeX]',
          })[entry.source.name]
          return vim_item
        end,
      },
    }

    vim.diagnostic.config {
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
      },
    }
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-T>.
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    -- Find references for the word under your cursor.
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    -- Fuzzy find all the symbols in your current workspace
    --  Similar to document symbols, except searches over your whole project.
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- Rename the variable under your cursor
    --  Most Language Servers support renaming across files, etc.
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end,
}
