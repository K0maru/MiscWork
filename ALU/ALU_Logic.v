module ALU_Logic (
    op1,in0,in1,
carryout,overflow,zero,out,N
);
    input [31:0] in0,in1;
    input [3:0] op1;
    output reg [31:0] out;
    output reg carryout,overflow,zero,N;
  always @(*) begin
    case(op1)
        //and
        4'b0000:
            begin
                out = in0&in1;
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
                N = out[31];
            end
        //or
        4'b0001:
            begin
                out = in0|in1;
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
                N = out[31];
            end
        //xor
        4'b0010:
            begin
                out = in0^in1;
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
                N = out[31];
            end
        //¸ßµÍ16Î»½»»»
        4'b0011:
            begin
                out={in0[15:0],in0[31:16]};
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
                N = out[31];
            end
        4'b0100:
            begin
                out = ~in0;
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
                N = out[31];
            end 
        default:
            begin
              
            end
    endcase
  end
    
endmodule