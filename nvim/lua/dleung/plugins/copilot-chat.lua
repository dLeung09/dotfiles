return {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
        { 'zbirenbaum/copilot.lua' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope.nvim' },
        { 'folke/which-key.nvim' },
    },
    config = function()
        require('CopilotChat').setup({})

        require('which-key').register({
            c = {
                c = {
                    name = 'Copilot Chat',
                }
            }
        }, {
            mode = { 'n', 'x' },
            prefix = '<leader>',
            silent = true,
            noremap = true,
            nowait = false,
        })
    end,
    cmd = {
        'CopilotChat',
        'CopilotChatOpen',
        'CopilotChatClose',
        'CopilotChatToggle',
        'CopilotChatReset',
        'CopilotChatDebugInfo',
        'CopilotChatExplain',
        'CopilotChatTests',
        'CopilotChatFixDiagnostic',
        'CopilotChatCommit',
        'CopilotChatCommitStaged'
    },
    keys = {
        { '<leader>ccr', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Reset prompt', mode = { 'n', 'x' } },
        { '<leader>ccc', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle panel', mode = { 'n', 'x' } },
        { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code', mode = { 'n', 'x' } },
        {
            '<leader>cci',
            function()
                local input = vim.fn.input('Ask Copilot: ')
                if input ~= '' then
                    require('CopilotChat').ask(input)
                end
            end,
            desc = 'CopilotChat - Ask input',
            mode = { 'n', 'x' }
        },
        {
            '<leader>ccq',
            function()
                local input = vim.fn.input('Quick Chat (buffer): ')
                if input ~= '' then
                    require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
                end
            end,
            desc = 'CopilotChat - Quick chat with buffer',
            mode = { 'n', 'x' }
        },
        {
            '<leader>cch',
            function()
                local actions = require('CopilotChat.actions')
                require('CopilotChat.integrations.telescope').pick(actions.help_actions())
            end,
            desc = 'CopilotChat - Help actions',
        },
        {
            '<leader>ccp',
            function()
                local actions = require('CopilotChat.actions')
                require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
            end,
            desc = 'CopilotChat - Prompt actions',
        },
    },
}
