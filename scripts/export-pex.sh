#!/bin/bash

set -o nounset -o errexit -o errtrace -o pipefail

declare -r DEST="${VDIR}"
declare -r IMAGE="${VNAME}"

trap 'rm -f mount.path' EXIT

podman image mount "${IMAGE}" &> mount.path
find "$(cat mount.path)"/app -maxdepth 1 -type f -executable -exec cp -av {} "${DEST}" \;
podman image umount "${IMAGE}"
