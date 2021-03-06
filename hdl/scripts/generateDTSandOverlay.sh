#!/usr/bin/env bash

set -euo pipefail

echo "----------------- Entered file $0 ---------------------------------------------------"
source ./defineFilenames.sh

sopc2dts -v --input ../HPSPlatform.sopcinfo --output $OUTPUT_DTS --type dts --board ./input/soc_system_board_info.xml --board ./input/hps_common_board_info.xml --bridge-removal all --bridge-ranges bridge --clocks

# generate dtso from dts
echo "Before adapt"
./adaptDTS.sh


# sopc2dts --input ../HPSPlatform.sopcinfo\
#   --output socfpga.dtso\
#   --type dts\
#   --bridge-removal all\
#   --bridge-ranges bridge\
#   --clocks\
#   --pov-type overlay\
#   --pov hps_0_bridges\
#
# sopc2dts --input ../HPSPlatform.sopcinfo\
#   --output socfpga.dts\
#   --type dts\
#   --board soc_system_board_info.xml\
#   --board hps_common_board_info.xml\
#   --bridge-removal all\
#   --clocks

echo "----------------- Leaving file $0 ---------------------------------------------------"
