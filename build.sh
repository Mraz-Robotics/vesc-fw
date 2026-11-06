#!/bin/bash
# build.sh — build VESC firmware for a board inside Docker in a single step.
#
# Usage:
#   ./build.sh <board> [<board> ...]   e.g. ./build.sh dmr_60_70_v1
#   ./build.sh                         open an interactive shell in the container
#
# Env:
#   REBUILD=1   force rebuild of the Docker image
#   REPO=path   firmware repo to mount (default: directory of this script)
set -euo pipefail

IMAGE="vesc-builder"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO="${REPO:-$SCRIPT_DIR}"
ARM_SDK_DIR="tools/gcc-arm-none-eabi-7-2018-q2-update"

[ -f "$SCRIPT_DIR/Dockerfile" ] || { echo "No Dockerfile in $SCRIPT_DIR"; exit 1; }
[ -d "$REPO" ]                  || { echo "Repo not found: $REPO"; exit 1; }

if ! sudo docker image inspect "$IMAGE" >/dev/null 2>&1 || [ "${REBUILD:-}" = "1" ]; then
    echo "Building image $IMAGE..."
    sudo docker build -t "$IMAGE" "$SCRIPT_DIR"
fi

TTY_FLAGS="-i"
[ -t 0 ] && [ -t 1 ] && TTY_FLAGS="-it"

RUN=(sudo docker run $TTY_FLAGS --rm -v "$REPO":/bldc -w /bldc "$IMAGE")

if [ $# -eq 0 ]; then
    exec "${RUN[@]}"
fi

# Install the ARM toolchain once (it is stored in tools/ of the mounted repo),
# then build every requested board.
"${RUN[@]}" bash -c '
    set -e
    [ -x "'"$ARM_SDK_DIR"'/bin/arm-none-eabi-gcc" ] || make arm_sdk_install
    for b in "$@"; do
        echo "=== Building $b ==="
        make "$b"
    done
' _ "$@"

echo "Done. Output is in $REPO/build/"
