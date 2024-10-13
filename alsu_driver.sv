package drive;
    import uvm_pkg::*;
    import cfg::*;
    import sequence_item::*;
    `include "uvm_macros.svh"
    class alsu_driver extends uvm_driver#(seq_item);
    `uvm_component_utils(alsu_driver)
    seq_item item;
    virtual alsu_inter alsu_test_vif;
        function new(string name="alsu_driver",uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase (uvm_phase phase);
        super.build_phase(phase);
    endfunction 
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
               
            forever begin
                item = seq_item::type_id::create("item");
                seq_item_port.get_next_item(item);
                alsu_test_vif.rst=item.rst;
                alsu_test_vif.cin=item.cin;
                alsu_test_vif.red_op_A=item.red_op_A;
                alsu_test_vif.red_op_B=item.red_op_B;
                alsu_test_vif.bypass_A=item.bypass_A;
                alsu_test_vif.bypass_B=item.bypass_B;
                alsu_test_vif.direction=item.direction;
                alsu_test_vif.serial_in=item.serial_in;
                alsu_test_vif.opcode=item.opcode|item.op2;
                alsu_test_vif.A=item.A;
                alsu_test_vif.B=item.B;
                @(negedge alsu_test_vif.clk);
                seq_item_port.item_done();
            end
        endtask //run_phase
    endclass //className extends superClass
endpackage