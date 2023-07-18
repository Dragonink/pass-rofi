{ pkgs ? import <nixpkgs> {} }:
  let
    lib = pkgs.lib;
    stdenv = pkgs.stdenv;
  in stdenv.mkDerivation rec {
    pname = "pass-rofi";
    version = "1.0";

    src = ./.;

    buildInputs = with pkgs; [ pass rofi xdotool xorg.setxkbmap busybox ];
    nativeBuildInputs = with pkgs; [ makeWrapper ];

    installPhase = ''
      runHook preInstall

      mkdir --parents $out/bin
      cp pass-rofi $out/bin/
      wrapProgram $out/bin/pass-rofi \
        --prefix PATH : "${lib.makeBinPath buildInputs}"

      PASS_EXTENSIONS='lib/password-store/extensions'
      mkdir --parents $out/$PASS_EXTENSIONS
      ln --symbolic $out/bin/pass-rofi $out/$PASS_EXTENSIONS/rofi.bash

      runHook postInstall
    '';
  }
