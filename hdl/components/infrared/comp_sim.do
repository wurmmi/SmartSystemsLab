#----------------------------------*-tcl-*-
do comp.do

echo "Sim: load design"
set unit tb_infrared
vsim -novopt -wlfdeleteonquit \
      work.${unit}(Bhv) \
      +nowarn3116

set tb    ${unit}
set dut   ${tb}/DUT

echo "Sim: load wave-file(s)"
catch {do wave.do}

echo "Sim: log signals"
log -r /*

echo "Sim: run ..."
run 75 us

catch {do wave-restore.do}
