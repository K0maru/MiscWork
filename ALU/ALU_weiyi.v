module ALU_weiyi (
    op1,in0,in1,in3,in4,
carryout,overflow,zero,out,N
);
    input [31:0] in0,in1;
    input [3:0] op1;
    output reg [31:0] out,in3,in4;
    output reg carryout,overflow,zero,N;
    integer i;
    always @(*) begin
        case(op1)
            //shl逻辑左移
        4'b0000:
            begin
                {carryout,out}=in0<<in1;
                overflow=0;
                zero=(out==0)?1:0;
                N = out[31];
            end
        //shr逻辑右移
        4'b0001:
            begin
                out=in0>>in1;
                carryout=in0[in1-1];
                overflow=0;
                zero=(out==0)?1:0;
                N = out[31];
            end
        //sar算术右
        4'b0010:
            begin
                out=($signed(in0))>>>in1;
                N = out[31];
                carryout=in0[in1-1];
                overflow=0;
                zero=(out==0)?1:0;
            end
        //sal算术左移
        4'b0011:
            begin
                in4 = in0;
                carryout = 0;
                out=($signed(in0))<<<in1;
                in3 = out/in4;
                overflow=(~(in3%2)&&out>in4)?0:1;
                zero=(out==0)?1:0;
                N = out[31];
                
            end
        default:
            begin
              
            end
        endcase
    end
endmodule
