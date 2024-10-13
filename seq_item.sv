package sequence_item;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    class seq_item extends uvm_sequence_item;
        `uvm_object_utils(seq_item)
        parameter maxpos=3, maxneg=-4, zero=0 ;
        typedef enum {OR, XOR, ADD, MULT, SHIFT, ROTATE, INVALID6, INVALID7} opcode_e;
        rand logic rst, cin, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in;
        rand logic both = red_op_A&red_op_B; 
        static rand opcode_e opcode;
        static randc opcode_e op2;
        rand logic signed [2:0] A, B;
        logic [15:0] leds;
        logic signed [5:0] out;
        function new(string name = "shift_seq_item_class");
            super.new(name);
        endfunction //new()
        constraint con1 {
            op2==0;
            rst dist {0:=70,1:=30};
        if (opcode==ADD || opcode==MULT) {
            A dist {zero:=70,maxpos:=70,maxneg:=70,[-3:2]:=10};
            B dist {zero:=70,maxpos:=70,maxneg:=70,[-3:2]:=10};
        }
        if (opcode==OR || opcode==XOR && red_op_A) {
            A inside {1,2,-4};
            B inside {0};
        }
        if (opcode==OR || opcode==XOR && red_op_B && !red_op_A) {
            B inside {1,2,-4};
            A inside {0};
        }
        if (red_op_A || red_op_B) {
            opcode dist {OR:=500,XOR:=70,ADD:=10,MULT:=10,SHIFT:=10,ROTATE:=10,INVALID6:=10,INVALID7:=10};
            
            
        }
        else {
            opcode dist {OR:=90,XOR:=70,ADD:=70,MULT:=200,SHIFT:=70,ROTATE:=70,INVALID6:=10,INVALID7:=10};
        }
        if (opcode==OR || opcode==XOR ) {
            red_op_A dist {0:=50,1:=300};
            red_op_B dist {0:=50,1:=300};
            red_op_A&red_op_B dist {0:=50,1:=300};
        }
    }
    constraint con2{
            !(op2 inside {INVALID6,INVALID7});
            rst==0;
            cin==0;
            red_op_A==0;
            red_op_B==0;
            bypass_A==0;
            bypass_B==0;
            direction==0;
            serial_in==0;
            opcode==0;
    }
    endclass //seq_item extends superClass
endpackage