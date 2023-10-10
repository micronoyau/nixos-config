with import <nixpkgs> {
  crossSystem = {
    config = "mipsel-linux";
  };
};

mkShell {
  buildInputs = [ ];
}
