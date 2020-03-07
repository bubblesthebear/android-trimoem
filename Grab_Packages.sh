#!/bin/bash

## Add logging!




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
            if [[ $(wc -l <$devicelist) -lt 1 ]]; then # No devices found either
                echo idk # Idk
            fi
        fi
        


    ## If the validip above stays then below is outdated.

    echo Listing devices...
    echo
    adb devices
    echo

    echo Grabbing IP Address
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

function adb_connect
{

    #
    ## Grab device list

    adb tcpip 5575
    sleep 4
    devicelist=$(adb devices)

    ## Check if any are non-wireless and target if not

    validip="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
        if [[ $devicelist =~ $validip ]]; then # IP Found

            noips=0;
            adbdevip=$(adb shell ip addr show wlan0 | grep -E -o -m1 "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" | head -1)

            adbdevid=$adbdevip:5575
            adb connect $adbdevid

        else # No IP

            noips=1;
            adbdevip=$(adb shell ip addr show wlan0 | grep -E -o -m1 "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" | head -1)

            adb tcpip 5575 # Is this relevant?

            if [[ $(wc -l <$devicelist) -lt 1 ]]; then # No devices found either
                echo No devices found.  Retry!
                read -rsp $'Press any key to exit...\n' -n1 key
                exit
            fi
        fi

    ## Either connect via IP or set up WiFi ADB and then connect over IP

    ## Done for prototype connect.




    echo 
    echo Connected?
    echo

}

function grab_packages_test
{

    #

    # Labels for package list files
    adbdevname2=$(adb -s $adbdevid shell getprop ro.product.model)
    textdate=$(date '+%d-%m-%Y %H-%M')
    textrandomnumber=$((1000 + RANDOM % 2000))
    textall="$textdate"" - ""$textrandomnumber"
    adbdevname="$adbdevname2"" - ""$textall"

        if [-z"$adbdevname"]; then # If device model is somehow empty, default to generic 'Android'.  Definitely better to use any of the other build/manufacturer props.
            adbdevname="Android"" - ""$textall"
            echo adbdevname; # Visible
        fi

    mkdir $HOME/Package_Lists/ # Just ignore error
    adb -s $adbdevid shell "pm list packages" > $HOME/Package_Lists/"$adbdevname".txt

    echo 
    echo Done!

}

function test_log #If anyone uses this code, delete this function to protect privacy
{

    #


    # # DEBUGGING # #
    # adbdevid=10.0.0.80:5575

    # Labels for package list files
    adbdevname2=$(adb -s $adbdevid shell getprop ro.product.model)
    textdate=$(date '+%d-%m-%Y %H_%M')
    textrandomnumber=$((1000 + RANDOM % 2000))
    textall="$textdate"" - ""$textrandomnumber"
    adbdevname="$adbdevname2"" _ ""$textall"

       ## if [-z"$adbdevname"]; then # If device model is somehow empty, default to generic 'Android'.  Definitely better to use any of the other build/manufacturer props.
       ##     adbdevname="Android"" - ""$textall"
       ##     echo adbdevname; # Visible
       ## fi

    #Logs.  Line1:  Product information, Line2:  Product Information, Line3:  Software Build Information, Line4:  Software Information

    prodModel=$(adb -s $adbdevid shell getprop ro.product.model)
    prodName=$(adb -s $adbdevid shell getprop ro.product.name)
    prodBrand=$(adb -s $adbdevid shell getprop ro.vendor.product.brand)
    prodManufa=$(adb -s $adbdevid shell getprop ro.vendor.product.manufacturer)

    prodCarrier=$(adb -s $adbdevid shell getprop ro.carrier)
    prodStorageSize=$(adb -s $adbdevid shell getprop ro.device.memory.internal)

    prodOS=$(adb -s $adbdevid shell getprop ro.build.version.release)
    prodAPISDK=$(adb -s $adbdevid shell getprop ro.build.version.sdk)
    prodSecurityPatches=$(adb -s $adbdevid shell getprop ro.build.version.security_patch)

    prodLanguage=$(adb -s $adbdevid shell getprop persist.sys.locale)
    prodHostname=$(adb -s $adbdevid shell getprop net.hostname)

    Line1="Model:  ""$prodModel""; Model Brand:  ""$prodBrand"
    Line2="Model Name:  ""$prodName"";  Model Manufacturer:  ""$prodManufa"
    Line3="Storage:  ""$prodStorageSize""GB;  Carrier:  ""$prodCarrier"
    Line4="OS:  ""$prodOS"";  OS API SDK:  ""$prodAPISDK"";  Security Patch:  ""$prodSecurityPatches"
    Line5="Hostname:  ""$prodHostname"";  Language:  ""$prodLanguage"

    mkdir $HOME/Package_Lists/Logs/ # Just ignore error
    lognameid="Log _ ""$prodModel"" _ ""$textall"

    echo "$Line1" > $HOME/Package_Lists/Logs/"$lognameid".txt
    echo "$Line2" >> $HOME/Package_Lists/Logs/"$lognameid".txt
    echo "$Line3" >> $HOME/Package_Lists/Logs/"$lognameid".txt
    echo "$Line4" >> $HOME/Package_Lists/Logs/"$lognameid".txt
    echo "$Line5" >> $HOME/Package_Lists/Logs/"$lognameid".txt

    echo 
    echo Log done!


}

function now_done
{

    #
    echo Done!

}

# start of script


        # # DEBUGGING # #
        # test_log
        # read -rsp $'Press any key to continue...\n' -n1 key
        # exit

        adb_connect
        read -rsp $'Press any key to continue...\n' -n1 key
        grab_packages_test
        read -rsp $'Press any key to continue...\n' -n1 key
        test_log
        read -rsp $'Press any key to continue...\n' -n1 key
        exit
