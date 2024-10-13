package main_sequence_con2;
import sequence_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class main_seq_con2 extends uvm_sequence#(seq_item);
    `uvm_object_utils(main_seq_con2)
    seq_item item;
    parameter testcases = 20000;
    function new(string name = "main_seq_con2");
        super.new(name);
    endfunction //new()
    task body();
        repeat(testcases*6)
        begin
        item = seq_item::type_id::create("item");
        item.con1.constraint_mode(0);
        item.con2.constraint_mode(1);
        start_item(item);
        assert(item.randomize());
        finish_item(item);
        end
    endtask 
endclass //main_seq extends uvm_sequence
endpackage