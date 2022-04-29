local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    print("[!] something happened to lsp-installer!")
	return
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("user.lspconf.handlers").on_attach,
        capabilities = require("user.lspconf.handlers").capabilities,
    }

    if server.name == "pyright" then
        local pyright_opts = require("user.lspconf.pyright")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    server:setup(opts)
end)
