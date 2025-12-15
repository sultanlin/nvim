return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl", "tmpl", "templ" },
    settings = {
        gopls = {
            usePlaceholders = true,
            gofumpt = true,
            codelenses = {
                generate = false,
                gc_details = true,
                test = true,
                tidy = true,
            },
        },
    },
}
