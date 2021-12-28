# Linux
## Disk Management
## Automount Disk
First Check
Who is device automount
USAGE:
```shell
$ sudo lsblk -f
```

Where is mountpoint set
linux is fixed - /mnt/your\_directory\_name

And how is mount UUID=by-uuid and LABEL=by-label
USAGE:
```shell
$ sudo lsblk -f
```

Using Shell Script in terminal
```shell
$ cd disk
$ ./automount --automount "mountpoint_dir" "/dev/sdX" "UUID=by-uuid|LABEL=by-label"
```
