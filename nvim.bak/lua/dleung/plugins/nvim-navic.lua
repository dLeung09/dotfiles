return {
    "SmiteshP/nvim-navic",
    event = "BufReadPre",
    dependencies = {
        -- "neovim/nvim-lspconfig"
    },
    config = function ()
        local navic = require('nvim-navic')
        navic.setup(
            {
                -- lsp = {
                --     auto_attach = true,
                -- },
                separator = '  ',
            }
        )
    end
}
