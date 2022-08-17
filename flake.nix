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
        callPackage = { buildPythonPackage, pythonOlder, poetry-core, bakery, pytest-hy, pytest-randomly, pytestCheckHook, pname }: let
            owner = "syvlorg";
        in buildPythonPackage rec {
            inherit pname;
            version = j.pyVersion format src;
            format = "pyproject";
            disabled = pythonOlder "3.9";
            src = ./.;
            buildInputs = [ poetry-core ];
            nativeBuildInputs = buildInputs;
            propagatedBuildInputs = [ (bakery.overridePythonAttrs (old: { doCheck = false; })) ];
            pythonImportsCheck = [ pname ];
            checkInputs = [ pytestCheckHook pytest-hy pytest-randomly ];
            checkPhase = "pytest";
            postPatch = ''
                substituteInPlace pyproject.toml --replace "bakery = { git = \"https://github.com/${owner}/bakery.git\", branch = \"main\" }" ""
                substituteInPlace setup.py --replace "'bakery @ git+https://github.com/${owner}/bakery.git@main'" ""
            '';
            meta.homepage = "https://github.com/${owner}/${pname}";
        };
        type = "hy";
    };
}
