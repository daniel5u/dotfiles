vim.lsp.enable({
    "bashls",
    "lua_ls",
    "texlab",
    "ts_ls",
    "rust-analyzer",
    "ty",
    "emmet_language_server",
    "astro",
})
vim.diagnostic.config({ virtual_text = true })

vim.lsp.config('ty', {
    settings = {
        ty = {
            diagnosticMode = "openFilesOnly",
            showSyntaxErrors = true,
            inlayHints = {
                variableTypes = true,
                callArgumentNames = true,
            }
        }
    }
})
