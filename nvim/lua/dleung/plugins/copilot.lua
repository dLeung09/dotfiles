return {
    "zbirenbaum/copilot.lua",
    dependencies = {
        {
            'zbirenbaum/copilot-cmp',
            dependencies = { 'hrsh7th/nvim-cmp' },
            config = function()
                require('copilot_cmp').setup()

                -- prevent showing suggestions when cmp is open
                local cmp = require('cmp')
                local copilot = require('copilot.suggestion')
                cmp.event:on('menu_opened', function()
                    vim.b.copilot_suggestion_hidden = true
                    copilot.dismiss()
                end)

                cmp.event:on('menu_closed', function()
                    vim.b.copilot_suggestion_hidden = false

                end)
            end
        }
    },
    cmd = { 'Copilot', 'CopilotPanel' },
    event = 'InsertEnter',
    keys = {
        { '<leader>ccp', '<cmd>Copilot panel<CR>', desc = 'Open Copilot Panel' }
    },
    opts = {
        filetypes = {
            ['*'] = false,
            cpp = true,
            python = true,
            lua = true,
            sh = true,
            perl = true,
        },
        panel = {
            layout = {
                position = 'right',
            }
        },
        suggestion = {
            auto_trigger = true
        },
    },
}
