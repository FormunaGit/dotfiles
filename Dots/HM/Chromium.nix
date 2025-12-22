{ inputs, ... }:
{
  programs.chromium = {
    enable = true;
    package = inputs.thorium.packages."x86_64-linux".thorium-avx2;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin: Adblocker
      { id = "mpbjkejclgfgadiemmefgebjfooflfhl"; } # Buster: Captcha solver
      { id = "hfjngafpndganmdggnapblamgbfjhnof"; } # RoSeal: Roblox website enhancer
      { id = "fkagelmloambgokoeokbpihmgpkbgbfm"; } # Indie Wiki Buddy: Prefer non-Fandom wikis
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock: Skip unnecessary segments
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass: Password manager | TODO: Replace it
    ];
  };
}
