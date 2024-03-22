return {
    settings = {
        ["nil"] = {
            -- formatting = {
            --     command = { "alejandra", "-qq" },
            -- },
            -- testSetting = 42,
            autoArchive = true,
            flake = {
                autoArchive = true,
                autoEvalInputs = true,
            },
        },
    },
}
