local ts_config = require("nvim-treesitter.configs")

ts_config.setup {
    ensure_installed = {
        "python", "bash", "css", "scss", "dot", "html", "http", "javascript", "json", "jsdoc", "typescript", "lua", "regex"
    }, -- type 'all' to install all languages support
    sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
 
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        disable = {
            "yaml"
        }
    },
    incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = ",m",
          node_incremental = ",tt",
          scope_incremental = ",t",
          node_decremental = ",tdg",
        },
    },
}

