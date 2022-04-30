local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    print("[!] indent_blankline not found!")
    return
end

vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD]]


indent_blankline.setup {
    char = "┃",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
