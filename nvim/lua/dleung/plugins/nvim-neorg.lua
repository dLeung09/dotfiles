return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {}, -- Loads default behavior
        ["core.concealer"] = {}, -- Adds pretty icons to your document
        ["core.dirman"] = {
          config = {
            workspaces = {
              journal = "~/journal",
              reference = "~/reference_material",
            },
          },
        },
      },
    }
  end,
}
