import alsu_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top ();
    bit clk ;
    initial begin
        forever begin
            #10;
            clk=!clk;
        end
    end
    alsu_inter alsu_test_vif(clk);
    ALSU dut (alsu_test_vif.A, alsu_test_vif.B, alsu_test_vif.cin, alsu_test_vif.serial_in, alsu_test_vif.red_op_A, alsu_test_vif.red_op_B, alsu_test_vif.opcode, alsu_test_vif.bypass_A, alsu_test_vif.bypass_B, alsu_test_vif.clk, alsu_test_vif.rst, alsu_test_vif.direction, alsu_test_vif.leds, alsu_test_vif.out);
    bind ALSU sva sva_inst(alsu_test_vif.A, alsu_test_vif.B, alsu_test_vif.cin, alsu_test_vif.serial_in, alsu_test_vif.red_op_A, alsu_test_vif.red_op_B, alsu_test_vif.opcode, alsu_test_vif.bypass_A, alsu_test_vif.bypass_B, alsu_test_vif.clk, alsu_test_vif.rst, alsu_test_vif.direction, alsu_test_vif.leds, alsu_test_vif.out);
    initial begin
    uvm_config_db#(virtual alsu_inter)::set(null,"*","alsu_test_vif",alsu_test_vif);
    run_test("alsu_test");
    end

endmodule