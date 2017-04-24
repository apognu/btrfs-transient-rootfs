# btrfs transient root filesystem

initramfs hook for emphemeral root filesystem on btrfs.

**/!\ Early stage. Do not use! May lose your data.**

## How it works

The goal here is to automate as much as possible the use of ephemeral and disposable snapshots as rootfs when running your Linux system on btrfs by restoring the last-committed snapshot of your rootfs the next boot.

```
$ touch /etc/foobar
touch: cannot touch '/etc/foobar': Read-only file system

$ transient rw
$ touch /etc/foobar
$ reboot
-> File will not exist after reboot

$ transient rw
$ touch /srv/foobar
$ transient commit
Create a readonly snapshot of '__live/root' in '__transient/snapshots/2017-04-24T18:16:34+02:00'
Setting rootfs read-only.
$ reboot
-> File will be restored from last-commited snapshot
```

How it works is pretty simple, the live rootfs is deleted (and optionally backed up) on each boot and replaced by the last committed snapshot, effectively erasing all the changes done to the filesystem since the last commit.

A "commit" is simply a btrfs snapshot of your rootfs. At each boot, a backup of the previous rootf can be made to enable recovery (in case you forgit to commit your changes).

The number of backups (done at each boot) and snapshots (done when committing) to be retained can be configured in ```/etc/btrfs-transient.sh```.

I created this package to enable some kind of "transactions" to my Linux systems' rootfs. Therefore my / is mounted read-only (through btrfs properties), with the start of the transaction being the move to read-write. Data that should not be subject to this transaction process have to get their own subvolume (eg. /home, /srv, maybe /var).

## Build

```
$ git clone https://github.com/apognu/btrfs-transient-rootfs.git
$ makepkg
# pacman -U btrfs-transient-0.2-2-any.pkg.tar.xz
```

## Install

Add ```btrfs-transient``` to your HOOKS list in ```/etc/mkinitcpio.conf``` and rebuild your initramfs:

```
# vi /etc/mkinitcpio.conf
HOOKS="[...] btrfs btrfs-transient [...]"
# mkinitcpio -p linux
```

Edit ```/etc/btrfs-transient.sh``` and adapt your btrfs device and root subvolume (at least), and reboot.

The first run will:
 * create the necessary directories on your btrfs device
 * create a first snapshot containing the current state of your root filesystem
 * set your root filesystem as read only
