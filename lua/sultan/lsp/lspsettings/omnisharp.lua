-- local omnipath = os.getenv("OMNISHARP_ROSLYN_PATH") .. "/lib/omnisharp-roslyn/OmniSharp.dll"
local omnipath = os.getenv("LSP_OMNISHARP") .. "/lib/omnisharp-roslyn/OmniSharp.dll"
return {
    cmd = { "dotnet", omnipath },
    enable_roslyn_analyzers = true,
    -- enable_import_completion = true,   -- Can have negative impact on completion responsiveness
    organize_imports_on_format = false,
}
