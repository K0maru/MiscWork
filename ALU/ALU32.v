`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/21 16:11:22
// Design Name: 
// Module Name: ALU32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU32(
op1,op,in0,in1,
carryout,overflow,zero,out,N,out0,
carryout1,overflow1,zero1,N1,out1,
carryout2,overflow2,zero2,N2,out2,
carryout3,overflow3,zero3,N3,out3,
carryout4,overflow4,zero4,N4,out4
    );
    
    input [31:0] in0,in1;
    input [3:0] op;
    input [3:0] op1;
    output reg  [31:0] out;
    output reg  [31:0] out0;
    output wire  [31:0] out1;
    output wire  [31:0] out2;
    output wire  [31:0] out3;
    output wire  [63:0] out4;
    output reg carryout,overflow,zero,N;
    
    output wire carryout1,overflow1,zero1,N1;
    output wire carryout2,overflow2,zero2,N2;
    output wire carryout3,overflow3,zero3,N3;
    output wire carryout4,overflow4,zero4,N4;
    ALU_add adder (.in0(in0),.in1(in1),.out(out1),.zero(zero1),.carryout(carryout1),.overflow(overflow1),.op1(op1),.N(N1));
    ALU_weiyi weiyi(.in0(in0),.in1(in1),.out(out2),.zero(zero2),.carryout(carryout2),.overflow(overflow2),.op1(op1),.N(N2));
    ALU_Logic Logic(.in0(in0),.in1(in1),.out(out3),.zero(zero3),.carryout(carryout3),.overflow(overflow3),.op1(op1),.N(N3));
    ALU_multi multi(.A(in0),.B(in1),.Y(out4),.zero(zero4),.carryout(carryout4),.overflow(overflow4),.N(N4));
    always @(*)
    case(op)
        4'b0000:
            begin 
                out = out1;
                zero = zero1;
                carryout = carryout1;
                overflow = overflow1;
                N = N1;
                
            end
        4'b0001:
            begin
                out = out2;
                zero = zero2;
                carryout = carryout2;
                overflow = overflow2;
                N = N2;
            end
        4'b0010:
            begin
                out = out3;
                zero = zero3;
                carryout = 0;
                overflow = 0;
                N = N3;
            end
        4'b0011:
            begin
                {out,out0} = out4;
                zero = zero4;
                carryout = carryout4;
                overflow = overflow4;
                N = N4;
            end
        default:
            begin
              
            end
            
    endcase
    /*
    parameter O = 0;
    
    generate
            case (O)
            0:
            ALU_add adder (.in0(in0),.in1(in1),.out(out),.zero(zero),.carryout(carryout),.overflow(overflow),.op1(op1),.N(N));
            1:
            ALU_weiyi weiyi(.in0(in0),.in1(in1),.out(out),.zero(zero),.carryout(carryout),.overflow(overflow),.op1(op1),.N(N));
            2:
            ALU_Logic Logic(.in0(in0),.in1(in1),.out(out),.zero(zero),.carryout(carryout),.overflow(overflow),.op1(op1),.N(N));
            3:
            ALU_multi multi(.A(in0),.B(in1),.Y(out),.zero(zero),.carryout(carryout),.overflow(overflow),.N(N));//???§Ô??
            default:;
            endcase
            
    endgenerate
    */
endmodule