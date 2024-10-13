module sva (
    A, B, cin, serial_in, red_op_A, red_op_B, opcode, bypass_A, bypass_B, clk, rst, direction, leds, out
);
    input clk;
    input logic rst, cin, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in;
    logic signed [1:0] cin_reg ;
    assign cin_reg=cin;
    input logic [2:0] opcode;
    input logic signed [2:0] A, B;
    input logic [15:0] leds;
    input logic signed [5:0] out;
    always_comb begin 
        if ( rst)
        RESET : assert final( out==6'd0  );
    end
    //valid
    BY_B:assert property(@(posedge  clk) disable iff( rst) $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b1  && $past(rst,2)==1'd0 && $past(rst)==1'd0   |->  out==$past(B,2)  );
    BY_A:assert property(@(posedge  clk) disable iff( rst) $past( bypass_A,2)==1'b1   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out==$past(A,2)  );
    OR_A:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd0 && $past( red_op_A,2)==1'b1 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out==|$past( A,2)     );
    OR_B:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd0 && $past( red_op_A,2)==1'b0 && $past( red_op_B,2)==1'b1 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out==|$past( B,2)   );
    OR:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd0 && $past( red_op_A,2)==1'b0 && $past( red_op_B,2)==1'b0 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out==$past( B,2)|$past( A,2)   );
    XOR_A:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd1 && $past( red_op_A,2)==1'b1 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out==^$past( A,2)   );
    XOR_B:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd1 && $past( red_op_A,2)==1'b0 && $past( red_op_B,2)==1'b1 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out==^$past( B,2)   );
    XOR:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd1 && $past( red_op_A,2)==1'b0 && $past( red_op_B,2)==1'b0 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out==$past( B,2)^$past( A,2)   );
    ADD:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd2 && $past( red_op_A,2)==1'b0 && $past( red_op_B,2)==1'b0 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out==$past( B,2)+$past( A,2)+$past( cin_reg,2)  );
    MULT:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd3 && $past( red_op_A,2)==1'b0 && $past( red_op_B,2)==1'b0 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out==$past( B,2)*$past( A,2)  );
    SHIFT_R:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd4 && $past( red_op_A,2)==1'b0 && $past( red_op_B,2)==1'b0 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0 && $past( direction,2)==1'b1   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out=={$past(out[4:0]), $past( serial_in,2)}   );
    SHIFT_L:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd4 && $past( red_op_A,2)==1'b0 && $past( red_op_B,2)==1'b0 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0 && $past( direction,2)==1'b0   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out=={$past( serial_in,2), $past(out[5:1])}   );
    ROTATE_R:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd5 && $past( red_op_A,2)==1'b0 && $past( red_op_B,2)==1'b0 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0 && $past( direction,2)==1'b1   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out=={$past(out[4:0]),$past(out[5])}   );
    ROTATE_L:assert property(@(posedge  clk) disable iff( rst) $past( opcode,2)==3'd5 && $past( red_op_A,2)==1'b0 && $past( red_op_B,2)==1'b0 && $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0 && $past( direction,2)==1'b0   && $past(rst,2)==1'd0 && $past(rst)==1'd0  |-> out=={$past(out[0]),$past(out[5:1])}   );
    //invalid
    invalid_out :assert property(@(posedge  clk) disable iff( rst) ($past( opcode,2)==3'd6 || $past( opcode,2)==3'd7 || ($past( opcode,2)>3'd1 && ($past( red_op_A,2)==1||$past( red_op_B,2)==1)))&& $past( bypass_A,2)==1'b0 && $past( bypass_B,2)==1'b0  && $past(rst,2)==1'd0 && $past(rst)==1'd0  |->  out==0  ); 
    //leds 
    invalid_leds :assert property(@(posedge  clk) disable iff( rst) ($past( opcode,1)==3'd6 || $past( opcode,1)==3'd7 || ($past( opcode,1)>3'd1 && ($past( red_op_A,1)==1||$past( red_op_B,1)==1)))  && $past(rst)==1'd0  |-> ##1 leds==~$past(leds)  ); 
endmodule