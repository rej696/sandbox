#!/bin/bash

if [ $# -gt 1 ];
then
    pushd $1
fi

for f in ./*.flac; do
    metaflac --import-picture-from="3|image/jpeg|||./cover.jpg" "$f"
done

if [ $# -gt 1 ];
then
    popd
fi


