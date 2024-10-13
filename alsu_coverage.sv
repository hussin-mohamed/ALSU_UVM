package coverage_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import sequence_item::*;
class alsu_cover extends uvm_component;
`uvm_component_utils(alsu_cover)
uvm_analysis_export #(seq_item) cov_export;
uvm_tlm_analysis_fifo #(seq_item) cov_fifo;
seq_item item;
parameter maxpos=3, maxneg=-4, zero=0 ;
covergroup g1 ;
        direction_cp:coverpoint item.direction{
            bins dir1={1};
            bins dir0={0};
        }
        serial_in_cp:coverpoint item.serial_in{
            bins in1={1};
            bins in0={0};
        }
        CIN_cp: coverpoint item.cin {
            bins cin1={1};
            bins cin0={0};
        }
        A_cp: coverpoint item.A{
            bins A_data_0 ={0};
            bins A_data_max ={maxpos};
            bins A_data_neg ={maxneg};
            bins A_data_walkingones[]={1,2,-4} iff(item.red_op_A);
            bins A_data_default=default;
        }
        B_cp: coverpoint item.B{
            bins B_data_0 ={0};
            bins B_data_max ={maxpos};
            bins B_data_neg ={maxneg};
            bins B_data_walkingones[]={1,2,-4} iff(!item.red_op_A&&item.red_op_B);
            bins B_data_default=default;
        }
        ALU_cpp : coverpoint item.opcode{
            bins binsinvalid[]={item.INVALID6,item.INVALID7} ;
            bins bins_shift[] ={item.SHIFT,item.ROTATE};
            bins bins_arith[] ={item.ADD,item.MULT};
            bins bins_bitwise[] ={item.OR,item.XOR}; 
        }
        
        ALU_cp: coverpoint item.op2{
            bins bins_shift[] ={item.SHIFT,item.ROTATE};
            bins bins_arith[] ={item.ADD,item.MULT};
            bins bins_bitwise[] ={item.OR,item.XOR}; 
            bins bins_trans[]=(item.OR=>item.XOR, item.ADD, item.MULT, item.SHIFT, item.ROTATE);
        }
        cross A_cp,B_cp,ALU_cp,CIN_cp,serial_in_cp,direction_cp,ALU_cpp {
            option.cross_auto_bin_max=0;
            bins add_mult_max_a = binsof(ALU_cp.bins_arith)&&binsof(A_cp.A_data_max);
            bins add_mult_max_b = binsof(ALU_cp.bins_arith)&&binsof(B_cp.B_data_max);
            bins add_mult_neg_a = binsof(ALU_cp.bins_arith)&&binsof(A_cp.A_data_neg);
            bins add_mult_neg_b = binsof(ALU_cp.bins_arith)&&binsof(B_cp.B_data_neg);
            bins add_mult_zero_a = binsof(ALU_cp.bins_arith)&&binsof(A_cp.A_data_0);
            bins add_mult_zero_b = binsof(ALU_cp.bins_arith)&&binsof(B_cp.B_data_0);
            bins add_cin_1 = ((binsof (ALU_cp) intersect {item.ADD})||(binsof (ALU_cpp) intersect {item.ADD})) && (binsof(CIN_cp.cin1));
            bins add_cin_0 = binsof (ALU_cp) intersect {item.ADD} && (binsof(CIN_cp.cin0));
            bins shift_shiftin_0 = binsof (ALU_cp) intersect {item.SHIFT} && (binsof(serial_in_cp.in0));
            bins shift_shiftin_1 = (binsof (ALU_cp) intersect {item.SHIFT}||binsof (ALU_cpp) intersect {item.SHIFT}) && (binsof(serial_in_cp.in1));
            bins shift_rotate_0 = binsof (ALU_cp.bins_shift) && (binsof(direction_cp.dir0));
            bins shift_rotate_1 =( binsof (ALU_cp.bins_shift) || binsof (ALU_cpp.bins_shift)) && (binsof(direction_cp.dir1));
            bins red_op_A_OR_XOR_1 = binsof(ALU_cp.bins_bitwise) && binsof(A_cp) intersect {1} &&binsof(B_cp.B_data_0) iff(item.red_op_A);
            bins red_op_A_OR_XOR_2 = binsof(ALU_cp.bins_bitwise) && binsof(A_cp) intersect {2} &&binsof(B_cp.B_data_0) iff(item.red_op_A);
            bins red_op_A_OR_XOR_4 = binsof(ALU_cp.bins_bitwise) && binsof(A_cp) intersect {-4} &&binsof(B_cp.B_data_0) iff(item.red_op_A);
            bins red_op_B_OR_XOR_1 = binsof(ALU_cp.bins_bitwise) && binsof(B_cp) intersect {1} &&binsof(A_cp.A_data_0) iff(!item.red_op_A&&item.red_op_B);
            bins red_op_B_OR_XOR_2 = binsof(ALU_cp.bins_bitwise) && binsof(B_cp) intersect {2} &&binsof(A_cp.A_data_0) iff(!item.red_op_A&&item.red_op_B);
            bins red_op_B_OR_XOR_4 = binsof(ALU_cp.bins_bitwise) && binsof(B_cp) intersect {-4} &&binsof(A_cp.A_data_0) iff(!item.red_op_A&&item.red_op_B);
            bins invalid =  ! binsof (ALU_cpp.bins_bitwise)  iff(item.red_op_A||item.red_op_B);
        }
        endgroup

   function new(string name = "alsu_cover" , uvm_component parent = null);
        super.new(name,parent);
        g1=new();
    endfunction
    
      function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        cov_export=new("sb_export",this);
        cov_fifo=new("sb_fifo",this);
    endfunction 

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);
    endfunction 
     task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
        cov_fifo.get(item);
        g1.sample();
        end
    endtask
endclass 
    
endpackage