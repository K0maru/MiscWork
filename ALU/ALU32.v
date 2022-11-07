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

//op1选择模块内运算
//op选择模块

module ALU32(
op1,op,in0,in1,
carryout,overflow,zero,out,N
    );
    //carryout:进位
    input [31:0] in0,in1;
    input [3:0] op;
    input [3:0] op1;
    output wire  [31:0] out;
    output wire carryout,overflow,zero,N;
    parameter O = 4'b0000;
    
    generate
            case (O)
            4'b0000:
            ALU_add adder(.in0(in0),.in1(in1),.out(out),.zero(zero),.carryout(carryout),.overflow(overflow),.op1(op1),.N(N));
            4'b0001:
            ALU_weiyi weiyi(.in0(in0),.in1(in1),.out(out),.zero(zero),.carryout(carryout),.overflow(overflow),.op1(op1),.N(N));
            4'b0010:
            ALU_Logic Logic(.in0(in0),.in1(in1),.out(out),.zero(zero),.carryout(carryout),.overflow(overflow),.op1(op1),.N(N));
            4'b0011:
            ALU_multi multi(.A(in0),.B(in1),.Y(out),.op1(op));//阵列乘法
            default:;
            endcase
        
    endgenerate
endmodule




module ALU_add (
    in0,in1,
carryout,overflow,zero,out,op1,N
);
    input [31:0] in0,in1;
    input [3:0] op1;
    output reg [31:0] out;
    output reg carryout,overflow,zero,N;
    always @(*)
    case(op1)
        //add加法
        4'b0000:
            begin 
                {carryout,out}=in0+in1;
                overflow=((in0[31]==in1[31])&&(~out[31]==in0[31]))?1:0;
                zero=(out==0)?1:0;
                N = out[31];
                
            end
        //add1
        4'b0001:
            begin
                {carryout,out}=in0+1;
                zero=(out==0)?1:0;
                N = out[31];
                overflow=(~out[31]==in0[31])?1:0;
            end
        //sub减法
        4'b0010:
            begin
                {carryout,out}=in0-in1;
                N = out[31];
                overflow=((in0[31]==0&&in1[31]==1&&out[31]==1)||(in0[31]==1&&in1[31]==0&&out[31]==0))?1:0;
                zero=(in0==in1)?1:0;
            end
        //sub1
        4'b0011:
            begin
                {carryout,out}=in0-1;
                N = out[31];
                zero=(out==0)?1:0;
                overflow=(~out[31]==in0[31])?1:0;
            end
        default:
            begin
              
            end
            
    endcase
endmodule

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
        //and与
        4'b0000:
            begin
                out=in0&in1;
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
            end
        //or或
        4'b0001:
            begin
                out=in0|in1;
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
            end
        //xor异或
        4'b0010:
            begin
                out=in0^in1;
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
            end
        //nor或非
        4'b0011:
            begin
                out=~(in0|in1);
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
            end
        default:
            begin
              
            end
    endcase
  end
    
endmodule

module ALU_weiyi (
    op1,in0,in1,
carryout,overflow,zero,out,N
);
    input [31:0] in0,in1;
    input [3:0] op1;
    output reg [31:0] out;
    output reg carryout,overflow,zero,N;
    always @(*) begin
        case(op1)
            //shl逻辑左移
        4'b0000:
            begin
                {carryout,out}=in0<<in1;
                overflow=0;
                zero=(out==0)?1:0;
            end
        //shr逻辑右移
        4'b0001:
            begin
                out=in0>>in1;
                carryout=in0[in1-1];
                overflow=0;
                zero=(out==0)?1:0;
            end
        //sar算术右移
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
                {carryout,out}=($signed(in0))<<<in1;
                overflow=0;
                zero=(out==0)?1:0;
                N = out[31];
            end
        default:
            begin
              
            end
        endcase
    end
endmodule

//carry save adder -- for implementing dadda multiplier
//csa for use of half adder and full adder.

module csa_dadda(A,B,Cin,Y,Cout);
input A,B,Cin;
output Y,Cout;
    
assign Y = A^B^Cin;
assign Cout = (A&B)|(A&Cin)|(B&Cin);
    
endmodule

module HA(a, b, Sum, Cout);

input a, b; // a and b are inputs with size 1-bit
output Sum, Cout; // Sum and Cout are outputs with size 1-bit

assign Sum = a ^ b; 
assign Cout = a & b; 

endmodule

