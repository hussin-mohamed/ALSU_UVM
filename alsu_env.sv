package env_pac;
import uvm_pkg::*;
import alsu_agtt::*;
import coverage_pkg::*;
import scoreborad_pck::*;
`include "uvm_macros.svh"

class alsu_env extends uvm_env;
    `uvm_component_utils(alsu_env)
    alsu_agt agt;
    alsu_scoreborad sb;
    alsu_cover cov;
    function new(string name = "alsu_env" , uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        agt = alsu_agt::type_id::create("agt",this);
        sb = alsu_scoreborad::type_id::create("sb",this);
        cov = alsu_cover::type_id::create("cov",this);
    endfunction 
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        agt.agt_ap.connect(sb.sb_export);
        agt.agt_ap.connect(cov.cov_export);
    endfunction 
endclass 
    
endpackage