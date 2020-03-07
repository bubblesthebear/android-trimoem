#!/bin/bash

# function grab_packages
# {

    #

# }

# function register_wifi_adb
# {

    #

# }

# function test_wifi_adb
# {

    # Test the script
  #  echo Which device is it?
  #  read adbdevid
  #  adb tcpip 5575
  #  adb connect $adbdevid:5575

# }

function test_adb
{

    # Test the script
    echo Listing devices...
    echo
    adb devices
    echo 
    echo Reading IP Address
    echo
    # Runs command to show device's WiFi configuration, then uses grep to narrow down only what matches IP addresses visually, then uses 'head -1' to lower it further to the very first match, as two IP addresses are actually on the same output line and so both will be displayed otherwise.
    adbdevip=$(adb shell ip addr show wlan0 | grep -E -o -m1 "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" | head -1)
    adb tcpip 5575
    sleep 4 # Otherwise it will say "5575:5575" as an error
    echo 
    echo Device IP is $adbdevip
    #echo What is the device IP?
    #read adbdevidip
    adbdevid=$adbdevip:5575
    echo 
    echo Connecting to $adbdevid
    echo 
    adb connect $adbdevid

}

function grab_packages_test
{

    #
    adbdevname=$(adb -s $adbdevid shell getprop ro.product.model)
        if [-z "$adbdevname"]; then
            echo adbdevname;
        fi
    mkdir $HOME/Package_Lists/
    # adb -s $adbdevid shell cd sdcard
    ## adb -s $adbdevid shell mkdir -m 777 /sdcard/Tech_Temp1
    ## adb -s $adbdevid shell "pm list packages" > /sdcard/Tech_Temp1/$adbdevname.txt"
    adb -s $adbdevid shell "pm list packages" > $HOME/Package_Lists/$adbdevname.txt
    # only use the first exec mkdir $HOME/Package_Lists/
    ## adb -s $adbdevid pull -p -a "/sdcard/Tech_Temp1/" "$HOME/Package_Lists/"
    echo 
    echo Done!

}

function now_done
{

    #
    

}

# start of script

test_adb
read -rsp $'Press any key to continue...\n' -n1 key
grab_packages_test
read -rsp $'Press any key to continue...\n' -n1 key
exit
