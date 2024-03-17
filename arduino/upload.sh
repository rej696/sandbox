#!/bin/bash

file=""
board="arduino:avr:uno"
port="/dev/ttyACM0"

while getopts "f:b:p:" option; do
    case $option in
        f) file=$OPTARG ;;
        b) board=$OPTARG ;;
        p) port=$OPTARG ;;
    esac
done

compile_and_upload () {
    arduino-cli compile $file -b $board
    if [ $? -ne 0 ]; then
        echo "Compilation error"
        exit $?
    fi
    arduino-cli upload $file -b $board -p $port
    return $?
}

if [ -n "$file" ]; then
    compile_and_upload
    if [ $? -ne 0 ]; then
        echo "Permission error, changing permissions and trying again"
        sudo chmod a+rw /dev/ttyACM0
        compile_and_upload
        if [ $? -ne 0 ]; then
            echo "Upload failed"
        else
            echo "Permissions changed, upload successful"
        fi
    else
        echo "Successfully uploaded"
    fi
else
    echo "No file provided, please state which file you wish to compile and upload using the -f option"
fi

