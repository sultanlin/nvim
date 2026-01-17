local NIX_CONFIG_PATH = '"/home/sultan/nix-config"'
return {
    settings = {
        nixd = {
            nixpkgs = {
                -- expr = "import <nixpkgs> { }",
                expr = "import (builtins.getFlake " .. NIX_CONFIG_PATH .. ").inputs.nixpkgs-unstable {}",
                -- expr = 'import (builtins.getFlake("git+file://" + toString ./.)).inputs.nixpkgs { }',
                -- expr = 'import (builtins.getFlake(toString ./.)).inputs.nixpkgs { }',
            },
            formatting = {
                command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
            },
            options = {
                nixos = {
                    expr = "(builtins.getFlake " .. NIX_CONFIG_PATH .. ").nixosConfigurations.beast.options",
                },
                home_manager = {
                    expr = "(builtins.getFlake "
                        .. NIX_CONFIG_PATH
                        .. ").nixosConfigurations.beast.options.home-manager.users.type.getSubOptions []",
                },
            },
        },
    },
}
