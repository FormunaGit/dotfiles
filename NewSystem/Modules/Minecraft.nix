# Minecraft server configuration
{ pkgs, ... }: {
  services.minecraft = {
    enable = true;
    eula = true;
    openFirewall = true;
    jvmOpts =
      "-Xms6G -Xmx6G -XX:+UseLargePages -XX:LargePageSizeInBytes=2M -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC -XX:ShenandoahGCMode=iu -XX:+UseNUMA -XX:+AlwaysPreTouch -XX:-UseBiasedLocking -XX:+DisableExplicitGC -Dfile.encoding=UTF-8";
    package = pkgs.papermcServers.papermc-1_20_1;
  };
}
