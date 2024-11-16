{ pkgs, ... }:
{
  services.vsftpd.writeEnable = true;
  services.vsftpd.localUsers = true;
  services.vsftpd.anonymousUser = false;
  services.vsftpd.extraConfig = ''
    pasv_min_port=51000
    pasv_max_port=51999
  '';
}
