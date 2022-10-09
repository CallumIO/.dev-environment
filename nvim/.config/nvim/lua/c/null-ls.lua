local null_ls_status_ok, null_ls = pcall(require, "null_ls")
if not null_ls_status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.astyle,
        formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
        formatting.stylua,
        formatting.black
    }
})
