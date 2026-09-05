{ inputs, self, ... }: {
  perSystem = { system, ... }:
    let 
      typixLib = inputs.typix.lib.${system};
    in {
      packages.default = typixLib.buildTypstProject (self.typstargs // {
        src = typixLib.cleanTypstSource ../.;
      });
    };
}