{
  writeShellApplication,
  treefmt,
  lib,
  writers,
  deadnix,
  mdformat,
  nixfmt,
  statix,
  prettier,
  yamlfmt,
}:
let
  statix-fix = writeShellApplication {
    name = "statix-fix";
    text = ''
      for file in "$@"; do
        ${lib.getExe statix} fix "$file"
      done
    '';
  };

  treefmtToml = writers.writeTOML "treefmt.toml" {
    formatter = {
      mdformat = {
        command = lib.getExe mdformat;
        excludes = [ ];
        includes = [ "*.md" ];
        options = [ ];
      };

      deadnix = {
        command = lib.getExe deadnix;
        excludes = [ ];
        includes = [ "*.nix" ];
        options = [ "--edit" ];
      };

      nixfmt = {
        command = lib.getExe nixfmt;
        excludes = [ ];
        includes = [ "*.nix" ];
        options = [ ];
      };

      statix = {
        command = lib.getExe statix-fix;
        excludes = [ ];
        includes = [ "*.nix" ];
        options = [ ];
      };

      prettier = {
        command = lib.getExe prettier;
        excludes = [ ];
        includes = [
          "*.css"
          "*.json"
        ];
        options = [ ];
      };

      yamlfmt = {
        command = lib.getExe yamlfmt;
        excludes = [ ];
        includes = [
          "*.yaml"
          "*.yml"
        ];
        options = [ ];
      };
    };
  };
in
treefmt.withConfig {
  name = "formatter";
  configFile = treefmtToml;
}
