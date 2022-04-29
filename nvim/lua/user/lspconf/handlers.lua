-- UI config for lsp and cmp

local M = {}

M.setup = function()
    local signs = { Error  = " ", Warn = " ", Hint = " ", Info = " " }

    for type, icon in pairs(signs) do
        local highlight = "DiagnosticSign" .. type
        vim.fn.sign_define(highlight, { text = icon, texthl = highlight, numhl = highlight })
    end

    local config = {
        virtual_text = false, -- virtual diagnostics text
        virtual_lines = {
            prefix = '▎'
        }, -- virtual_lines plugin (virtual diagnostics text on code line)
        signs = {
          active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                hi! DiagnosticVirtualTextError guifg=#db4b4b guibg=#2D202A gui=bold 
                hi! DiagnosticVirtualTextWarn guifg=#e0af68 guibg=#2E2A2D gui=bold
                hi! DiagnosticVirtualTextInfo guifg=#0db9d7 guibg=#192B38 gui=bold
                hi! DiagnosticVirtualTextHint guifg=#1abc9c guibg=#1A2B32 gui=bold
            ]],
            false
        )
        local lsp_doc_hi = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = lsp_doc_hi,
            buffer = 0,
            callback = function() vim.lsp.buf.document_highlight() end,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = lsp_doc_hi,
            buffer = 0,
            callback = function() vim.lsp.buf.clear_references() end,
        })
    end
end

--TODO: add keymaps to keymaps file

M.on_attach = function(client)
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = capabilities

return M
