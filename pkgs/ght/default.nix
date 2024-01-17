{ lib
, pkgs
, ...
}:

pkgs.buildNpmPackage rec {
  pname = "ght";
  version = "1.6.0";

  src = pkgs.fetchFromGitHub {
    owner = "canonical";
    repo = pname;
    rev = "5464a5884283d933baf876fd4d812ccde912dd16";
    sha256 = "sha256-gzbdHk9D54zMPDYIEB19+KcCHUpqGqC8wQS1IQmfEDg=";
  };

  npmDeps = pkgs.fetchNpmDeps {
    inherit src;
    hash = "sha256-yC+hs5vdIgzpDMLY5aguOUJKqieQ1qFlAP7uPmJEIgc=";
  };

  patches = [
    ./ght-graders-loc.patch
  ];

  postPatch = ''
    substituteInPlace ght \
        --replace "./index.js" "$out/opt/ght/index.js" \
        --replace "./package.json" "$out/opt/ght/package.json"
  '';

  env.PUPPETEER_SKIP_DOWNLOAD = true;

  installPhase = ''
    mkdir -p $out/bin $out/opt
    
    # Copy the built tool & node_modules into the output
    cp -r dist $out/opt/ght
    cp -r node_modules $out/opt/ght/node_modules

    # Copy the 'binary' into place
    cp ght $out/bin/ght

    # Make sure that chromium is available and puppeteer knows to use it
    wrapProgram $out/bin/ght \
        --set PUPPETEER_EXECUTABLE_PATH ${pkgs.chromium.outPath}/bin/chromium
  '';

  meta = {
    description = "Perform actions in Greenhouse from you terminal.";
    maintainers = with lib.maintainers; [ jnsgruk ];
  };
}

