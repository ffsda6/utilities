#TITLE=Bash script commands
#INFO
EditPlus cliptext for common bash script commands
#SORT=n

#T=bash
\#!/bin/bash

^!
#
#T=header
^# Script: ^!
^# Description: ^!
^# Author: ^!
^# Date: ^@
^# Version: 1.0
#
#T=func
function ^! {
local ^!
^!
return 0
}
#
#T=if
if \[ ^! ]; then
^!
fi
#
#T=ifel
if \[ ^! ]; then
^!
else
^!
fi
#
#T=elif
if \[ ^! ]; then
^!
elif \[ ^! ]; then
^!
else
^!
fi
#
#T=for
for ^! in ^!; do
^!
done
#
#T=while
while \[ ^! ]; do
^!
done
#
#T=case
case ^! in
^!)
^!
;;
\*)
^!
;;
esac
#
#T=usage
usage() {
cat << EOF
Usage: $(basename $0) \[OPTIONS]
Options:
-h, --help      Show this help message
^!
EOF
exit 1
}
#
#T=getopt
while getopts "^!:" opt; do
case $opt in
^!)
^!
;;
?)
usage
;;
esac
done
#
#T=trap
trap '^!' ^!
#
#T=temp
TEMPFILE=$(mktemp /tmp/^!.XXXXXX)
trap "rm -f $TEMPFILE" EXIT
#
#T=log
log() {
echo "\[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}
#
#T=err
error() {
echo "\[ERROR] $1" >&2
exit 1
}
#
#T=debug
DEBUG=1
debug() {
\[ "$DEBUG" -eq 1 ] && echo "\[DEBUG] $1"
}
#
#T=root
if \[ $(id -u) -ne 0 ]; then
error "This script must be run as root"
fi
#
#T=backup
BACKUP\_DIR="^!/backup"
BACKUP\_DATE=$(date +%Y%m%d\_%H%M%S)
mkdir -p "$BACKUP\_DIR"
#
#T=array
declare -a ^!=()
for item in "${^!\[@]}"; do
^!
done
#
#T=read
read -p "^!: " ^!
#
#T=confirm
confirm() {
read -p "$1 \[y/N] " response
case "$response" in
\[yY]\[eE]\[sS]|\[yY])
return 0
;;
\*)
return 1
;;
esac
}
#
#T=lock
LOCKFILE="/var/run/^!.lock"
if \[ -e "$LOCKFILE" ]; then
error "Script is already running"
fi
trap "rm -f $LOCKFILE" EXIT
touch "$LOCKFILE"
#
#T=config
CONFIG\_FILE="^!.conf"
if \[ ! -f "$CONFIG\_FILE" ]; then
error "Config file $CONFIG\_FILE not found"
fi
source "$CONFIG\_FILE"
#
#T=strict
set -euo pipefail
IFS=$'\n\t'
#
#T=cleanup
cleanup() {
^!
}
trap cleanup EXIT
#
#T=help
-h|--help)
usage
;;
#
#T=version
-v|--version)
echo "$(basename $0) version ^!"
exit 0
;;
#
#T=main
main() {
^!
}

main "$@"
#
