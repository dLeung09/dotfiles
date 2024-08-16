-- LSP diagnostics options
vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness
    vim.api.nvim_set_keymap("n", "<S-Tab>", "<cmd>ClangdSwitchSourceHeader<CR>", { noremap = true, silent = true })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Use an on_attch function to only map the following keys after the
    -- language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
      end

      -- Highlight symbol under cursor
      if client.server_capabilities.documentHighlightProvider then
        vim.cmd([[
                    highlight link LspReferenceRead Visual
                    highlight link LspReferenceText Visual
                    highlight link LspReferenceWrite Visual
                    augroup lsp_document_highlight
                        autocmd! * <buffer>
                        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                    augroup END
                ]])
      end

      -- TODO - once I look at `nvim-navic`
      -- if client.server_capabilities.documentSybolProvider then
      --     require("nvim-navic").attach(client, bufnr)
      -- end

      -- Mappings
      local opts = { noremap = true, silent = true }

      -- -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      buf_set_keymap("n", "<C-LeftMouse>", "<LeftMouse><cmd>Telescope lsp_definitions<CR>", opts)
      buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      buf_set_keymap("n", "<C-p>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
      buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
      buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
      -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap("n", "<space>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
      buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
      buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
      buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
      -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
      buf_set_keymap("n", "<space>q", "<cmd>Telescope document_diagnostics<CR>", opts)
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach, -- is this necessary
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          on_attach = on_attach, -- is this necessary?
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
                disable = { "lowercase-global" },
              },
              completion = {
                callSnippet = "Replace",
              },
              runtime = {
                version = "LuaJIT",
              },
              telemetry = {
                enable = false,
              },
            },
          },
        })
      end,
      ["clangd"] = function()
        lspconfig["clangd"].setup({
          capabilities = capabilities,
          on_attach = on_attach, -- is this necessary
          cmd = {
            "clangd",
            "--limit-references=0",
            "--offset-encoding=utf-16",
          },
        })
      end,
      ["ruff"] = function()
        lspconfig["ruff"].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      -- ["pyright"] = function()
      --   lspconfig["pyright"].setup({
      --     capabilities = capabilities,
      --     on_attach = on_attach, -- is this necessary
      --   })
      -- end,
    })
  end,
  opts = {
    servers = {
      clangd = {},
      lua_ls = {},
      ruff = {},
    },
  },
}
