#! /bin/bash
DISK="/dev/sda"
FAN_DEVICE=/sys/class/thermal/cooling_device0/cur_state
LOOP_TIME=30
# disk temperature alert level
T_SHUTDOWN=65
T_HIGH=45
T_LOW=40
# command
LOG=/usr/bin/logger

funExec(){
# Detect CPU temperature
CPU_TEMP=$(sensors | grep temp | awk '{print $2}')
CPU_TEMP=${CPU_TEMP:1:2}
# Detect disk standby status
DISK_STATUS=$(hdparm -C $DISK | grep 'drive state' | awk '{print $4}' | tr [a-z] [A-Z] )
# Detect fan status
FAN_STATUS=$(cat $FAN_DEVICE)

echo $(date) CPU temperature:$CPU_TEMP, Disk Status:$DISK_STATUS, Fan:$FAN_STATUS 

# shutdown if temperature is too high
if [ $CPU_TEMP -ge $T_SHUTDOWN ]
then
  $LOG "$DISK temperature $CPU_TEMP°C crossed its limit, will shutdown"
  #echo shutdown
  sync;sync
  shutdown -h now
  return
fi

# cross temperature limit, open fan
if [ $CPU_TEMP -ge $T_HIGH ]
then
  if [ $FAN_STATUS -eq 0 ]
  then 
    $LOG "CPU temperature $CPU_TEMP°C crossed its limit, will open fan"
    #echo open fan
    echo 1 > $FAN_DEVICE
  fi
  #echo "turn on red LED"
  echo 255 > /sys/class/leds/red/brightness
  return
fi

if [ $CPU_TEMP -le $T_LOW -a $FAN_STATUS -eq 1 ]
then
  $LOG "$DISK temperature $CPU_TEMP°C back to normal"
  if [ $FAN_STATUS -eq 1 ]
  then 
    #echo close fan
    echo 0 > $FAN_DEVICE
  fi
  #echo "turn off red led"
  echo 0 > /sys/class/leds/red/brightness
fi

if [ $DISK_STATUS = "STANDBY" -o $DISK_STATUS = "SLEEP" ]
then
  #echo "LED -> blink green"
  echo 2 > /sys/class/leds/green/blink
else
  #echo "LED -> green"
  echo 255 > /sys/class/leds/green/brightness
fi
} #end function

while true
do
  funExec
  # wait N seconds
  sleep $LOOP_TIME 
done

