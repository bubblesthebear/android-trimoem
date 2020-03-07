#!/bin/bash

## Add logging!

# function grab_packages
# {

    #

# }

# function register_wifi_adb
# {

    #

# }

function test_log #If anyone uses this code, delete this function to protect privacy
{

    #
    ## ro.build.version.sdk
    ## ro.build.version.release
    ## ro.build.version.security_patch
    ## ro.vendor.product.brand
    ## ro.vendor.product.manufacturer
    ## ro.vendor.product.model
    ## ro.vendor.product.name
    ## ro.model.name
    ## persist.sys.locale
    ## persist.service.storage.low
    ## net.hostname
    ## ro.carrier

    #
    adbdevname2=$(adb -s $adbdevid shell getprop ro.product.model)
    textdate=$(date '+%d-%m-%Y %H-%M')
    textrandomnumber=$((1000 + RANDOM % 2000))
    textall="$textdate"" - ""$textrandomnumber"
    adbdevname="$adbdevname2"" - ""$textall"
        if [-z "$adbdevname"]; then
            adbdevname="Android"" - ""$textall"
            echo adbdevname;
        fi
    mkdir $HOME/Package_Lists/
    adb -s $adbdevid shell "pm list packages" > $HOME/Package_Lists/$adbdevname.txt
    ## adb -s $adbdevid shell "dumpsys activity services | grep -v "com.google.*" | grep -v "com.android.bluetooth" | grep 'ConnectionRecord{'"
        ## You could grab the list off running services too and grep against bad services.
    # only use the first exec mkdir $HOME/Package_Lists/
    ## adb -s $adbdevid pull -p -a "/sdcard/Tech_Temp1/" "$HOME/Package_Lists/"
    echo 
    echo Done!


}

function test_adb
{

    #
    # First check if there is already an IP connected, second if nothing is connected then ask if there is an IP known, third if no IP is known and no devices then error.

    # Check if there is already an IP connected.
    validip="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
    devicelist=$(adb devices)
        if [[ $devicelist =~ $validip ]]; then # IP Found
            noips=0;
        else # No IP
            noips=1;
            if [[ $(wc -l <$devicelist) -lt 1 ]] then # No devices found either
                # Idk
            fi
        fi
        


    ## If the validip above stays then below is outdated.

    echo Listing devices...
    echo
    adb devices
    echo

    echo Reading IP Address
    echo
    adbdevip=$(adb shell ip addr show wlan0 | grep -E -o -m1 "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" | head -1) # Runs command to show device's WiFi configuration, then uses grep to narrow down only what matches IP addresses visually, then uses 'head -1' to lower it further to the very first match, as two IP addresses are actually on the same output line and so both will be displayed otherwise.

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
    adbdevname2=$(adb -s $adbdevid shell getprop ro.product.model)
    textdate=$(date '+%d-%m-%Y %H-%M')
    textrandomnumber=$((1000 + RANDOM % 2000))
    textall="$textdate"" - ""$textrandomnumber"
    adbdevname="$adbdevname2"" - ""$textall"

        if [-z"$adbdevname"]; then
            adbdevname="Android"" - ""$textall"
            echo adbdevname;
        fi

    mkdir $HOME/Package_Lists/
    adb -s $adbdevid shell "pm list packages" > $HOME/Package_Lists/"$adbdevname".txt
    ## adb -s $adbdevid shell "dumpsys activity services | grep -v "com.google.*" | grep -v "com.android.bluetooth" | grep 'ConnectionRecord{'"
        ## You could grab the list off running services too and grep against bad services.
    # only use the first exec mkdir $HOME/Package_Lists/
    ## adb -s $adbdevid pull -p -a "/sdcard/Tech_Temp1/" "$HOME/Package_Lists/"

    echo 
    echo Done!

}

function now_done
{

    #
    echo Done!

}

# start of script

test_adb
read -rsp $'Press any key to continue...\n' -n1 key
grab_packages_test
read -rsp $'Press any key to continue...\n' -n1 key
exit
