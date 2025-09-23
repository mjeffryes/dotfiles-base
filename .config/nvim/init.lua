-- exec vim config
---[=[
vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/shared.vimrc
]])
--]=]

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Setup lazy.nvim --- TODO remove this in favor of checking it into dotfiles?
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup("plugins")

require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "vim", "vimdoc" },

  highlight = {
    enable = true,
  },
})

local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.lua_ls.setup({
  capabilities = lsp_capabilities,
})
lspconfig.gopls.setup({
  capabilities = lsp_capabilities,
})
lspconfig.bashls.setup({
  capabilities = lsp_capabilities,
})
lspconfig.ts_ls.setup({
  capabilities = lsp_capabilities,
})

lspconfig.ruff.setup({
  capabilities = lsp_capabilities,
})

lspconfig.pyright.setup({
  capabilities = (function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
    return capabilities
  end)(),
})

vim.g.diagnostics_active = true

vim.g.diagnostics_active = true
vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = true,
  virtual_text = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

    -- Jump to the definition
    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

    -- Jump to declaration
    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

    -- Lists all the implementations for the symbol under the cursor
    bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

    -- Jumps to the definition of the type symbol
    bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

    -- Lists all the references
    bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

    -- Displays a function's signature information
    bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

    -- Renames all references to the symbol under the cursor
    bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

    -- Selects a code action available at the current cursor position
    bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")

    -- Show diagnostics in a floating window
    bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")

    -- Move to the previous diagnostic
    bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

    -- Move to the next diagnostic
    bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
  end,
})
