#!/bin/bash

export BTRFS_DEVICE='/dev/sda2'

export LIVE_SUBVOLUME='__live/root'
export SNAPSHOTS_SUBVOLUME='__transient/snapshots'
export TRANSIENT_SUBVOLUME='__transient/transient'
export INFO_SUBVOLUME='__transient/info'

export USE_RO_ROOTFS=1
export SNAPSHOTS_RETENTION=2
export TRANSIENT_RETENTION=2
