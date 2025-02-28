return {
    settings = {
        nixd = {
            nixpkgs = {
                -- expr = "import <nixpkgs> { }",
                expr = 'import (builtins.getFlake "/home/sultan/nix-config").inputs.nixpkgs-unstable {}',
                -- expr = 'import (builtins.getFlake "github:vimjoyer/nixconf").inputs.nixpkgs {}',
                -- expr = 'import (builtins.getFlake "git+file://" + toString ./.).inputs.nixpkgs {}',
            },
            formatting = {
                command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
            },
            options = {
                -- nixos = {
                --     expr = 'import (builtins.getFlake "/home/sultan/nix-config").nixosConfigurations.laptop.options',
                --     -- expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.laptop.options',
                -- },
                -- home_manager = {
                --     expr = 'import (builtins.getFlake "/home/sultan/nix-config").homeConfigurations."sultan@laptop".options',
                --
                --     -- expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."sultan@laptop".options',
                --     -- expr = 'import (builtins.getFlake "/home/sultan/nix-config").inputs.nixpkgs {}',
                -- },
            },
        },
    },
}
