return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          go = { "gofmt", "goimports" },
          -- Use a sub-list to run only the first available formatter
          javascript = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          vue = { { "prettierd", "prettier" } },
          bash = { "shfmt", "shellcheck" },
          sh = { "shfmt", "shellcheck" },
          zsh = { "shfmt", "shellcheck" },
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}
