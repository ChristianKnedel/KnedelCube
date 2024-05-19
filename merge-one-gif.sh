#!/bin/bash
HOME_BASE=/home/cube/knedelcube/

# My animations are organized by frames  "images/sorted-by-frame"
RANDOM_DIR=$(find "${HOME_BASE}/images/" -type d | shuf -n 1)
WORK_DIR=/tmp/knedelcube/

if [ ! -d "${WORK_DIR}" ]
then
    mkdir -p "${WORK_DIR}"
fi
rm -rf "${WORK_DIR}/*"

cp ${RANDOM_DIR}/*.gif "${WORK_DIR}/"

select_site() {
    random_image=$(ls ${WORK_DIR}/*.gif | shuf -n 1)

    #mark animation
    mv "$random_image" "$random_image.selected"
    echo "$random_image.selected"
}

#Each animation is one side on the cube
animation1=$(select_site)
animation2=$(select_site)
animation3=$(select_site)
animation4=$(select_site)
animation5=$(select_site)


#merge to one animation
ffmpeg  -y -i $animation1 -i $animation2 -i $animation3 -i $animation4 -i $animation5 -filter_complex hstack=inputs=5 -color_range 8  "${HOME_BASE}/merged.gif"

#change sides
kill $(ps -aux | grep gif-viewer.py | awk '{print $2}')
nice python "${HOME_BASE}/gif-viewer.py" "${HOME_BASE}/merged.gif" 1> /dev/null 2> /dev/null &