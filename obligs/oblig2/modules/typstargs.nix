{ ... }: {
  flake.typstargs = {
    typstSource = "./main.typ";
    fontPaths = [
      # Add paths to fonts here
      # "${pkgs.roboto}/share/fonts/truetype"
    ];

    virtualPaths = [
      # Add paths that must be locally accessible to typst here
      # {
      #   dest = "icons";
      #   src = "${inputs.font-awesome}/svgs/regular";
      # }
    ];
  };
}