package seqr_pac;
import uvm_pkg::*;
`include "uvm_macros.svh"
import sequence_item::*;
class sqr_class extends uvm_sequencer #(seq_item);
    `uvm_component_utils(sqr_class)

    function new(string name = "sqr_class" , uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass 
    
endpackage