module ALU_multi(A,B,Y,op1,carryout,overflow,zero,N);//阵列乘法

    input [31:0]A;
    input [31:0]B;  
    output wire [63:0] Y;
    output reg carryout,overflow,zero,N;

//outputs of 16*16 dadda.      
    wire [31:0]y11,y12,y21,y22;

//sum and carry of final 2 stages.      
    wire [31:0]s_1,c_1; 
    wire [46:0]c_2;
    dadda_16 d1(.A(A[15:0]),.B(B[15:0]),.Y(y11));
    assign Y[15:0] = y11[15:0];

    dadda_16 d2(.A(A[15:0]),.B(B[31:16]),.Y(y12));
    dadda_16 d3(.A(A[31:16]),.B(B[15:0]),.Y(y21));
    dadda_16 d4(.A(A[31:16]),.B(B[31:16]),.Y(y22));
    
    
//Stage 1 - reducing fom 3 to 2
    
    csa_dadda c_11(.A(y11[16]),.B(y12[0]),.Cin(y21[0]),.Y(s_1[0]),.Cout(c_1[0]));
    assign Y[16] = s_1[0];
    csa_dadda c_12(.A(y11[17]),.B(y12[1]),.Cin(y21[1]),.Y(s_1[1]),.Cout(c_1[1]));
    csa_dadda c_13(.A(y11[18]),.B(y12[2]),.Cin(y21[2]),.Y(s_1[2]),.Cout(c_1[2]));
    csa_dadda c_14(.A(y11[19]),.B(y12[3]),.Cin(y21[3]),.Y(s_1[3]),.Cout(c_1[3]));
    csa_dadda c_15(.A(y11[20]),.B(y12[4]),.Cin(y21[4]),.Y(s_1[4]),.Cout(c_1[4]));
    csa_dadda c_16(.A(y11[21]),.B(y12[5]),.Cin(y21[5]),.Y(s_1[5]),.Cout(c_1[5]));
    csa_dadda c_17(.A(y11[22]),.B(y12[6]),.Cin(y21[6]),.Y(s_1[6]),.Cout(c_1[6]));
    csa_dadda c_18(.A(y11[23]),.B(y12[7]),.Cin(y21[7]),.Y(s_1[7]),.Cout(c_1[7]));
    csa_dadda c_19(.A(y11[24]),.B(y12[8]),.Cin(y21[8]),.Y(s_1[8]),.Cout(c_1[8]));
    csa_dadda c_110(.A(y11[25]),.B(y12[9]),.Cin(y21[9]),.Y(s_1[9]),.Cout(c_1[9]));
    csa_dadda c_111(.A(y11[26]),.B(y12[10]),.Cin(y21[10]),.Y(s_1[10]),.Cout(c_1[10]));
    csa_dadda c_112(.A(y11[27]),.B(y12[11]),.Cin(y21[11]),.Y(s_1[11]),.Cout(c_1[11]));
    csa_dadda c_113(.A(y11[28]),.B(y12[12]),.Cin(y21[12]),.Y(s_1[12]),.Cout(c_1[12]));
    csa_dadda c_114(.A(y11[29]),.B(y12[13]),.Cin(y21[13]),.Y(s_1[13]),.Cout(c_1[13]));
    csa_dadda c_115(.A(y11[30]),.B(y12[14]),.Cin(y21[14]),.Y(s_1[14]),.Cout(c_1[14]));
    csa_dadda c_116(.A(y11[31]),.B(y12[15]),.Cin(y21[15]),.Y(s_1[15]),.Cout(c_1[15]));
    csa_dadda c_117(.A(y22[0]),.B(y12[16]),.Cin(y21[16]),.Y(s_1[16]),.Cout(c_1[16]));
    csa_dadda c_118(.A(y22[1]),.B(y12[17]),.Cin(y21[17]),.Y(s_1[17]),.Cout(c_1[17]));
    csa_dadda c_119(.A(y22[2]),.B(y12[18]),.Cin(y21[18]),.Y(s_1[18]),.Cout(c_1[18]));
    csa_dadda c_120(.A(y22[3]),.B(y12[19]),.Cin(y21[19]),.Y(s_1[19]),.Cout(c_1[19]));
    csa_dadda c_121(.A(y22[4]),.B(y12[20]),.Cin(y21[20]),.Y(s_1[20]),.Cout(c_1[20]));
    csa_dadda c_122(.A(y22[5]),.B(y12[21]),.Cin(y21[21]),.Y(s_1[21]),.Cout(c_1[21]));
    csa_dadda c_123(.A(y22[6]),.B(y12[22]),.Cin(y21[22]),.Y(s_1[22]),.Cout(c_1[22]));
    csa_dadda c_124(.A(y22[7]),.B(y12[23]),.Cin(y21[23]),.Y(s_1[23]),.Cout(c_1[23]));
    csa_dadda c_125(.A(y22[8]),.B(y12[24]),.Cin(y21[24]),.Y(s_1[24]),.Cout(c_1[24]));
    csa_dadda c_126(.A(y22[9]),.B(y12[25]),.Cin(y21[25]),.Y(s_1[25]),.Cout(c_1[25]));
    csa_dadda c_127(.A(y22[10]),.B(y12[26]),.Cin(y21[26]),.Y(s_1[26]),.Cout(c_1[26]));
    csa_dadda c_128(.A(y22[11]),.B(y12[27]),.Cin(y21[27]),.Y(s_1[27]),.Cout(c_1[27]));
    csa_dadda c_129(.A(y22[12]),.B(y12[28]),.Cin(y21[28]),.Y(s_1[28]),.Cout(c_1[28]));
    csa_dadda c_130(.A(y22[13]),.B(y12[29]),.Cin(y21[29]),.Y(s_1[29]),.Cout(c_1[29]));
    csa_dadda c_131(.A(y22[14]),.B(y12[30]),.Cin(y21[30]),.Y(s_1[30]),.Cout(c_1[30]));
    csa_dadda c_132(.A(y22[15]),.B(y12[31]),.Cin(y21[31]),.Y(s_1[31]),.Cout(c_1[31]));
      
    //Stage 1 - reducing fom 2 to 1
    // adding total sum and carry to get final output
    HA h1(.a(s_1[1]),.b(c_1[0]),.Sum(Y[17]),.Cout(c_2[0]));
    
    csa_dadda c_22(.A(s_1[2]),.B(c_1[1]),.Cin(c_2[0]),.Y(Y[18]),.Cout(c_2[1]));
    csa_dadda c_23(.A(s_1[3]),.B(c_1[2]),.Cin(c_2[1]),.Y(Y[19]),.Cout(c_2[2]));
    csa_dadda c_24(.A(s_1[4]),.B(c_1[3]),.Cin(c_2[2]),.Y(Y[20]),.Cout(c_2[3]));
    csa_dadda c_25(.A(s_1[5]),.B(c_1[4]),.Cin(c_2[3]),.Y(Y[21]),.Cout(c_2[4]));
    csa_dadda c_26(.A(s_1[6]),.B(c_1[5]),.Cin(c_2[4]),.Y(Y[22]),.Cout(c_2[5]));
    csa_dadda c_27(.A(s_1[7]),.B(c_1[6]),.Cin(c_2[5]),.Y(Y[23]),.Cout(c_2[6]));
    csa_dadda c_28(.A(s_1[8]),.B(c_1[7]),.Cin(c_2[6]),.Y(Y[24]),.Cout(c_2[7]));
    csa_dadda c_29(.A(s_1[9]),.B(c_1[8]),.Cin(c_2[7]),.Y(Y[25]),.Cout(c_2[8]));
    csa_dadda c_210(.A(s_1[10]),.B(c_1[9]),.Cin(c_2[8]),.Y(Y[26]),.Cout(c_2[9]));
    csa_dadda c_211(.A(s_1[11]),.B(c_1[10]),.Cin(c_2[9]),.Y(Y[27]),.Cout(c_2[10]));
    csa_dadda c_212(.A(s_1[12]),.B(c_1[11]),.Cin(c_2[10]),.Y(Y[28]),.Cout(c_2[11]));
    csa_dadda c_213(.A(s_1[13]),.B(c_1[12]),.Cin(c_2[11]),.Y(Y[29]),.Cout(c_2[12]));
    csa_dadda c_214(.A(s_1[14]),.B(c_1[12]),.Cin(c_2[12]),.Y(Y[30]),.Cout(c_2[13]));
    csa_dadda c_215(.A(s_1[15]),.B(c_1[14]),.Cin(c_2[13]),.Y(Y[31]),.Cout(c_2[14]));
    csa_dadda c_216(.A(s_1[16]),.B(c_1[15]),.Cin(c_2[14]),.Y(Y[32]),.Cout(c_2[15]));
    csa_dadda c_217(.A(s_1[17]),.B(c_1[16]),.Cin(c_2[15]),.Y(Y[33]),.Cout(c_2[16]));
    csa_dadda c_218(.A(s_1[18]),.B(c_1[17]),.Cin(c_2[16]),.Y(Y[34]),.Cout(c_2[17]));
    csa_dadda c_219(.A(s_1[19]),.B(c_1[18]),.Cin(c_2[17]),.Y(Y[35]),.Cout(c_2[18]));
    csa_dadda c_220(.A(s_1[20]),.B(c_1[19]),.Cin(c_2[18]),.Y(Y[36]),.Cout(c_2[19]));
    csa_dadda c_221(.A(s_1[21]),.B(c_1[20]),.Cin(c_2[19]),.Y(Y[37]),.Cout(c_2[20]));
    csa_dadda c_222(.A(s_1[22]),.B(c_1[21]),.Cin(c_2[20]),.Y(Y[38]),.Cout(c_2[21]));
    csa_dadda c_223(.A(s_1[23]),.B(c_1[22]),.Cin(c_2[21]),.Y(Y[39]),.Cout(c_2[22]));
    csa_dadda c_224(.A(s_1[24]),.B(c_1[23]),.Cin(c_2[22]),.Y(Y[40]),.Cout(c_2[23]));
    csa_dadda c_225(.A(s_1[25]),.B(c_1[24]),.Cin(c_2[23]),.Y(Y[41]),.Cout(c_2[24]));
    csa_dadda c_226(.A(s_1[26]),.B(c_1[25]),.Cin(c_2[24]),.Y(Y[42]),.Cout(c_2[25]));
    csa_dadda c_227(.A(s_1[27]),.B(c_1[26]),.Cin(c_2[25]),.Y(Y[43]),.Cout(c_2[26]));
    csa_dadda c_228(.A(s_1[28]),.B(c_1[27]),.Cin(c_2[26]),.Y(Y[44]),.Cout(c_2[27]));
    csa_dadda c_229(.A(s_1[29]),.B(c_1[28]),.Cin(c_2[27]),.Y(Y[45]),.Cout(c_2[28]));
    csa_dadda c_230(.A(s_1[30]),.B(c_1[29]),.Cin(c_2[28]),.Y(Y[46]),.Cout(c_2[29]));
    csa_dadda c_231(.A(s_1[31]),.B(c_1[30]),.Cin(c_2[29]),.Y(Y[47]),.Cout(c_2[30])); 
    csa_dadda c_232(.A(y22[16]),.B(c_1[31]),.Cin(c_2[30]),.Y(Y[48]),.Cout(c_2[31]));

    HA h2(.a(y22[17]),.b(c_2[31]),.Sum(Y[49]),.Cout(c_2[32]));
    HA h3(.a(y22[18]),.b(c_2[32]),.Sum(Y[50]),.Cout(c_2[33]));
    HA h4(.a(y22[19]),.b(c_2[33]),.Sum(Y[51]),.Cout(c_2[34]));
    HA h5(.a(y22[20]),.b(c_2[34]),.Sum(Y[52]),.Cout(c_2[35]));
    HA h6(.a(y22[21]),.b(c_2[35]),.Sum(Y[53]),.Cout(c_2[36]));
    HA h7(.a(y22[22]),.b(c_2[36]),.Sum(Y[54]),.Cout(c_2[37]));
    HA h8(.a(y22[23]),.b(c_2[37]),.Sum(Y[55]),.Cout(c_2[38]));
    HA h9(.a(y22[24]),.b(c_2[38]),.Sum(Y[56]),.Cout(c_2[39]));
    HA h10(.a(y22[25]),.b(c_2[39]),.Sum(Y[57]),.Cout(c_2[40]));
    HA h11(.a(y22[26]),.b(c_2[40]),.Sum(Y[58]),.Cout(c_2[41]));
    HA h12(.a(y22[27]),.b(c_2[41]),.Sum(Y[59]),.Cout(c_2[42]));
    HA h13(.a(y22[28]),.b(c_2[42]),.Sum(Y[60]),.Cout(c_2[43]));
    HA h14(.a(y22[29]),.b(c_2[43]),.Sum(Y[61]),.Cout(c_2[44]));
    HA h15(.a(y22[30]),.b(c_2[44]),.Sum(Y[62]),.Cout(c_2[45]));
    HA h16(.a(y22[31]),.b(c_2[45]),.Sum(Y[63]),.Cout(c_2[46]));
  always @(*) begin
    carryout = 0;
    overflow=((A[31]==B[31]&&~Y[63]==A[31])||(~A[31]==B[31]&&Y[63]==0))?1:0;
    zero=(Y==0)?1:0;
    N=Y[63];
  end
endmodule
