return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff" },
      c = { "clang-format" },
      cpp = { "clang-format" },
    }
  end,
}
