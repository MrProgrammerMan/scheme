{ inputs, self, ... }: {
  perSystem = { system, pkgs, ... }: {
    apps = {
      watch = {
        type = "app";
        program = pkgs.lib.getExe (inputs.typix.lib.${system}.watchTypstProject self.typstargs);
      };
    };
  };
}