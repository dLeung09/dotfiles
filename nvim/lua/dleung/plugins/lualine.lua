return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- local colors = {
    --   blue = "#65D1FF",
    --   green = "#3EFFDC",
    --   violet = "#FF61EF",
    --   yellow = "#FFDA7B",
    --   red = "#FF4A4A",
    --   fg = "#c3ccdc",
    --   bg = "#112638",
    --   inactive_bg = "#2c3043",
    -- }
    --
    -- local my_lualine_theme = {
    --   normal = {
    --     a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
    --     b = { bg = colors.bg, fg = colors.fg },
    --     c = { bg = colors.bg, fg = colors.fg },
    --   },
    --   insert = {
    --     a = { bg = colors.green, fg = colors.bg, gui = "bold" },
    --     b = { bg = colors.bg, fg = colors.fg },
    --     c = { bg = colors.bg, fg = colors.fg },
    --   },
    --   visual = {
    --     a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
    --     b = { bg = colors.bg, fg = colors.fg },
    --     c = { bg = colors.bg, fg = colors.fg },
    --   },
    --   command = {
    --     a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
    --     b = { bg = colors.bg, fg = colors.fg },
    --     c = { bg = colors.bg, fg = colors.fg },
    --   },
    --   replace = {
    --     a = { bg = colors.red, fg = colors.bg, gui = "bold" },
    --     b = { bg = colors.bg, fg = colors.fg },
    --     c = { bg = colors.bg, fg = colors.fg },
    --   },
    --   inactive = {
    --     a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
    --     b = { bg = colors.inactive_bg, fg = colors.semilightgray },
    --     c = { bg = colors.inactive_bg, fg = colors.semilightgray },
    --   },
    -- }

    local colors = {
      fg1    = '#282828',
      color2 = '#504945',
      fg2    = '#ddc7a1',
      color3 = '#32302f',
      color4 = '#a89984',
      color5 = '#7daea3',
      color6 = '#a9b665',
      color7 = '#d8a657',
      color8 = '#d3869b',
      color9 = '#ea6962',
    }

    local my_lualine_theme = {
      normal = {
        a = { fg = colors.fg1, bg = colors.color4, gui = 'bold' },
        b = { fg = colors.fg2, bg = colors.color2 },
        c = { fg = colors.fg2, bg = colors.color3 },
      },
      command = { a = { fg = colors.fg1, bg = colors.color5, gui = 'bold' } },
      inactive = { a = { fg = colors.fg2, bg = colors.color2 } },
      insert = { a = { fg = colors.fg1, bg = colors.color6, gui = 'bold' } },
      replace = { a = { fg = colors.fg1, bg = colors.color7, gui = 'bold' } },
      terminal = { a = { fg = colors.fg1, bg = colors.color8, gui = 'bold' } },
      visual = { a = { fg = colors.fg1, bg = colors.color9, gui = 'bold' } },
    }

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
