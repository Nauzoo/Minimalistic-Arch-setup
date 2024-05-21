#!/bin/bash

######################
#  WAYBAR RESTARTER  #
######################

killall waybar

exec waybar
