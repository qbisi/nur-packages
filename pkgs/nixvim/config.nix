{ config, pkgs, lib, ... }: {
  imports = [
    ./plugins/plugins.nix
    ./keymap.nix
  ];
  config = {
    # Color scheme.
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "macchiato";
    };

    # Options.
    opts = {
      # Indent settings.
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      # Line number.
      number = true;
      # relativenumber = true;
      signcolumn = "yes";
      # Search case sensitivity.
      ic = true;
      # Keymodel.
      keymodel = "startsel,stopsel";
      selection = "exclusive";
      virtualedit = "onemore";
    };

    # Clipboard.
    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };


    # Packages
    extraPackages = [
      pkgs.nixpkgs-fmt
    ];

    # keymaps
    globals.mapleader = " ";
    keymaps = [
      # Undo.
      {
        mode = [ "n" ];
        key = "<C-z>";
        action = "u";
        options = { desc = "Undo"; };
      }
      {
        mode = [ "v" ];
        key = "<C-z>";
        action = "u==gv";
        options = { desc = "Undo"; };
      }
      {
        mode = [ "n" ];
        key = "<C-s>";
        action = ":update<CR>";
        options = { desc = "Save"; };
      }
      {
        mode = [ "i" ];
        key = "<C-s>";
        action = "<C-O>:update<CR>";
        options = { desc = "Save"; };
      }
      {
        mode = [ "i" ];
        key = "<C-s>";
        action = "<C-C>:update<CR>";
        options = { desc = "Save"; };
      }
      {
        mode = [ "v" ];
        key = "<C-c>";
        action = ''"*y'';
      }
      {
        mode = [ "v" ];
        key = "<C-x>";
        action = ''"*d'';
      }
    ];
  };
}
