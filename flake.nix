{
    description = "Macros for the bakery!";
    inputs = rec {
        settings.url = github:sylvorg/settings;
        flake-utils.url = github:numtide/flake-utils;
        flake-compat = {
            url = "github:edolstra/flake-compat";
            flake = false;
        };
        py3pkg-bakery.url = github:syvlorg/bakery;
        py3pkg-pytest-hy.url = github:syvlorg/pytest-hy;
    };
    outputs = inputs@{ self, flake-utils, settings, ... }: with builtins; with settings.lib; with flake-utils.lib; settings.mkOutputs {
        inherit inputs;
        pname = "alcremie";
        callPackage = { stdenv, bakery, pname }: j.mkPythonPackage self.pkgs.${stdenv.targetPlatform.system}.Pythons.${self.type}.pkgs (rec {
            owner = "syvlorg";
            inherit pname;
            src = ./.;
            propagatedBuildInputs = [ bakery ];
            postPatch = ''
                substituteInPlace pyproject.toml --replace "bakery = { git = \"https://github.com/${owner}/bakery.git\", branch = \"main\" }" ""
                substituteInPlace setup.py --replace "'bakery @ git+https://github.com/${owner}/bakery.git@main'" ""
            '';
        });
        type = "hy";
    };
}
