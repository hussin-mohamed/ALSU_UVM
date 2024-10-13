package cfg;
import uvm_pkg::*;
`include "uvm_macros.svh"
class alsu_confg extends uvm_object;
    `uvm_object_utils(alsu_confg)
        virtual alsu_inter alsu_test_vif;
        function new(string name = "alsu_confg" );
        super.new(name);
        endfunction
endclass //className extends superClass
endpackage