local M = {
    "mfussenegger/nvim-jdtls",
    dependencies = {
        "JavaHello/spring-boot.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
}

function M.config()
    local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })
    local cache_vars = {}

    local root_files = {
        ".git",
        "mvnw",
        "gradlew",
        "pom.xml",
        "build.gradle",
    }

    local features = {
        -- change this to `true` to enable codelens
        codelens = true,

        -- change this to `true` if you have `nvim-dap`,
        -- `java-test` and `java-debug-adapter` installed
        -- debugger = debug,
        debugger = true,
    }

    local LSP_JAVA_PATH = ""
    if os.getenv("LSP_JAVA_MINE") ~= nil then
        LSP_JAVA_PATH = "LSP_JAVA_MINE"
    elseif os.getenv("LSP_JAVA") then
        LSP_JAVA_PATH = "LSP_JAVA"
    end
    -- local LSP_JAVA_PATH = "LSP_JAVA"

    -- FIX: Combine nvim-jdtls and spring-boot somehow
    require("spring_boot").setup({})
    -- require("spring_boot").setup({
    --     -- ls_path = "~/.vscode/extensions/vmware.vscode-spring-boot-1.55.1",
    --     jdtls_name = "jdtls",
    --     -- log_file = nil,
    --     java_cmd = "java",
    -- })

    -- require("spring_boot").init_lsp_commands()

    local function get_jdtls_paths()
        if cache_vars.paths then
            return cache_vars.paths
        end

        local path = {}

        -- path.data_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace"
        path.data_dir = os.getenv("HOME") .. "/.cache/jdtls/workspace"

        local jdtls_install

        if os.getenv(LSP_JAVA_PATH) ~= nil then
            jdtls_install = os.getenv(LSP_JAVA_PATH) .. "/share/java/jdtls"
            -- jdtls_install = os.getenv(LSP_JAVA_PATH) -- .. "/share/java/jdtls"
        elseif not os.getenv(LSP_JAVA_PATH) then
            jdtls_install = require("mason-registry").get_package("jdtls"):get_install_path()
        end

        local lombok_install
        if os.getenv(LSP_JAVA_PATH) ~= nil then
            lombok_install = os.getenv("LSP_LOMBOK") .. "/share/java"
        elseif not os.getenv(LSP_JAVA_PATH) then
            lombok_install = require("mason-registry").get_package("jdtls"):get_install_path()
        end

        path.java_agent = lombok_install .. "/lombok.jar"
        path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

        if vim.fn.has("mac") == 1 then
            path.platform_config = jdtls_install .. "/config_mac"
        elseif vim.fn.has("unix") == 1 then
            path.platform_config = jdtls_install .. "/config_linux"
        elseif vim.fn.has("win32") == 1 then
            path.platform_config = jdtls_install .. "/config_win"
        end

        path.bundles = {}

        ---
        -- Include java-test bundle if present
        ---
        local java_test_path
        if os.getenv("LSP_JAVA_TEST") ~= nil then
            java_test_path = os.getenv("LSP_JAVA_TEST") .. "/share/vscode/extensions/vscjava.vscode-java-test/server"
        elseif not os.getenv(LSP_JAVA_PATH) then
            java_test_path = require("mason-registry").get_package("jdtls"):get_install_path() .. "/extension/server"
        end
        -- local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()

        local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/*.jar"), "\n")

        if java_test_bundle[1] ~= "" then
            vim.list_extend(path.bundles, java_test_bundle)
        elseif java_test_bundle[1] == "" then
            print("test missing")
        end

        ---
        -- Include java-debug-adapter bundle if present
        ---
        local java_debug_path
        if os.getenv("LSP_JAVA_DEBUG") ~= nil then
            java_debug_path = os.getenv("LSP_JAVA_DEBUG") .. "/share/vscode/extensions/vscjava.vscode-java-debug/server"
        elseif not os.getenv("LSP_JAVA_DEBUG") then
            java_debug_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()
        end

        local java_debug_bundle =
            vim.split(vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin-*.jar"), "\n")

        if java_debug_bundle[1] ~= "" then
            vim.list_extend(path.bundles, java_debug_bundle)
        elseif java_debug_bundle[1] == "" then
            print("debug missing")
        end

        -- Spring boot plugin
        vim.list_extend(path.bundles, require("spring_boot").java_extensions())
        -- require("pl.pretty").dump(path.bundles)

        -- print(vim.inspect(path.bundles))

        ---
        -- Useful if you're starting jdtls with a Java version that's
        -- different from the one the project uses.
        ---
        path.runtimes = {
            -- Note: the field `name` must be a valid `ExecutionEnvironment`,
            -- you can find the list here:
            -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            --
            -- This example assume you are using sdkman: https://sdkman.io
            -- {
            --   name = 'JavaSE-17',
            --   path = vim.fn.expand('~/.sdkman/candidates/java/17.0.6-tem'),
            -- },
            -- {
            --   name = 'JavaSE-18',
            --   path = vim.fn.expand('~/.sdkman/candidates/java/18.0.2-amzn'),
            -- },
        }

        cache_vars.paths = path

        return path
    end

    local function enable_codelens(bufnr)
        pcall(vim.lsp.codelens.refresh)

        vim.api.nvim_create_autocmd("BufWritePost", {
            buffer = bufnr,
            group = java_cmds,
            desc = "refresh codelens",
            callback = function()
                pcall(vim.lsp.codelens.refresh)
            end,
        })
    end

    local function enable_debugger(bufnr)
        require("jdtls").setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()

        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "<leader>jT", "<cmd>lua require('jdtls').test_class()<cr>", opts, { desc = "Test class" })
        vim.keymap.set(
            "n",
            "<leader>jt",
            "<cmd>lua require('jdtls').test_nearest_method()<cr>",
            opts,
            { desc = "Test nearest method" }
        )
    end

    local function jdtls_on_attach(client, bufnr)
        -- Load my lsp settings
        local my_lsp = require("sultan.lsp.lspconfig")
        my_lsp.on_attach(client, bufnr)

        if features.debugger then
            enable_debugger(bufnr)
        end

        if features.codelens then
            enable_codelens(bufnr)
        end

        -- The following mappings are based on the suggested usage of nvim-jdtls
        -- https://github.com/mfussenegger/nvim-jdtls#usage

        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set(
            "n",
            "<leader>jo",
            "<cmd>lua require('jdtls').organize_imports()<cr>",
            opts,
            { desc = "Organize imports" }
        )
        vim.keymap.set(
            { "n", "v", "x" },
            "<leader>jv",
            "<cmd>lua require('jdtls').extract_variable()<cr>",
            opts,
            { desc = "Extract variable" }
        )
        vim.keymap.set(
            { "n", "v", "x" },
            "<leader>jc",
            "<cmd>lua require('jdtls').extract_constant()<cr>",
            opts,
            { desc = "Extract constant" }
        )
        vim.keymap.set(
            { "v", "x" },
            "<leader>jm",
            "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>",
            opts,
            { desc = "Extract method" }
        )
        vim.keymap.set("n", "<leader>ju", "<Cmd>JdtUpdateConfig<CR>", opts, { desc = "Update config" })
        vim.keymap.set("n", "<leader>jr", "<Cmd>JdtRestart<CR>", opts, { desc = "Restart LSP" })
    end

    local function jdtls_setup(event)
        local jdtls = require("jdtls")

        local path = get_jdtls_paths()
        local data_dir = path.data_dir .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

        local extendedClientCapabilities = jdtls.extendedClientCapabilities
        extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

        if cache_vars.capabilities == nil then
            jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

            local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
            cache_vars.capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                ok_cmp and cmp_lsp.default_capabilities() or {}
            )
        end

        -- The command that starts the language server
        -- vim.opt_local.cmdheight = 5
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        -- NOTE: NixOS Fix
        -- https://pastes.io/gqpzsaseyg
        local home = os.getenv("HOME")
        local cmd = {
            -- 💀
            "java",
            -- os.getenv(LSP_JAVA_PATH) .. "/bin/jdtls",

            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",

            "-Dosgi.sharedConfiguration.area.readOnly=true",
            "-Dosgi.checkConfiguration=true",
            "-Dosgi.configuration.cascaded=true",
            -- "-Dosgi.sharedConfiguration.area=/home/sultan/.config/nvim/java/config_linux",
            "-Dosgi.sharedConfiguration.area="
                .. os.getenv(LSP_JAVA_PATH)
                .. "/share/java/jdtls/config_linux/",
            -- os.getenv(LSP_JAVA_PATH) .. "/share/java/jdtls/config_linux/",

            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-javaagent:" .. path.java_agent,
            "-Xms1g",
            -- "-Xms512m",
            -- "-Xmx2048m",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",

            -- 💀
            "-jar",
            path.launcher_jar,

            -- 💀
            "-configuration",
            os.getenv("HOME") .. "/.cache/jdtls/config",

            -- 💀
            "-data",
            data_dir,
        }

        local lsp_settings = {
            java = {
                eclipse = { downloadSources = true },
                configuration = {
                    updateBuildConfiguration = "interactive",
                    runtimes = path.runtimes,
                },
                maven = { downloadSources = true },
                implementationsCodeLens = { enabled = true },
                referencesCodeLens = { enabled = true },
                references = {
                    includeDecompiledSources = true,
                },
                -- inlayHints = {
                --   parameterNames = {
                --     enabled = 'all' -- literals, all, none
                --   }
                -- },
                format = { enabled = true },
                signatureHelp = { enabled = true },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                        -- NOTE: From https://github.com/mrcjkb/nvim/blob/master/nvim/after/ftplugin/java.lua
                        "io.vavr.API.$",
                        "io.vavr.API.Case",
                        "io.vavr.API.Match",
                        "io.vavr.API.For",
                        "io.vavr.Predicates.not",
                    },
                },
                contentProvider = { preferred = "fernflower" },
                extendedClientCapabilities = extendedClientCapabilities,
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                },
            },
        }

        -- This starts a new require("spring_boot").java_extensions(),client & server,
        -- or attaches to an existing client & server depending on the `root_dir`.
        jdtls.start_or_attach({
            cmd = cmd,
            settings = lsp_settings,
            on_attach = jdtls_on_attach,
            capabilities = require("sultan.lsp.lspconfig").capabilities,
            -- capabilities = cache_vars.capabilities,
            root_dir = jdtls.setup.find_root(root_files),
            flags = { allow_incremental_sync = true },
            on_init = function(client, _)
                if client.config.settings then
                    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                end
            end,
            init_options = {
                bundles = path.bundles,
            },
            handlers = {
                ["language/status"] = function(_, result)
                    -- Print or whatever.
                end,
                ["$/progress"] = function(_, result, ctx)
                    -- disable progress updates.
                end,
                -- Stops loading/loaded message when opening java files
                -- ["language/status"] = function() end,
                -- FIXME: Maybe check this again? https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/jdtls.lua#L117
            },
        })

        -- require("spring_boot").setup({})
        -- require("spring_boot").setup({
        --     -- ls_path = "~/.vscode/extensions/vmware.vscode-spring-boot-1.55.1",
        --     jdtls_name = "jdtls",
        --     -- log_file = nil,
        --     java_cmd = "java",
        -- })

        -- require("spring_boot").init_lsp_commands()
    end

    vim.cmd(
        "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
    )
    vim.cmd(
        "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
    )
    vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
    vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")

    vim.api.nvim_create_autocmd("FileType", {
        group = java_cmds,
        pattern = { "java", "jproperties" },
        desc = "Setup jdtls",
        callback = jdtls_setup,
    })
end

return M
