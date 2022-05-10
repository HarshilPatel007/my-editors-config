local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- local formatting = null_ls.builtins.formatting

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
    debug = false,
    update_in_insert = true,
    sources = {
        -- formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
        -- formatting.black.with { extra_args = { "--fast" } },
        diagnostics.pylint.with {
            extra_args = {
                "--disable=C0111",
                "--load-plugins=pylint_django"
            } -- need to install pylint and pylint-django in system. ex.: pip install pylint pylint-django
        },
        diagnostics.flake8,
    },
}
