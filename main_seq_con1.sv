package main_sequence_con1;
import sequence_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class main_seq_con1 extends uvm_sequence#(seq_item);
    `uvm_object_utils(main_seq_con1)
    seq_item item;
    parameter testcases = 20000;
    function new(string name = "main_seq_con1");
        super.new(name);
    endfunction //new()
    task body();
        repeat(testcases)
        begin
        item = seq_item::type_id::create("item");
        item.con1.constraint_mode(1);
        item.con2.constraint_mode(0);
        start_item(item);
        assert(item.randomize());
        finish_item(item);
        end
        //
        item = seq_item::type_id::create("item");
        item.con1.constraint_mode(1);
        item.con2.constraint_mode(0);
        start_item(item);
        item.opcode=item.OR;
        item.rst=0; 
        item.cin=0;
        item.red_op_A=1;
        item.red_op_B=1;
        item.bypass_A=0;
        item.bypass_B=0;
        item.direction=0;
        item.serial_in=0;
        item.A=5;
        item.B=7;
        finish_item(item);
        //
        item = seq_item::type_id::create("item");
        item.con1.constraint_mode(1);
        item.con2.constraint_mode(0);
        start_item(item);
        item.opcode=item.OR;
        item.rst=0; 
        item.cin=0;
        item.red_op_A=1;
        item.red_op_B=0;
        item.bypass_A=0;
        item.bypass_B=0;
        item.direction=0;
        item.serial_in=0;
        item.A=5;
        item.B=7;
        finish_item(item);
        //
        item = seq_item::type_id::create("item");
        item.con1.constraint_mode(1);
        item.con2.constraint_mode(0);
        start_item(item);
        item.opcode=item.OR;
        item.rst=0; 
        item.cin=0;
        item.red_op_A=0;
        item.red_op_B=1;
        item.bypass_A=0;
        item.bypass_B=0;
        item.direction=0;
        item.serial_in=0;
        item.A=5;
        item.B=7;
        finish_item(item);
    endtask 
endclass //main_seq extends uvm_sequence
endpackage