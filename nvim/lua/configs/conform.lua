local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    go = { "goimports", "golines" },
    rust = { "rustfmt" },
    yaml = { "yamlfmt" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    less = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    markdown = { "prettier" },
    graphql = { "prettier" },
    vue = { "prettier" },
    svelte = { "prettier" },
    astro = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
}

return options
