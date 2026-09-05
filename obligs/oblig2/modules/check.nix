{ inputs, self, ... }: {
  perSystem = { system, ... }:
    let
      typixLib = inputs.typix.lib.${system};
    in {
      checks = {
        build-drv = typixLib.buildTypstProject (self.typstargs // {
          src = typixLib.cleanTypstSource ../.;
        });
        watch-script = typixLib.watchTypstProject self.typstargs;
      };
    };
}