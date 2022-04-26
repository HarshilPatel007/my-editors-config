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
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "lunarvim/darkplus.nvim" -- color theme
    -- use "neovim/nvim-lspconfig" -- enable LSP
    -- use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    } -- treesitter syntax highliter

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
