local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "[*] Installing packer close and reopen Neovim..."
    require("packer").packadd = "packer.nvim"
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerSync",
  pattern = "plugins.lua",
  group = group,
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print "[!] Something happened to packer!"
    return
end

-- Install your plugins here
return packer.startup(function(use)

    -- My plugins here
    use "wbthomason/packer.nvim" -- have packer manage itself
    use "lunarvim/onedarker.nvim" -- color theme

    -- start of LSP related plugins
    use "neovim/nvim-lspconfig" -- enable LSP
    use {
        "williamboman/nvim-lsp-installer",
    } -- simple to use language server installer
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    } -- treesitter syntax highliter
    use "nvim-treesitter/playground" -- for creating treesitter based plugins
    use {
        "jose-elias-alvarez/null-ls.nvim",
    } -- for linting
    -- end of LSP related plugins

    use {
        "nvim-telescope/telescope.nvim",
        requires = { {"nvim-lua/plenary.nvim"} }
    } -- telescope

    -- start of auto complete related plugins
    use {
        "hrsh7th/nvim-cmp"
    }
    use {
        "hrsh7th/cmp-path",
        after = "nvim-cmp",
        event = "InsertEnter",
    }
    use {
        "hrsh7th/cmp-buffer",
        after = "nvim-cmp",
        event = "InsertEnter",
    }
    use {
        "hrsh7th/cmp-cmdline",
        after = "nvim-cmp",
    }
    use {
        "hrsh7th/cmp-nvim-lua",
        after = "nvim-cmp",
    }
    use {
        "hrsh7th/cmp-nvim-lsp"
    }
    use {
        "L3MON4D3/LuaSnip",
        after = "nvim-cmp",
        event = "InsertEnter",
    } -- for snipet support
   -- end of auto complete related plugins

    use {
        "numToStr/Comment.nvim",
        event = "InsertEnter",
        config = function()
            require('Comment').setup()
        end
    } -- for commenting support

    use {
        "max-0406/autoclose.nvim",
        event = "InsertEnter",
    } -- for auto close brackets

    use {
        "kyazdani42/nvim-tree.lua",
        cmd = {
            "NvimTreeOpen",
            "NvimTreeFocus",
            "NvimTreeToggle",
        },
        config = function()
            require("nvim-tree").setup()
        end,
    }
    use {
        "kyazdani42/nvim-web-devicons",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("nvim-web-devicons").setup()
      end,
    }

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
