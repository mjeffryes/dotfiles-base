return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "cssls",
          "dockerls",
          "gopls",
          "html",
          "jsonls",
          "lua_ls",
          "pyright",
          "ruff",
          "tailwindcss",
          "ts_ls",
          "yamlls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
  },
}
