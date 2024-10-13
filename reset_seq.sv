package reset_sequence;
import sequence_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class reset_seq extends uvm_sequence#(seq_item);
    `uvm_object_utils(reset_seq)
    seq_item item;
    function new(string name = "reset_seq");
        super.new(name);
    endfunction //new()
    task body();
        item = seq_item::type_id::create("item");
        start_item(item);
        item.rst=1;
        item.cin=0;
        item.red_op_A=0;
        item.red_op_B=0;
        item.bypass_A=0;
        item.bypass_B=0;
        item.direction=0;
        item.serial_in=0;
        item.opcode=item.OR;
        item.op2=item.OR;
        item.A=0;
        item.B=0;
        finish_item(item);
    endtask 
endclass //main_seq extends uvm_sequence
endpackage