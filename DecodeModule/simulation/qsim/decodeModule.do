onerror {exit -code 1}
vlib work
vlog -work work decodeModule.vo
vlog -work work Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.decodeModule_vlg_vec_tst -voptargs="+acc"
vcd file -direction decodeModule.msim.vcd
vcd add -internal decodeModule_vlg_vec_tst/*
vcd add -internal decodeModule_vlg_vec_tst/i1/*
run -all
quit -f
