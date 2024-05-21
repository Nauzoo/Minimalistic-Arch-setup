#!/bin/bash

#takes a screenshot and saves to clipboard
cpScr() {
    grim -t png - | wl-copy
}

cpAr() {
    grim -g "$(slurp)" - | wl-copy
}

#takes a screenshot of the full screen and saves it
svScr() {
    timestamp=$(date +%s)
    grim ~/Pictures/screenshots/"$timestamp".png
}

svAr() {
    timestamp=$(date +%s)
    grim -g "$(slurp)" ~/Pictures/screenshots/"$timestamp".png

}

#takes a screenshot of an area and opens in swappy edit
edAr() {
    grim -g "$(slurp)" - | swappy -f -
}


case "$1" in
    cpScr) cpScr;;
    cpAr) cpAr;;
    svScr) svScr;;
    svAr) svAr;;
    edAr) edAr;;
esac
