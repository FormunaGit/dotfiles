# Minecraft server configuration
# Thx Vimjoyer!
{ ... }:
{
  # services.minecraft-server = {
  #   enable = true;
  #   eula = true;
  #   openFirewall = true;
  #   jvmOpts =
  #     "-Xms6G -Xmx6G -XX:+UseLargePages -XX:LargePageSizeInBytes=2M -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC -XX:ShenandoahGCMode=iu -XX:+UseNUMA -XX:+AlwaysPreTouch -XX:-UseBiasedLocking -XX:+DisableExplicitGC -Dfile.encoding=UTF-8";
  #   package = pkgs.papermcServers.papermc-1_20_1;
  # };
  # imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  # nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  # services.minecraft-servers = {
  #   enable = true;
  #   eula = true;
  #   servers.something = {
  #     enable = true;
  #     package = pkgs.paperServers.paper-1_21_8;
  #     jvmOpts = "-Xms1M -Xmx6G";
  #     serverProperties = {
  #       motd = "something wicked this way comes..?";
  #       max-players = 10;
  #       online-mode = false;
  #       difficulty = "easy";
  #       enable-rcon = true;
  #       "rcon.password" = "rconIsntPortforwardedProbably";
  #       "rcon.port" = 25575;
  #       resource-pack =
  #         "https://drive.google.com/uc?export=download&id=1s1D238TpqqMvPuKANryiCGvTB-HCBHvv";
  #       resource-pack-sha1 = "095466d10fdca2449cc0c7d17193f232dc728143";
  #       resource-pack-id = "8c255d5b-3a42-43a6-b658-e9f1535cbfc8";
  #     };
  #   };
  # };
}
