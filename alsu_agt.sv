package alsu_agtt;
    import uvm_pkg::*;
    import drive::*;
    import seqr_pac::*;
    import alsuu_monitor::*;
    import cfg::*;
    import sequence_item::*;
    `include "uvm_macros.svh"
    class alsu_agt extends uvm_agent;
        `uvm_component_utils(alsu_agt)
        alsu_driver driver;
        alsu_monitor monitor;
        alsu_confg cfg;
        sqr_class sqr;
        uvm_analysis_port #(seq_item) agt_ap;
        function new(string name="alsu_agt", uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            driver = alsu_driver::type_id::create("driver",this);
            sqr = sqr_class::type_id::create("sqr",this);
            monitor = alsu_monitor::type_id::create("mon",this);
        if(!uvm_config_db #(alsu_confg) :: get(this,"","CFG",cfg))
        `uvm_fatal("build_phase","no");
        agt_ap = new("agt_ap",this);
        endfunction
        function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        driver.alsu_test_vif=cfg.alsu_test_vif;
        monitor.alsu_test_vif=cfg.alsu_test_vif;
        driver.seq_item_port.connect(sqr.seq_item_export);
        monitor.mon_ap.connect(agt_ap);
    endfunction 
    endclass //className extends superClass
endpackage