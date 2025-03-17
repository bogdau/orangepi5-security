#!/bin/bash

# Source the config that only has the hash
EXPECTED_HASH=$(cat /etc/chip_serial.conf)
CURRENT_HASH=$(cat_serial.sh | awk '{print $3}' | sha256sum )
if [ "$CURRENT_HASH" = "$EXPECTED_HASH" ]; then
  logger "[check-serial] Serial match!"
  echo -e "Serial  match"
else
  logger "[check-serial] Serial mismatch!"
  echo -e "Serial mismatch"
  exit 1
fi