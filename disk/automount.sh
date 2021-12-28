#!/usr/bin/bash
function Automount(){
	local MOUNTPOINT="$1"
	local DEV_SDX="$2"
	local UUID_LABEL="$3"
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
