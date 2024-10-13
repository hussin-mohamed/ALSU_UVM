package scoreborad_pck;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item::*;
class  alsu_scoreborad extends uvm_scoreboard;
`uvm_component_utils(alsu_scoreborad)

uvm_analysis_export #(seq_item) sb_export;
uvm_tlm_analysis_fifo #(seq_item) sb_fifo;
seq_item item;
static int correct_count =0;
static int wrong_count =0;
logic red_op_A_reg,red_op_B_reg,bypass_A_reg,bypass_B_reg,direction_reg,serial_in_reg;
logic signed [1:0] cin_reg;
logic [2:0]opcode_reg;
logic signed [2:0]A_reg , B_reg;
logic signed [5:0] out_exp;
logic [15:0] leds_exp;
    function new(string name = "alsu_scoreborad" , uvm_component parent = null);
        super.new(name,parent);
    endfunction
    
      function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        sb_export=new("sb_export",this);
        sb_fifo=new("sb_fifo",this);
    endfunction 

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        sb_export.connect(sb_fifo.analysis_export);
    endfunction 
     task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
        sb_fifo.get(item);
        if(item.rst) begin
        check_rst();
        reset_internals();    
        end
        else begin
        golden_model();
        check_results();    
        end
        end
    endtask //

    task  check_rst();
        if(item.out!=0 && item.leds!=0)begin
            wrong_count=wrong_count+1;
            `uvm_info("score_board", "error in reset",UVM_MEDIUM)
        end
        else 
            correct_count++;
            reset_internals();
    endtask //

    task  reset_internals();
        {red_op_A_reg,red_op_B_reg,bypass_A_reg,bypass_B_reg,direction_reg,serial_in_reg}=6'b000000;
        opcode_reg=3'b000;
        cin_reg=2'b00;
        {A_reg,B_reg}=6'b000000;
    endtask //

    task  check_results();
        if (item.out==out_exp && item.leds==leds_exp) 
            correct_count++;
        else begin
            wrong_count++;
            `uvm_info("score_board", "error",UVM_MEDIUM)
        end
    endtask //

    function bit invalid();
        if(opcode_reg==item.INVALID6 || opcode_reg==item.INVALID7)
        return 1;
        else if (opcode_reg>3'b001 && (red_op_A_reg||red_op_B_reg))
        return 1;
        else 
        return 0;
    endfunction

    task  golden_model();
        if(invalid())
        leds_exp=~leds_exp;
        else
        leds_exp=0;

        
        if (bypass_A_reg)
        out_exp=A_reg;
        else if(bypass_B_reg)
        out_exp=B_reg;
        else if(invalid())
        out_exp=0;
        else begin
            if(opcode_reg==item.OR)
            begin
                if (red_op_A_reg) 
                    out_exp=|A_reg;
                else if(red_op_B_reg)
                    out_exp=|B_reg;
                else
                    out_exp=A_reg|B_reg; 
            end
            else if(opcode_reg==item.XOR)
            begin
                if (red_op_A_reg) 
                    out_exp=^A_reg;
                else if(red_op_B_reg)
                    out_exp=^B_reg;
                else
                    out_exp=A_reg^B_reg; 
            end
            else if(opcode_reg==item.ADD)
                out_exp=A_reg+B_reg+cin_reg;
            else if(opcode_reg==item.MULT)
                out_exp=A_reg*B_reg;
            else if(opcode_reg==item.SHIFT)
                begin
                    if(direction_reg)
                        out_exp = {out_exp[4:0],serial_in_reg};
                    else
                        out_exp = {serial_in_reg,out_exp[5:1]};
                end
            else if(opcode_reg==item.ROTATE)
                begin
                    if(direction_reg)
                        out_exp = {out_exp[4:0],out_exp[5]};
                    else
                        out_exp = {out_exp[0],out_exp[5:1]};
                end
        end
        update_internals();
    endtask //

    task  update_internals();
        cin_reg=item.cin;
        red_op_A_reg=item.red_op_A;
        red_op_B_reg=item.red_op_B;
        bypass_A_reg=item.bypass_A;
        bypass_B_reg=item.bypass_B;
        direction_reg=item.direction;
        serial_in_reg=item.serial_in;
        opcode_reg=item.opcode|item.op2;
        A_reg=item.A;
        B_reg=item.B;
    endtask 
endclass 

    
endpackage