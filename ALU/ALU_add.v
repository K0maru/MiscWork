module ALU_add (
    in0,in1,in3,in4,
carryout,overflow,zero,out,op1,N
);
    input signed[31:0]  in0,in1;
    input [3:0] op1;
    output reg [31:0] out,in3,in4;
    output reg carryout,overflow,zero,N;
    always @(*)
    case(op1)
        //add
        4'b0000:
            begin 
                {carryout,out}=$signed(in0)+$signed(in1);
                overflow=in0[31]&in1[31] ^ in0[30]&in1[30];
                zero=(out==0)?1:0;
                N = out[31];
                
            end
        //add1
        4'b0001:
            begin
                {carryout,out}=$signed(in0)+1;
                zero=(out==0)?1:0;
                N = out[31];
                overflow=(~out[31]==in0[31])?1:0;
            end
        //sub
        4'b0010:
            begin
                in3 = in0;
                N = in3[31];
                {carryout,in3} = ~in3+1;
                in3[31] = N;

                in4 = in1;
               // N = in4[31];
                {carryout,in4} = ~in1+1;
                //in4[31] = N;

                out = in3+in4;
                N = out[31];
                out = ~out+1;
                out[31] = N;
                carryout = 0;
                N = out[31];
                overflow=in0[31]&in1[31] ^ in0[30]&in1[30];
                zero=(in0==in1)?1:0;
                in3 = 0;
                in4 = 0;
            end
        //sub1
        4'b0011:
            begin
                {carryout,out}=$signed(in0)-1;
                N = out[31];
                zero=(out==0)?1:0;
                overflow=(~out[31]==in0[31])?1:0;
            end
        default:
            begin
              
            end
            
    endcase
endmodule