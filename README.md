# My NixOS Configuration

This repository contains my personal NixOS configuration, using flakes and Home Manager. It supports multiple hosts while sharing a common set of modules and packages.

## Design Overview

The configuration is structured to stay modular and reusable.

Each machine is defined under `/hosts`, where every host imports only the features it needs from `/modules`.

The `/modules` directory is the core of the system. It contains self-contained Nix modules where each program, service, or system feature is fully defined in a single file. For example, importing `modules/programs/nvim.nix` is enough to install and configure Neovim with my full setup.

The same idea applies across the system:

* `modules/desktop` → window managers, wallpapers, desktop environment configs
* `modules/hardware` → drivers and hardware-specific configuration
* `modules/programs` → user applications (editor, browser, gaming, etc.)
* `modules/services` → server-side applications and self-hosted services

This keeps configuration declarative, composable, and easy to reason about.


## Installation Guide

You can either follow the [official NixOS installation guide](https://nixos.org/manual/nixos/stable/index.html#ch-installation) or use the steps below to install the OS. Once you boot into it the first time, continue in [First boot](#first-boot).

### Boot the Live ISO

Boot into the minimal NixOS installer.

The following steps create the partition layout that will later be reflected in `hardware-configuration.nix`.

```sh
sudo -i
lsblk
cfdisk /dev/vda   # Replace with your installation disk
```

Create a GPT partition table with:

| Partition  | Type             | Size                             |
| ---------- | ---------------- | -------------------------------- |
| EFI System | EFI              | 1 GiB                            |
| Swap       | Linux Swap       | 4 GiB (or roughly your RAM size) |
| Root       | Linux Filesystem | Remaining space (enter twice)    |

### Format the partitions

```sh
mkfs.ext4 -L nixos /dev/vda3
mkswap -L swap /dev/vda2
mkfs.fat -F 32 -n boot /dev/vda1
```

### Mount the partitions

```sh
mount /dev/vda3 /mnt
mount --mkdir /dev/vda1 /mnt/boot
swapon /dev/vda2
```

Verify everything is mounted correctly with:

```sh
lsblk
```

## Initial NixOS Configuration

Generate the initial configuration:

```sh
nixos-generate-config --root /mnt
cd /mnt/etc/nixos
```

Edit `configuration.nix` to contain only the minimum configuration required to install the system and enable flakes.

Enable flakes line:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

Also uncomment the user configuration and adjust the username, password, and other basic settings.

When you're ready, install NixOS:

```sh
nixos-install
```

Set a password for your user:

```sh
nixos-enter --root /mnt -c 'passwd your-username'
```

Then reboot.

## First Boot

Clone the repository:

```sh
git clone https://github.com/champiw/.dotfiles ~/.dotfiles
sudo chown -R your-username:users ~/.dotfiles
cd ~/.dotfiles
```

## Creating a New Host

Copy an existing host as a starting point:

```sh
cp -r ~/.dotfiles/hosts/dopros ~/.dotfiles/hosts/<your-host>
```

Replace the generated hardware configuration:

```sh
rm ~/.dotfiles/hosts/<your-host>/hardware.nix
cp /etc/nixos/hardware-configuration.nix \
   ~/.dotfiles/hosts/<your-host>/hardware.nix
```

Next, add a new system entry to `flake.nix`:

```nix
your-host = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs self; };

  modules = [
    ./hosts/your-host/default.nix
  ];
};
```

Open `hosts/<your-host>/default.nix`.

At a minimum, your imports should include:

* `./hardware.nix`
* `../../modules/base` (base modules and configs for every system)
* `inputs.home-manager.nixosModules.home-manager`

The remainder of the file contains host-specific settings followed by configuration shared across all systems. In most cases, the only value you need to change in the shared section is:

```nix
networking.hostName = "your-host";
```

## Applying the Configuration

Once your host has been added to `flake.nix` and configured, apply it with:

```sh
sudo nixos-rebuild switch --flake .#your-host
reboot
```

After rebooting, your system will be running your new configuration.

