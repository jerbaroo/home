{ config, lib, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "acc";
  home.homeDirectory = "/home/acc";
  home.stateVersion = "23.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.beekeeper-studio
    pkgs.bitwarden
    pkgs.cabal-install
    pkgs.cachix
    pkgs.emacs-all-the-icons-fonts
    pkgs.fd # Doom dependency.
    pkgs.ghc
    pkgs.ghcid
    pkgs.jetbrains-mono
    pkgs.pandoc # Doom dependency.
    pkgs.ripgrep # Doom dependency.
    pkgs.screenfetch
    pkgs.shellcheck # Doom dependency.
    pkgs.spotify
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/doom/config.el".text = ''
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq display-line-numbers-type 'relative
      doom-font (font-spec :family "JetBrains Mono" :size 22 :weight 'semi-bold)
      doom-theme 'doom-dracula
      doom-themes-treemacs-theme "doom-colors"
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 22 :weight 'semi-bold)
      ;; lsp-enable-file-watchers nil
      lsp-haskell-server-path "haskell-language-server"
      lsp-ui-doc-enable t
      org-directory "~/org/"
      org-latex-pdf-process
        '("xelatex -shell-escape -interaction nonstopmode %f"
          "bibtex %b"
          "xelatex -shell-escape -interaction nonstopmode %f")
      user-full-name "jerbaroo"
      user-mail-address "jerbaroo.work@pm.me"
      which-key-idle-delay 0.0
      zoom-size '(0.60 . 0.60)
      )

(global-display-fill-column-indicator-mode)

(map! "C-h" #'evil-window-left
      "C-j" #'evil-window-down
      "C-k" #'evil-window-up
      "C-l" #'evil-window-right
      )
    '';
    ".config/doom/init.el".text = ''
