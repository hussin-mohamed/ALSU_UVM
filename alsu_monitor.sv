package alsuu_monitor;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item::*;
    class alsu_monitor extends uvm_monitor;
        `uvm_component_utils(alsu_monitor)
        seq_item item;
        virtual alsu_inter alsu_test_vif;
        uvm_analysis_port #(seq_item) mon_ap;
        function new(string name = "alsu_monitor",uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase (uvm_phase phase);
            super.build_phase(phase);
            mon_ap=new("mon_ap",this);
        endfunction 
        task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            item = seq_item::type_id::create("item");
            @(negedge alsu_test_vif.clk);
            item.rst=alsu_test_vif.rst; 
            item.cin=alsu_test_vif.cin;
            item.red_op_A=alsu_test_vif.red_op_A;
            item.red_op_B=alsu_test_vif.red_op_B;
            item.bypass_A=alsu_test_vif.bypass_A;
            item.bypass_B=alsu_test_vif.bypass_B;
            item.direction=alsu_test_vif.direction;
            item.serial_in=alsu_test_vif.serial_in;
            // item.opcode=alsu_test_vif.opcode;
            // item.op2=alsu_test_vif.opcode;
            item.A=alsu_test_vif.A;
            item.B=alsu_test_vif.B;
            item.leds=alsu_test_vif.leds;
            item.out=alsu_test_vif.out;
            mon_ap.write(item);
        end
    endtask //
    endclass //className extends superClass
endpackage