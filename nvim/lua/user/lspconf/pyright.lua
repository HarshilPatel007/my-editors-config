local util = require('lspconfig/util')

return {
    root_dir = function(fname)
        return util.root_pattern(".git", "requirements.txt")(fname) or util.path.dirname(fname)
    end;

    settings = {
        pyright = {
            disableOrganizeImports = false,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'basic',  --  ["off", "basic", "strict"]:
                diagnosticMode = 'workspace', -- ["openFilesOnly", "workspace"]
                diagnosticSeverityOverrides = {  -- "error," "warning," "information," "true," "false," or "none"
                    reportDuplicateImport = 'warning',
                    reportImportCycles = 'warning',
                    reportMissingImports = 'error',
                    reportMissingModuleSource = 'error',
                }
            },
            formatting = {
                blackPath = "~/.local/bin/black",
                provider = "black"
            }
        } -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md, https://github.com/microsoft/pyright/blob/main/docs/settings.md
    }
}