;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a link to Doom's Module Index where all
;;      of our modules are listed, including what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :input
       ;;bidi              ; (tfel ot) thgir etirw uoy gnipleh
       ;;chinese
       ;;japanese
       ;;layout            ; auie,ctsrnm is the superior home row

       :completion
       company           ; the ultimate code completion backend
       ;;helm              ; the *other* search engine for love and life
       ;;ido               ; the other *other* search engine...
       ;;ivy               ; a search engine for love and life
       vertico           ; the search engine of the future

       :ui
       ;;deft              ; notational velocity for Emacs
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       ;;doom-quit         ; DOOM quit-message prompts when you quit Emacs
       ;;(emoji +unicode)  ; 🙂
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ;;hydra
       indent-guides     ; highlighted indent columns
       ligatures         ; ligatures and symbols to make your code pretty again
       minimap           ; show a map of the code on the side
       modeline          ; snazzy, Atom-inspired modeline, plus API
       ;;nav-flash         ; blink cursor line after big motions
       ;;neotree           ; a project drawer, like NERDTree for vim
       ophints           ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       ;;tabs              ; a tab bar for Emacs
       treemacs          ; a project drawer, like neotree but cooler
       ;;unicode           ; extended unicode support for various languages
       (vc-gutter +pretty) ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       ;;window-select     ; visually switch windows
       workspaces        ; tab emulation, persistence & separate workspaces
       ;;zen               ; distraction-free coding or writing

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       ;;(format +onsave)  ; automated prettiness
       ;;god               ; run Emacs commands without modifier keys
       ;;lispy             ; vim for lisp, for people who don't like vim
       ;;multiple-cursors  ; editing in many places at once
       ;;objed             ; text object editing for the innocent
       ;;parinfer          ; turn lisp into python, sort of
       ;;rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to
       ;;word-wrap         ; soft wrapping with language-aware indent

       :emacs
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       ;;ibuffer         ; interactive buffer management
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       ;;eshell            ; the elisp shell that works everywhere
       ;;shell             ; simple shell REPL for Emacs
       ;;term              ; basic terminal emulator for Emacs
       ;;vterm             ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       ;;(spell +flyspell) ; tasing you for misspelling mispelling
       ;;grammar           ; tasing grammar mistake every you make

       :tools
       ;;ansible
       ;;biblio            ; Writes a PhD for you (citation needed)
       ;;debugger          ; FIXME stepping through code, to help you add bugs
       direnv
       docker
       editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)     ; run code, run (also, repls)
       ;;gist              ; interacting with github gists
       lookup              ; navigate your code and its documentation
       lsp               ; M-x vscode
       magit             ; a git porcelain for Emacs
       ;;make              ; run make tasks from Emacs
       ;;pass              ; password manager for nerds
       pdf               ; pdf enhancements
       ;;prodigy           ; FIXME managing external services & code builders
       ;;rgb               ; creating color strings
       ;;taskrunner        ; taskrunner for all your projects
       ;;terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       ;;tree-sitter       ; syntax and parsing, sitting in a tree...
       ;;upload            ; map local to remote projects via ssh/ftp

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
       ;;tty               ; improve the terminal Emacs experience

       :lang
       ;;agda              ; types of types of types of types...
       ;;beancount         ; mind the GAAP
       ;;(cc +lsp)         ; C > C++ == 1
       ;;clojure           ; java with a lisp
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       ;;csharp            ; unity, .NET, and mono shenanigans
       ;;data              ; config/data formats
       ;;(dart +flutter)   ; paint ui and not much else
       ;;dhall
       ;;elixir            ; erlang done right
       ;;elm               ; care for a cup of TEA?
       emacs-lisp        ; drown in parentheses
       ;;erlang            ; an elegant language for a more civilized age
       ;;ess               ; emacs speaks statistics
       ;;factor
       ;;faust             ; dsp, but you get to keep your soul
       ;;fortran           ; in FORTRAN, GOD is REAL (unless declared INTEGER)
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;fstar             ; (dependent) types and (monadic) effects and Z3
       ;;gdscript          ; the language you waited for
       ;;(go +lsp)         ; the hipster dialect
       ;;(graphql +lsp)    ; Give queries a REST
       (haskell +lsp)    ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       ;;idris             ; a language you can depend on
       ;;json              ; At least it ain't XML
       ;;(java +lsp)       ; the poster child for carpal tunnel syndrome
       javascript        ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia             ; a better, faster MATLAB
       ;;kotlin            ; a better, slicker Java(Script)
       ;;latex             ; writing papers in Emacs has never been so fun
       ;;lean              ; for folks with too much to prove
       ;;ledger            ; be audit you can be
       ;;lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       nix               ; I hereby declare "nix geht mehr!"
       ;;ocaml             ; an objective camel
       org               ; organize your plain life in plain text
       ;;php               ; perl's insecure younger brother
       ;;plantuml          ; diagrams for confusing people more
       ;;purescript        ; javascript, but functional
       python            ; beautiful is better than ugly
       ;;qt                ; the 'cutest' gui framework ever
       ;;racket            ; a DSL for DSLs
       ;;raku              ; the artist formerly known as perl6
       ;;rest              ; Emacs as a REST client
       ;;rst               ; ReST in peace
       ;;(ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;;(rust +lsp)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala             ; java, but good
       ;;(scheme +guile)   ; a fully conniving family of lisps
       sh                ; she sells {ba,z,fi}sh shells on the C xor
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       ;;web               ; the tubes
       ;;yaml              ; JSON, but readable
       ;;zig               ; C, but simpler

       :email
       ;;(mu4e +org +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       ;;calendar
       ;;emms
       ;;everywhere        ; *leave* Emacs!? You must be joking
       ;;irc               ; how neckbeards socialize
       ;;(rss +org)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought

       :config
       ;;literate
       (default +bindings +smartparens))
    '';
  };
  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/acc/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
    TERM = "xterm";
  };
  programs.bash = {
    enable = true;
  };
  programs.dircolors.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.emacs.enable = true;
  programs.lsd.enable = true;
  programs.firefox = {
    enable = true;
    profiles.acc = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        decentraleyes
        flagfox
        privacy-badger
        sidebery
        ublock-origin
        vimium
      ];
      settings = {
        "browser.contentblocking.cryptomining.preferences.ui.enabled"   = true;
        "browser.contentblocking.fingerprinting.preferences.ui.enabled" = true;
        "browser.newtabpage.activity-stream.feeds.section.topstories"   = false;
        "extensions.pocket.enabled"                                     = false;
        "privacy.donottrackheader.enabled"                              = true;
        "privacy.trackingprotection.enabled"                            = true;
        "privacy.trackingprotection.cryptomining.enabled"               = true;
        "privacy.trackingprotection.socialtracking.enabled"             = true;
        "signon.rememberSignons"                                        = false;
      };
    };
  };
  programs.fish = {
    enable = true;
    shellInit = ''
      fish_vi_key_bindings
      set fish_greeting
      if status is-interactive
      and not set -q TMUX
        # Create session 'main' or attach to 'main' if already exists.
        tmux new-session -A -s main
      end
    '';
  };
  programs.git = {
    enable    = true;
    userName  = "jerbaroo";
    userEmail = "jerbaroo.work@pm.me";
  };
  programs.kitty = {
    enable = true;
    font.size = 18;
    font.name = "JetBrains Mono";
    font.package = pkgs.jetbrains-mono;
    settings = {
      enable_audio_bell       = false;
      hide_window_decorations = false;
      scrollback_lines        = 10000000;
      shell                   = "${pkgs.fish}/bin/fish";
      update_check_interval   = 0;
    };
    theme = "Dracula";
    # Nix kitty package is broken due to OpenGL, but we still want the config.
    # So we enable kitty in home-manager, but point to system installed kitty.
    package = pkgs.writeShellScriptBin "kitty" ''
      /usr/bin/kitty
    '';
  };
  programs.neovim = {
    enable = true;
    extraConfig = ''
      :set colorcolumn=80
      :set laststatus=0 ruler
    '';
    viAlias = true;
  };
  programs.nix-index.enable = true;
  programs.starship = {
    enable   = true;
    settings = {
      add_newline = false;
      character   = {
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
    shortcut                  = "a";
    # Telling tmux which shell to load up.
    shell                     = "${pkgs.fish}/bin/fish";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      { plugin = dracula;
        extraConfig = ''
	  set -g @dracula-show-battery false
	  set -g @dracula-show-powerline true
	  set -g @dracula-refresh-rate 10
        '';
      }
    ];
    extraConfig = ''
      set -g mouse on
    '';
  };
  xdg.systemDirs.data = [ "~/.nix-profile/share/applications" ];
}

