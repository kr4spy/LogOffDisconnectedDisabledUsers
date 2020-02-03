﻿#########################################################
# Script:  LogOffDisconnectedDisabledusers              #
#                                                       #
# Purpose: Log off users that are disconnected          #
#          and are also disabled.                       #
# Note:    The suggested mechanism to deal              #
#          with this is to use group policy:            #
#          "Set time limit for disconnected sessions."  #
#                                                       #
# Created: Matt Starr (@Kr4spy)                         #
#                                                       #
#                                                       #
# Special thanks to omniomi as this was adapted         #
# from https://tinyurl.com/qooxnol                      #
#########################################################

#Log
$log = ''

#Out-File
$outfile = 'c:\temp\LoggedOffDisconnectedDisabledUsers.txt'
$count = 1

$Users = query user 2>&1
$Users = $Users | ForEach-Object {
foreach ($User in $Users)