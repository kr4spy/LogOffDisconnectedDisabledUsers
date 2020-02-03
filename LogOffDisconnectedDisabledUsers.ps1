#########################################################
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
$Users = $Users | ForEach-Object {    (($_.trim() -replace ">" -replace "(?m)^([A-Za-z0-9]{3,})\s+(\d{1,2}\s+\w+)", '$1  none  $2' -replace "\s{2,}", "," -replace "none", $null))} | ConvertFrom-Csv
foreach ($User in $Users){             if($User.ID.Trim() -eq "Disc") {          $text = "$($user.USERNAME) is currently disconnected with the session ID of $($User.SESSIONNAME)"                             write-host $text        $log = "$(Get-Date -format MM/dd/yyyy_HH:mm:ss) - $text"        $log | out-file $outfile -Append -Encoding ascii                        $enabled = wmic useraccount where name="'$($User.USERNAME)'" get Disabled        $log = "$(Get-Date -format MM/dd/yyyy_HH:mm:ss) - $($User.USERNAME) disabled status is: $($enabled[2])"        $log | out-file $outfile -Append -Encoding ascii        if ($enabled[2].Trim() -ne "FALSE") {            logoff $($User.ID)            $text = "$($User.USERNAME) has been logged off because they are disabled"            write-host $text            $log = "$(Get-Date -format MM/dd/yyyy_HH:mm:ss) - $text"            $log | out-file $outfile -Append -Encoding ascii        }            }    else {        $text = "$($user.USERNAME) is currently active with the session ID of $($User.SESSIONNAME)"        write-host $text        $log = "$(Get-Date -format MM/dd/yyyy_HH:mm:ss) - $text"        $log | out-file $outfile -Append -Encoding ascii    }}