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
                hi! DiagnosticError guifg=#db4b4b guibg=#2D202A gui=bold 
                hi! DiagnosticWarn guifg=#e0af68 guibg=#2E2A2D gui=bold
                hi! DiagnosticInfo guifg=#0db9d7 guibg=#192B38 gui=bold
                hi! DiagnosticHint guifg=#1abc9c guibg=#1A2B32 gui=bold
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
        vim.api.nvim_create_autocmd({ "CursorHold","CursorHoldI" }, {
            buffer = bufnr,
            callback = function()
            local opts = {
                    focusable = false,
                    border = "rounded",
                    source = "always",
                    prefix = "",
                    scope = "cursor",
                    style = "minimal"
                }
            vim.diagnostic.open_float(nil, opts)
  end
})
    end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap=true, silent=true }
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    buf_set_keymap('n', '<C-d>', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    buf_set_keymap('n', '<C-r>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    buf_set_keymap('n', 'gf', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
end

M.on_attach = function(client, buf)
    lsp_keymaps(buf)
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
M.capabilities = capabilities

return M
