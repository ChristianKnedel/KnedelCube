#!/bin/bash
RANDOM_DIR=$(find sorted/ -type d | shuf -n 1)
WORK_DIR=/tmp/knedelcube/

if [ ! -d "${WORK_DIR}" ] 
then
    mkdir -p "${WORK_DIR}"
fi
rm -rf "${WORK_DIR}/*"
cp ${RANDOM_DIR}/*.gif "${WORK_DIR}/"

select_site() {
    random_image=$(ls ${WORK_DIR}/*.gif | shuf -n 1)
    mv "$random_image" "$random_image.selected"
    echo "$random_image.selected"
}

image1=$(select_site)
image2=$(select_site)
image3=$(select_site)
image4=$(select_site)
image5=$(select_site)

ffmpeg -y -i $image1 -i $image2 -i $image3 -i $image4 -i $image5 -filter_complex hstack=inputs=5 merged.gif
