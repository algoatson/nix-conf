{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    z3_4_12
  ];
  environment.variables = {
        Z3_LIBRARY_PATH = "${pkgs.z3_4_12}/lib";
  };
}
