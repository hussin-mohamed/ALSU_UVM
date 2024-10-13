package alsu_test_pkg;
import env_pac::*;
import uvm_pkg::*;
import reset_sequence ::*;
import main_sequence_con1::*;
import main_sequence_con2::*;
import cfg::*;
`include "uvm_macros.svh"
class alsu_test extends uvm_test;
    `uvm_component_utils(alsu_test)
    alsu_confg cfgg;
    alsu_env env;
    reset_seq reset_seqq;
    main_seq_con1 main_seq1;
    main_seq_con2 main_seq2;
    function new(string name = "alsu_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        env = alsu_env::type_id::create("env",this);
        cfgg = alsu_confg::type_id::create("cfgg",this);
        reset_seqq = reset_seq::type_id::create("reset_seq",this);
        main_seq1 = main_seq_con1::type_id::create("main_seq1",this);
        main_seq2 = main_seq_con2::type_id::create("main_seq2",this);
        if(!uvm_config_db#(virtual alsu_inter)::get(this,"","alsu_test_vif",cfgg.alsu_test_vif))
        `uvm_fatal("build_phase","a333333333");
        uvm_config_db#(alsu_confg)::set(null,"*","CFG",cfgg);
    endfunction 

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        `uvm_info("run_phase", "reset asserted",UVM_MEDIUM)
        reset_seqq.start(env.agt.sqr);
        `uvm_info("run_phase", "reset desserted",UVM_MEDIUM)

        `uvm_info("run_phase", "main started with con1",UVM_MEDIUM)
        main_seq1.start(env.agt.sqr);
        `uvm_info("run_phase", "main with con1 finished",UVM_MEDIUM)

        `uvm_info("run_phase", "main started with con2",UVM_MEDIUM)
        main_seq2.start(env.agt.sqr);
        `uvm_info("run_phase", "main with con2 finished",UVM_MEDIUM)

        `uvm_info("run_phase", "reset asserted",UVM_MEDIUM)
        reset_seqq.start(env.agt.sqr);
        `uvm_info("run_phase", "reset desserted",UVM_MEDIUM)

        `uvm_info("run_phase", "finished",UVM_MEDIUM)
        
        
        `uvm_info("run_phase", $sformatf("correct_count=%0d , wrong_count = %0d",env.sb.correct_count,env.sb.wrong_count),UVM_MEDIUM)

        phase.drop_objection(this);
    endtask
    

endclass 

endpackage