return {
    {
        "JavaHello/spring-boot.nvim",
        ft = { "java", "jproperties" },
        -- ft = { "java", "yaml", "jproperties" },
        dependencies = {
            "mfussenegger/nvim-jdtls",
        },
        opts = {},
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java", "jproperties" },
    },
}
