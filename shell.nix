let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) {config.allowUnfree = true;};
in
{ pkgs ? import <nixpkgs> {
  config.allowUnfree = true;
} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [
    jdk
    unstable.flutter
    android-studio
    unstable.steam-run
    ];
}

