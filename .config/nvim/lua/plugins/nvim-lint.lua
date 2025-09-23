return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        -- markdown = { "vale" },
        -- bash = { "shellcheck" },
        ---- sh = { "shellcheck" },
        -- zsh = { "shellcheck" },
      }
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged", "TextChangedI" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
