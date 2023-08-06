# home

- Install protonvpn-cli
- Update system:
  - `sudo apt update && sudo apt upgrade`
- Install Nix:
  - https://nixos.org/download.html
  - `sh <(curl -L https://nixos.org/nix/install) --no-daemon`
- Install Home Manager:
  - https://rycee.gitlab.io/home-manager/index.html#ch-installation
  - `nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager`
  - `nix-channel --update`
  - `nix-shell '<home-manager>' -A install`
  - `export NIXPKGS_ALLOW_UNFREE=1 && home-manager switch`
  - May need to `rm .bashrc .profile` and some Firefox profile, then try again
- Install Doom Emacs:
  - https://github.com/doomemacs/doomemacs#install
  - `git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs`
  - `~/.config/emacs/bin/doom install` (no envvar file)
- Login to github and generate SSH key
