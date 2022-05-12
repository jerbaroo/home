{ config, pkgs, ... }:

{
  home.username = "jer";
  home.homeDirectory = "/home/jer";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  home.packages = [
    pkgs.beekeeper-studio
    pkgs.bitwarden
    pkgs.cabal-install
    pkgs.cachix
    pkgs.emacs-all-the-icons-fonts
    pkgs.fd # Doom dependency.
    pkgs.ghc
    pkgs.ghcid
    pkgs.mailspring
    pkgs.pandoc # Doom dependency.
    pkgs.protonvpn-gui
    pkgs.ripgrep # Doom dependency.
    pkgs.screenfetch
    pkgs.shellcheck # Doom dependency.
    pkgs.spotify
  ];

  programs.bash.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.emacs.enable = true;
  programs.lsd.enable = true;
  programs.firefox.enable = true;
  programs.fish = {
    enable = true;
    shellInit = ''
      fish_vi_key_bindings
      set fish_greeting
    '';
  };
  programs.git = {
    enable = true;
    userName = "jerbaroo";
    userEmail = "jerbaroo.work@pm.me";
  };
  programs.kitty = {
    enable = true;
    extraConfig  = ''
      include diff.conf
      include dracula.conf
    '';
    font.size = 16;
    font.name = "Iosevka Term Semibold";
    font.package = pkgs.iosevka;
    settings = {
      enable_audio_bell = false;
      hide_window_decorations = false;
    };
  };
  programs.neovim = {
    enable = true;
    extraConfig = ''
      :set colorcolumn=81
      :set laststatus=0 ruler
    '';
    viAlias = true;
  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true; # Default is true, just to be explicit.
    settings = {
      add_newline = false;
      character = {
        vicmd_symbol = "N";
      };
    };
  };
  programs.tmux = {
    clock24                   = true;
    baseIndex                 = 1;
    disableConfirmationPrompt = true;
    enable                    = true;
    historyLimit              = 1000000;
    keyMode                   = "vi";
    newSession                = true;
    secureSocket              = true;
    shortcut = "a";
    # Telling tmux which shell to load up.
    shell = "\${pkgs.fish}/bin/fish";
  };
}
