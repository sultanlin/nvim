local features = {
    codelens = true,
    debugger = true,
}

local LSP_JAVA_PATH = assert(os.getenv("LSP_JAVA"))

local function get_jdtls_paths()
    local path = {}

    path.data_dir = os.getenv("HOME") .. "/.cache/jdtls/workspace"

    local jdtls_install = LSP_JAVA_PATH .. "/share/java/jdtls"

    local lombok_path = assert(os.getenv("LSP_LOMBOK"))

    path.java_agent = lombok_path .. "/share/java/lombok.jar"
    path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

    path.bundles = {}

    ---
    -- Include java-test bundle if present
    ---
    local java_test_path = assert(os.getenv("LSP_JAVA_TEST"))
    java_test_path = java_test_path .. "/share/vscode/extensions/vscjava.vscode-java-test/server"

    local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/*.jar"), "\n")

    if java_test_bundle[1] ~= "" then
        vim.list_extend(path.bundles, java_test_bundle)
    elseif java_test_bundle[1] == "" then
        print("test missing")
    end

    ---
    -- Include java-debug-adapter bundle if present
    ---
    local java_debug_path = assert(os.getenv("LSP_JAVA_DEBUG"))
    java_debug_path = java_debug_path .. "/share/vscode/extensions/vscjava.vscode-java-debug/server"

    local java_debug_bundle = vim.split(vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin-*.jar"), "\n")

    if java_debug_bundle[1] ~= "" then
        vim.list_extend(path.bundles, java_debug_bundle)
    elseif java_debug_bundle[1] == "" then
        print("debug missing")
    end

    ---
    -- Include spring-boot-tools bundle if present
    ---
    local springboot = package.loaded["spring_boot"]
    if springboot then
        springboot.init_lsp_commands()
        vim.list_extend(path.bundles, springboot.java_extensions())
    end

    path.runtimes = {}

    return path
end

local function enable_codelens(bufnr)
    pcall(vim.lsp.codelens.refresh)

    vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = bufnr,
        -- group = java_cmds,
        desc = "refresh codelens",
        callback = function()
            pcall(vim.lsp.codelens.refresh)
        end,
    })
end

local function enable_debugger(bufnr)
    require("jdtls").setup_dap({ hotcodereplace = "auto", config_overrides = {} })
    require("jdtls.dap").setup_dap_main_class_configs()

    local opts = { buffer = bufnr, silent = true }
    opts.desc = "Test class"
    vim.keymap.set("n", "<leader>jT", "<cmd>lua require('jdtls').test_class()<cr>", opts)
    opts.desc = "Test nearest method"
    vim.keymap.set("n", "<leader>jt", "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)
end

local function jdtls_on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = args.buf, silent = true }

            -- set keybinds
            -- The following mappings are based on the suggested usage of nvim-jdtls
            -- https://github.com/mfussenegger/nvim-jdtls#usage
            local keymap = vim.keymap
            opts.desc = "Organize imports"
            keymap.set("n", "<leader>jo", "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
            opts.desc = "Extract variable"
            keymap.set({ "n", "v", "x" }, "<leader>jv", "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
            opts.desc = "Extract constant"
            keymap.set({ "n", "v", "x" }, "<leader>jc", "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
            opts.desc = "Extract method"
            keymap.set({ "v", "x" }, "<leader>jm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)
            opts.desc = "Update config"
            keymap.set("n", "<leader>ju", "<Cmd>JdtUpdateConfig<CR>", opts)
            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>jr", "<Cmd>JdtRestart<CR>", opts)

            if features.debugger then
                enable_debugger(bufnr)
            end

            if features.codelens then
                enable_codelens(bufnr)
            end
        end,
    })

    -- -- Cool feature, maybe later
    -- vim.api.nvim_buf_create_user_command(bufnr, "SpringBoot", function(opt)
    --     local on_choice = function(choice)
    --         if choice == "Annotations" then
    --             vim.lsp.buf.workspace_symbol("@")
    --         elseif choice == "Beans" then
    --             vim.lsp.buf.workspace_symbol("@+")
    --         elseif choice == "RequestMappings" then
    --             vim.lsp.buf.workspace_symbol("@/")
    --         elseif choice == "Prototype" then
    --             vim.lsp.buf.workspace_symbol("@>")
    --         end
    --     end
    --     if opt.args and opt.args ~= "" then
    --         on_choice(opt.args)
    --     else
    --         vim.ui.select({ "Annotations", "Beans", "RequestMappings", "Prototype" }, {
    --             prompt = "Spring Symbol:",
    --             format_item = function(item)
    --                 if item == "Annotations" then
    --                     return "shows all Spring annotations in the code"
    --                 elseif item == "Beans" then
    --                     return "shows all defined beans"
    --                 elseif item == "RequestMappings" then
    --                     return "shows all defined request mappings"
    --                 elseif item == "Prototype" then
    --                     return "shows all functions (prototype implementation)"
    --                 end
    --             end,
    --         }, on_choice)
    --     end
    -- end, {
    --     desc = "Spring Boot",
    --     nargs = "?",
    --     range = false,
    --     complete = function()
    --         return { "Annotations", "Beans", "RequestMappings", "Prototype" }
    --     end,
    -- })
end

-- local function jdtls_setup(event)
local path = get_jdtls_paths()
local data_dir = path.data_dir .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- The command that starts the language server
-- vim.opt_local.cmdheight = 5
-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
-- NOTE: NixOS Fix
-- https://pastes.io/gqpzsaseyg
local cmd = {
    -- 💀
    "java", -- LSP_JAVA_PATH .. "/bin/jdtls",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",

    "-Dosgi.sharedConfiguration.area.readOnly=true",
    "-Dosgi.checkConfiguration=true",
    "-Dosgi.configuration.cascaded=true",
    -- "-Dosgi.sharedConfiguration.area=/home/sultan/.config/nvim/java/config_linux",
    "-Dosgi.sharedConfiguration.area="
        .. LSP_JAVA_PATH
        .. "/share/java/jdtls/config_linux/",

    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. path.java_agent,
    -- "-Xmx1g",
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
        inlayHints = { parameterNames = { enabled = "all" } }, -- literals, all, none
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
        -- extendedClientCapabilities = require("jdtls.capabilities"),
        contentProvider = { preferred = "fernflower" },
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
        -- java = {
        --     -- jdt = {
        --     --   ls = {
        --     --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
        --     --   }
        --     -- },
        --     format = {
        --         enabled = true,
        --         -- settings = {
        --         --   profile = 'asdf'
        --         -- },
        --     },
        -- },
    },
}

vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
)
vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
)
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")

return {
    cmd = cmd,
    settings = lsp_settings,
    on_attach = jdtls_on_attach,
    root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),
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
        ["language/status"] = function(_, result) end, -- Stops loading/loaded message when opening java files
        ["$/progress"] = function(_, result, ctx) end, -- disable progress updates.
    },
    filetypes = { "java", "jproperties", "typescript" },
}
-- setup = {
--     commands = {
--         Format = {
--             function()
--                 vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
--             end,
--         },
--     },
-- },
