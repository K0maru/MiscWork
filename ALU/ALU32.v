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
            ALU_multi multi(.in1(in0),.in2(in1),.out(out),.op1(op));//阵列乘法
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

module ALU_multi(in1,in2,out,op1,N);//阵列乘法

input [31:0] in1,in2;
input [3:0] op1;
output reg [31:0] out;
reg [31:0] in1xin2 [31:0];
output reg N;
integer i,j;
always @ (*)
begin
    case(op1)
    4'b0000:
    begin
    for(i=0;i<=31;i=i+1)
    begin
       for(j=0;j<=31;j=j+1)
	   begin
	   in1xin2[i][j]=in1[i]*in2[j];
	   end
	end
	for(i=0;i<=31;i=i+1)
	begin
	in1xin2[i][31]=~(in1[i]&in2[31]);
	end
	for(i=0;i<=31;i=i+1)
	begin
	in1xin2[31][i]=~(in1[31]&in2[i]);
	end
    end
    default:
        begin
          
        end
endcase

end
assign out=(({32'b1,in1xin2[0][31],in1xin2[0][30:0]}+{31'b0,in1xin2[1][31],in1xin2[1][30:0],1'b0})+
                ({30'b0,in1xin2[2][31],in1xin2[2][30:0],2'b0}+{29'b0,in1xin2[3][31],in1xin2[3][30:0],3'b0})+
                ({28'b0,in1xin2[4][31],in1xin2[4][30:0],4'b0}+{27'b0,in1xin2[5][31],in1xin2[5][30:0],5'b0})+
                ({26'b0,in1xin2[6][31],in1xin2[6][30:0],6'b0}+{25'b0,in1xin2[7][31],in1xin2[7][30:0],7'b0})+
                ({24'b0,in1xin2[8][31],in1xin2[8][30:0],8'b0}+{23'b0,in1xin2[9][31],in1xin2[9][30:0],9'b0})+
                ({22'b0,in1xin2[10][31],in1xin2[10][30:0],10'b0}+{21'b0,in1xin2[11][31],in1xin2[11][30:0],11'b0})+
                ({20'b0,in1xin2[12][31],in1xin2[12][30:0],12'b0}+{19'b0,in1xin2[13][31],in1xin2[13][30:0],13'b0})+
                ({18'b0,in1xin2[14][31],in1xin2[14][30:0],14'b0}+{17'b0,in1xin2[15][31],in1xin2[15][30:0],15'b0})+
                ({16'b0,in1xin2[16][31],in1xin2[16][30:0],16'b0}+{15'b0,in1xin2[17][31],in1xin2[17][30:0],17'b0})+
                ({14'b0,in1xin2[18][31],in1xin2[18][30:0],18'b0}+{13'b0,in1xin2[19][31],in1xin2[19][30:0],19'b0})+
                ({12'b0,in1xin2[20][31],in1xin2[20][30:0],20'b0}+{11'b0,in1xin2[21][31],in1xin2[21][30:0],21'b0})+
                ({10'b0,in1xin2[22][31],in1xin2[22][30:0],22'b0}+{9'b0,in1xin2[23][31],in1xin2[23][30:0],23'b0})+
                ({8'b0,in1xin2[24][31],in1xin2[24][30:0],24'b0}+{7'b0,in1xin2[25][31],in1xin2[25][30:0],25'b0})+
                ({6'b0,in1xin2[26][31],in1xin2[26][30:0],26'b0}+{5'b0,in1xin2[27][31],in1xin2[27][30:0],27'b0})+
                ({4'b0,in1xin2[28][31],in1xin2[28][30:0],28'b0}+{3'b0,in1xin2[29][31],in1xin2[29][30:0],29'b0})+
                ({2'b0,in1xin2[30][31],in1xin2[30][30:0],30'b0}+{1'b1,in1xin2[31][31],in1xin2[31][30:0],31'b0}));


endmodule
