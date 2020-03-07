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
    echo Which device is it?
    read adbdevid
    echo $adbdevid
    adb tcpip 5575
    adb connect $adbdevid:5575
    adb shell "echo hello"

}

test_adb
exit
