#!/bin/bash
# set the new version here
CUR=2018.1~ngly-234
BRANCH='nightly'
OUT_FILE=index.html
wget -k --no-check-certificate http://freifunk.in-kiel.de/firmware-rc.html -O $OUT_FILE
# replace the data from the template
sed -i 's|/sysupgrade/gluon-ffki-<VERSION>|/sysupgrade/gluon-ffki-'$CUR'|g' $OUT_FILE
sed -i 's|/factory/gluon-ffki-<VERSION>|/factory/gluon-ffki-'$CUR'|g' $OUT_FILE
sed -i 's|release-candidate|'$BRANCH'/'$CUR'|g' $OUT_FILE
echo -n "dead link check "
#sed -i "s/tube2/nixtube2/g" $OUT_FILE  # for debug to create a dead link
INVALID='">n/a </a><deadlink none="'
while IFS= read -r URL; do
  if wget --no-check-certificate --spider "$URL" 2>/dev/null; then
    echo -n .
  else
    echo
    echo "$URL does not exist"
    sed -i 's|'$URL'|'$URL''"$INVALID"'|g' $OUT_FILE
  fi
#done < <(grep -Po '(?<=href=")[^"]*' $OUT_FILE|grep gluon|grep alfa)  # for debug
done < <(grep -Po '(?<=href=")[^"]*' $OUT_FILE|grep gluon)
echo "dead link check done"
sed -i 's|http://|//|g' $OUT_FILE
