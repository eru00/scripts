#!/bin/bash

set -e

[[ $# -ne 2 ]] && printf "Error: %s requires exactly 2 arguments\n" "$0" && exit 1

originalFile=$(realpath "$1")
destination=$(realpath "$2")

mv "$originalFile" "$destination"
ln -s "$destination" "$originalFile"
