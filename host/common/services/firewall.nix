{ lib, hostname, ... }:
let
  # Firewall configuration variable for syncthing
  syncthing = {
    hosts = [
      "freyja"
      "kara"
      "thor"
    ];
    tcpPorts = [ 22000 ];
    udpPorts = [
      22000
      21027
    ];
  };
in
{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = lib.optionals (builtins.elem hostname syncthing.hosts) syncthing.tcpPorts;
      allowedUDPPorts = lib.optionals (builtins.elem hostname syncthing.hosts) syncthing.udpPorts;
    };
  };
}
