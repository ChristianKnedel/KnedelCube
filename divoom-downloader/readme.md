
# Divoom-Downloader
The “divoom-downloader” can be used to download animated images from https://pixel.divoom-gz.com/.

## Install "divoom-downloader"

### build
```
$ docker build -t divoom-downloader .
```

### Downloader
```
docker run -it -v $(pwd)/test:/code/downloads  divoom-downloader -c 17 -s 0 -e 500
```

#### Downloader command options

The emerge command has some USE flag related options like: 
* -c category, eg. 17 for Festival 
* -s Start Page 
* -e End Page 


#### Categories
| category | Classify (ID) |
| ------ | ------ |
| NEW | 0 |
| Recommend | 18 |
| Annual | 14 |
| Character | 3 |
| Festival | 17 |
| Emoji | 4 |
| Pattern | 8 |
| Creative | 9 |
| Nature | 6 |
| Daily | 5 |
| Gadget | 15 |
| Icon | 7 |
| Business | 16 |
| Default | 1 |
| Photo | 12 |


## Sort By Frames
With this script you can sort the animation by frames
```
#!/bin/bash
for IMAGE in $(find download/ -name \*.gif); do # Not recommended, will break on whitespace

    #FRAMES=$(identify -format "%n\n" ${IMAGE} | head -1)
    FRAMES=$(exiftool -b -FrameCount ${IMAGE})

    DIRECTORY="sorted/${FRAMES}/"
    FILENAME=$(basename "${IMAGE}")
    if [ ! -d "${DIRECTORY}" ] 
    then
        mkdir -p "${DIRECTORY}"
    fi
    echo "process ${IMAGE}"
    #convert ${IMAGE} -coalesce -resize 64x -deconstruct "${DIRECTORY}/${FILENAME}"
    gifsicle --colors=16 --lossy=100 --background "#000000" --resize 64x64 --colors 24 ${IMAGE} > "${DIRECTORY}/${FILENAME}"
done
```