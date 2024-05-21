#!/bin/bash

#AUTHOR: ABDELRHMAN NILE (PIRATE)
#EDITED BY Nauzoo
#github: https://github.com/AbdelrhmanNile
#github: https://github.com/Nauzoo

# this script WILL NOT WORK if you don't have feh and rofi, please install them first
#
dir=~/Pictures/wallpapers/ # wallpapers folder, change it to yours, make sure that it ends with a /
cd $dir
wallpaper="none is selected"
view="feh"

#change this to whatever config file
# that sets your wallpaper on startup, this file will get modified
# if you choose to set a wallpaper permanantly
startup_config_file=~/.config/hypr/hyprpaper.conf

# config files for software you want to affect the color palette
cava_conf=~/.config/cava/config
cava_temp=~/.config/cava/template       #template = config - color option
locker_conf=~/.config/swaylock/config
locker_temp=~/.config/swaylock/template

####################-FUNCTION FOR SELECTING A WALLPAPER-##################
selectpic(){
    wallpaper=$(ls $dir | rofi -show combi -combi-modes "filebrowser" -dmenu -p"select a wallpaper: ($wallpaper)")

    if [[ $wallpaper == "q" || $wallpaper == "" ]]; then
        killall feh && exit
    else
        set_permanant
    fi
}
##########################################################################

########-FUNCTION FOR TAKING AN ACTION ON THE SELECTED WALLPAPER-#########
action(){
  whattodo=$(echo -e "view\nset\nset (permanant)" | rofi -dmenu -p "whatcha wanna do with it? ($wallpaper)")
    if [[ $whattodo == "set" ]]; then
        set_wall
    elif [[ $whattodo == "set (permanant)" ]]; then
      set_permanant
    else
        view_wall
    fi
}
##########################################################################

###############-FUNCTION TO SET THE SELECTED WALLPAPER-###################
set_wall(){

    update_firefox

    killall rofi
    killall waybar
    swww img --transition-type grow --transition-step 120 $dir$wallpaper
    sleep 2
    wal -i $dir$wallpaper -q

    source ~/.cache/wal/colors.sh

    update_cava

    update_swaylock

    exec waybar
}
##########################################################################

####################-FUNCTION TO VIEW THE WALLPAPER-######################
view_wall(){
    $view $wallpaper &
    set_after_view
}

##########################################################################

########-FUNCTION TO PROMPT THE USER AFTER VIEWING THE WALLPAPER-#########
set_after_view(){
  setorno=$(echo -e "set (permanant)\ngo back" | rofi -dmenu -p "wanna set it? ($wallpaper)")

  if [[ $setorno == "set (permanant)" ]]; then
      set_permanant
    else
      killall feh && wch
    fi
}
##########################################################################

##-FUNCTION TO SET THE WALLPAPER permanantly,
## IT WILL MODIFY YOUR START UP CONFIG FILE-###

set_permanant(){
  sed -i '/^/d' $startup_config_file
  echo "preload=$dir$wallpaper" >> $startup_config_file
  echo "wallpaper=monitor1,$dir$wallpaper" >> $startup_config_file
  echo "slpash=true" >> $startup_config_file

  set_wall
}

##########################################################################

#######################-UPDATE COLORSCHEMES-##############################
update_cava(){  # copies the template to the config file and set the color parameters
    sed -i '/^/d' $cava_conf
    cp -v $cava_temp $cava_conf
    echo "gradient_color_1 = '$color12'" >> $cava_conf
    echo "gradient_color_2 = '$color8'" >> $cava_conf
}

update_swaylock() {
    sed -i '/^/d' $locker_conf
    cp -v $locker_temp $locker_conf
    echo "ring-color=$color12" >> $locker_conf
    echo "key-hl-color=$foreground" >> $locker_conf
    echo "line-color=$background" >> $locker_conf
    echo "inside-color=$background" >> $locker_conf
    echo "separator-color=$foreground" >> $locker_confi
    echo "ring-ver-color=$color12" >> $locker_conf
    echo "ring-clear-color=$color12" >> $locker_conf
    echo "ring-wrong-color=$color12" >> $locker_conf
    echo "inside-ver-color=$background" >> $locker_conf
    echo "inside-clear-color=$background" >> $locker_conf
    echo "inside-wrong-color=$background" >> $locker_conf

    echo "text-ver-color=$color12" >> $locker_conf
    echo "text-clear-color=$color12" >> $locker_conf
    echo "text-wrong-color=$color12" >> $locker_conf
}

update_firefox(){
    cp -r $wallpaper ~/Pictures/wallpapers/currentWall/$wallpaper
    cp -r $wallpaper ~/.mozilla/firefox/3asdlmcy.Nauzoo/chrome/wallpaper.jpg
    cd ~/Pictures/wallpapers/currentWall/
    mv $wallpaper "w.jpg" -f
}


#################################-MAIN-###################################
selectpic

