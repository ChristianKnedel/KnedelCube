#!/bin/bash
CLASSIFY=0
START_PAGE=0
END_PAGE=500
while getopts c:s:e: flag
do
    case "${flag}" in
        c) CLASSIFY=${OPTARG};;
        s) START_PAGE=${OPTARG};;
        e) END_PAGE=${OPTARG};;
    esac
done

for i in {${START_PAGE}..${END_PAGE}}
do
    PAGE=$(expr $i \* 18)

    START=$(expr $PAGE + 1 )
    END=$(expr $START + 17)
    echo "Welcome $START -  $END times"
   
    curl --referer https://pixel.divoom-gz.com/ -X POST https://app.divoom-gz.com/Cloud/GetCategoryDataList -d "{\"RefreshIndex\":0,\"FileSize\":1,\"FileSort\":1,\"Version\":7,\"Classify\":${CLASSIFY},\"StartNum\":${START},\"EndNum\":${END},\"FileType\":101}" > current_page.json
    sleep 2

    while read file
    do
      FILE=$(echo "$file" | jq -r .FileId)
      NAME=$(echo "$file" | jq -r .FileName)

      SLUG=$(echo "$NAME" | iconv -t ascii//TRANSLIT | sed -r s/[~\^]+//g | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)



      if [ -f "downloads/${SLUG}.data.gif" ]; then
          echo "$SLUG exists."
      else 
          echo "$SLUG does not exist."
          echo "Download https://f.divoom-gz.com/${FILE}"
          curl "https://f.divoom-gz.com/${FILE}" > "downloads/${SLUG}.data"
          python3 decode.py "downloads/${SLUG}.data"
          rm "downloads/${SLUG}.data"
          sleep 2
      fi

      sleep 1
    done < <(cat current_page.json | jq -c '.FileList[]')
done

