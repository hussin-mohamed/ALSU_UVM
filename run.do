vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
add wave -position insertpoint sim:/top/alsu_test_vif/*
coverage save ALSU_tb.ucdb -onexit
run -all
#vcover report ALSU_tb.ucdb -details -all -output coverage_rpt_ALSU.txt