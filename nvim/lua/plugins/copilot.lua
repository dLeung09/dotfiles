return {
  "zbirenbaum/copilot.lua",
  opts = function(_, opts)
    opts.filetypes = {
      ["*"] = false,
      cpp = true,
      python = true,
      lua = true,
      go = true,
      sh = true,
      perl = true,
    }
  end,
}
