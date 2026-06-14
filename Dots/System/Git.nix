{ ... }: {
  programs.git.config = {
    core.hooksPath = ".githooks";
  };
}
