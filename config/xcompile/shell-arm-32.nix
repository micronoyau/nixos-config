with import <nixpkgs> {
  crossSystem = {
    config = "armv7l-unknown-linux-gnueabihf";
  };
};

mkShell {
  buildInputs = [ ];
}
