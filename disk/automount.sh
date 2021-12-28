#!/usr/bin/bash
function Automount(){
	local MOUNTPOINT="$1"
	local DEV_SDX="$2"
	local UUID_LABEL="$3"
	if [[ -z "$BY_UUID_LABEL" ]]; then
		echo "[x] Please using UUID=by-uuid|LABEL=by-label 'sudo lsblk -f'"
		exit
	elif [[ ! -e "$DEV_SDX" ]]; then
		echo "[x] Device $DEV_SDX is not exist!"
		echo "[x] Please check mount device PATH 'sudo lsblk -f'"
		exit
	elif [[ $(gentent group $(basename "$MOUNTPOINT")) ]]; then
		echo "[x] Group is already $(basename "$MOUNTPOINT")"
		exit
	else
		echo "[ok] Device $DEV_SDX is exist!"
		echo "[...] Create a mount point..."
		if [[ -d "$MOUNTPOINT" ]]; then
			echo "[...] Directory $MOUNTPOINT is already exist!"
		else
			echo "[x] Directory $MOUNTPOINT is not exist!"
			echo "[...] Create mount point $MOUNTPOINT"
			sudo mkdir -p "$MOUNTPOINT"
		fi
		
		if mountpoint -q -- "$MOUNTPOINT"; then
			echo "[...] Mount point is already mount another device"
			mountpoint "$MOUNTPOINT"
			echo "[...] Mount point unmount another device"
			sudo umount "$MOUNTPOINT"
		fi

		echo "[...] Mount point $MOUNTPOINT mount is this $DEV_SDX"
		sudo mount "$DEV_SDX" "$MOUNTPOINT"
		echo "[...]"
		echo "[...] Create and Adding Group is this mount point $MOUNTPOINT"
		echo "[...] Access only is group '$(basename "$MOUNTPOINT")'"
		sudo groupadd "$(basename "$MOUNTPOINT")"
		echo "[...] Change the owership of the mount point"
		sudo chown -R :"$(basename "$MOUNTPOINT")" "$MOUNTPOINT"
		echo "[...] Automate the process of mounting partition '/etc/fstab'"
		echo -e "$UUID_LABEL\t$MOUNTPOINT\tauto\t nosuid,nodev,nofail,x-gvfs-show 0 0"
		sudo bash -c "echo -e \"$UUID_LABEL\t$MOUNTPOINT\tauto\t nosuid,nodev,nofail,x-gvfs-show 0 0\" >> /etc/fstab"
		echo "[...] Group add this $USER"
		sudo usermod -aG "$(basename "$MOUNTPOINT")" $USER
		echo "Reboot Now"
		
}
SELECTION="$1"
case "$SELECTION" in
	"--automount"|"automount")
		Automount "$2" "$3" "$4"
		;;
	*)
		echo "Not command found"
		;;
esac
