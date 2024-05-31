local has_word_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 20
local MIN_LABEL_WIDTH = 20

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        "L3MON4D3/LuaSnip", -- snippet engine
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim", -- vs-code like pictograms
    },
    config = function()
        local cmp = require("cmp")

        local luasnip = require("luasnip")

        local lspkind = require("lspkind")
        -- lspkind.init({
        --     symbol_map = {
        --         Copilot = "",
        --     },
        -- })

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({

            enabled = function()
                local context = require 'cmp.config.context'
                if vim.api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,

            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    symbol_map = {
                        Copilot = '',
                    }
                })
            },

            -- configure lspkind for vs-code like pictograms in completion menu
            -- formatting = {
            --     format = lspkind.cmp_format({
            --         maxwidth = 50,
            --         ellipsis_char = "...",
            --         symbol_map = {
            --             Copilot = '',
            --         },
            --         before = function (entry, vim_item)
            --             local label = vim_item.abbr
            --             local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            --             if truncated_label ~= label then
            --                 vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            --             elseif string.len(label) < MIN_LABEL_WIDTH then
            --                 local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
            --                 vim_item.abbr = label .. padding
            --             end
            --             return vim_item
            --         end,
            --     }),
            -- },

            -- formatting = {
            --     format = function(entry, vim_item)
            --         local label = vim_item.abbr
            --         local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            --         if truncated_label ~= label then
            --             vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            --         elseif string.len(label) < MIN_LABEL_WIDTH then
            --             local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
            --             vim_item.abbr = label .. padding
            --         end
            --         return vim_item
            --     end,
            -- },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_word_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) == 1 then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
            }),

            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    function(entry1, entry2)
                        if package.loaded['copilot_cmp'] then
                            return require('copilot_cmp.comparators').prioritize(entry1, entry2)
                        end
                    end,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },

            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "copilot" },
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- snippets
                { name = "buffer" }, -- text within current buffer
                { name = "path" }, -- file system paths
            }),

            -- experimental = {
            --     ghost_text = true,
            -- },

            performance = {
                debounce = 150
            },

        })
    end,
}
