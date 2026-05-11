{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.npm = {
    enable = true;
    package = pkgs.nodejs_24;
    settings.prefix = "${config.home.homeDirectory}/.npm";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm/bin"
  ];

  home.activation.installGeminiCli = lib.hm.dag.entryAfter ["writeBoundary"] ''
    npm_prefix="${config.home.homeDirectory}/.npm"

    run mkdir -p "$npm_prefix/bin"
    run env \
      HOME="${config.home.homeDirectory}" \
      NPM_CONFIG_USERCONFIG="${config.home.homeDirectory}/.npmrc" \
      PATH="${pkgs.nodejs_24}/bin:$PATH" \
      "${pkgs.nodejs_24}/bin/npm" install --global --prefix "$npm_prefix" --no-audit --no-fund @google/gemini-cli@latest
  '';
}
