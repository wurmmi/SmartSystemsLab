
#----------------------------------*-tcl-*-

#-------------------------------------------
proc myvcom {filename} {
  if {[file exists ${filename}] == 1} {
    puts "## vcom $filename"
    vcom -93 -novopt -quiet ${filename} -work work
  } else {
    puts "## WARNING: File not found: ${filename}"
  }
}

#-------------------------------------------
vlib work
myvcom counter.vhd
myvcom sync.vhd
myvcom sync_single.vhd
myvcom infrared.vhd
myvcom tb_infrared.vhd
