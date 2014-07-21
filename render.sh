#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# get script location
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# goto blender dir
cd /Applications/blender.app/Contents/MacOS/

# create output dir
mkdir -p $DIR/output

# render each scene
for path in $DIR/*.blend
do
    filename=$(basename $path)
    name="${filename%.*}"
    echo "Rendering $name"

    ./blender \
        --background $path \
        --render-output "//output/${name}_#.png" \
        --engine CYCLES \
        --render-format PNG \
        --use-extension 1 \
        --render-frame 1 >> $DIR/output.log 2>&1
done

