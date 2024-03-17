{ sources ? import ./nix/sources.nix, pkgs ? import sources.nixpkgs {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.which
    pkgs.htop
    pkgs.zlib
    pkgs.fish
  ];

  shellHook = ''
    echo hello
  '';

  MY_ENVIRONMENT_VARIABLE="world";
}
