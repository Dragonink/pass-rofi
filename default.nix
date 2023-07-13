{ lib, stdenv, pass, rofi, xdotool, xorg, busybox, makeWrapper }: stdenv.mkDerivation rec {
	pname = "pass-rofi";
	version = "1.0";

	src = ./.;

	buildInputs = [ pass rofi xdotool xorg.setxkbmap busybox ];
	nativeBuildInputs = [ makeWrapper ];
	
	installPhase = ''
		mkdir --parents $out/bin
		cp ${src}/pass-rofi $out/bin/
		wrapProgram $out/bin/pass-rofi \
			--prefix PATH : "${lib.makeBinPath buildInputs}"
		
		PASS_EXTENSIONS='lib/password-store/extensions'
		mkdir --parents $out/$PASS_EXTENSIONS
		ln -s $out/bin/pass-rofi $out/$PASS_EXTENSIONS/rofi.bash
	'';
}
