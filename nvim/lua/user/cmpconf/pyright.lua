local util = require("lspconfig/util")

require'lspconfig'.pyright.setup({
    root_dir = function(fname)
        return util.root_pattern(".git", "requirements.txt")(fname) or util.path.dirname(fname)
    end;
})
