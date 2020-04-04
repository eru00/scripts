#!/bin/bash

inputDir=.
outputDir=.
regex=^.*$
outFileSuffix=_compressed

while getopts i:o:r:s: option; do
  case "${option}" 
  in
    i) inputDir=${OPTARG};;
    o) outputDir=${OPTARG};;
    r) regex=${OPTARG};;
    s) outFileSuffix=${OPTARG};;
  esac
done

list(){
  local dir=$1
  for inFile in "$dir"/*; do
      [ -e "$inFile" ] || continue
      [[ "$inFile" =~ $regex ]] || continue
      printf "%s\n" "$inFile"
  done
}

appendSuffix(){
  echo "$1" | sed -e 's|^\(.*\)\.\([^\.]*\)$|\1'"$2"'\.\2|'
}

inputFiles=$(list $inputDir)

printf "Input files:\n"
printf "%s\n" "$inputFiles" | sed -e 's|^\(.*\)|  \1|'

printf "Output files:\n"
printf "%s\n" "$(appendSuffix "$inputFiles" "$outFileSuffix" )" | sed -e 's|^\(.*\)|  \1|'

printf "Do you want to continue? [Y/n] "
read ans
[[ ! "$ans" =~ ^(y|Y)?$ ]] && echo Abort. && exit 1

while IFS= read -r file; do
  in="$file"
  out="$(appendSuffix "$in" "$outFileSuffix")"
  printf "Processing %s...\n" "${in}"
  ffmpeg -i "$in" -vcodec libx265 -map 0 -crf 24 "$out"
  printf "Wrote output to %s\n" "${out}"
done <<< "$inputFiles"