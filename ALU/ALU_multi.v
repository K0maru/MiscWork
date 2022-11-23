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

// dadda multiplier
// A - 8 bits , B - 8bits, y(output) - 16bits

module dadda_8(A,B,y);
    
    input [7:0] A;
    input [7:0] B;
    output wire [15:0] y;
    wire  gen_pp [0:7][7:0];
// stage-1 sum and carry
    wire [0:5]s1,c1;
// stage-2 sum and carry
    wire [0:13]s2,c2;   
// stage-3 sum and carry
    wire [0:9]s3,c3;
// stage-4 sum and carry
    wire [0:11]s4,c4;
// stage-5 sum and carry
    wire [0:13]s5,c5;




// generating partial products 
genvar i;
genvar j;

for(i = 0; i<8; i=i+1)begin

   for(j = 0; j<8;j = j+1)begin
      assign gen_pp[i][j] = A[j]*B[i];
end
end

 

//Reduction by stages.
// di_values = 2,3,4,6,8,13...


//Stage 1 - reducing fom 8 to 6  


    HA h1(.a(gen_pp[6][0]),.b(gen_pp[5][1]),.Sum(s1[0]),.Cout(c1[0]));
    HA h2(.a(gen_pp[4][3]),.b(gen_pp[3][4]),.Sum(s1[2]),.Cout(c1[2]));
    HA h3(.a(gen_pp[4][4]),.b(gen_pp[3][5]),.Sum(s1[4]),.Cout(c1[4]));

    csa_dadda c11(.A(gen_pp[7][0]),.B(gen_pp[6][1]),.Cin(gen_pp[5][2]),.Y(s1[1]),.Cout(c1[1]));
    csa_dadda c12(.A(gen_pp[7][1]),.B(gen_pp[6][2]),.Cin(gen_pp[5][3]),.Y(s1[3]),.Cout(c1[3]));     
    csa_dadda c13(.A(gen_pp[7][2]),.B(gen_pp[6][3]),.Cin(gen_pp[5][4]),.Y(s1[5]),.Cout(c1[5]));
    
//Stage 2 - reducing fom 6 to 4

    HA h4(.a(gen_pp[4][0]),.b(gen_pp[3][1]),.Sum(s2[0]),.Cout(c2[0]));
    HA h5(.a(gen_pp[2][3]),.b(gen_pp[1][4]),.Sum(s2[2]),.Cout(c2[2]));


    csa_dadda c21(.A(gen_pp[5][0]),.B(gen_pp[4][1]),.Cin(gen_pp[3][2]),.Y(s2[1]),.Cout(c2[1]));
    csa_dadda c22(.A(s1[0]),.B(gen_pp[4][2]),.Cin(gen_pp[3][3]),.Y(s2[3]),.Cout(c2[3]));
    csa_dadda c23(.A(gen_pp[2][4]),.B(gen_pp[1][5]),.Cin(gen_pp[0][6]),.Y(s2[4]),.Cout(c2[4]));
    csa_dadda c24(.A(s1[1]),.B(s1[2]),.Cin(c1[0]),.Y(s2[5]),.Cout(c2[5]));
    csa_dadda c25(.A(gen_pp[2][5]),.B(gen_pp[1][6]),.Cin(gen_pp[0][7]),.Y(s2[6]),.Cout(c2[6]));
    csa_dadda c26(.A(s1[3]),.B(s1[4]),.Cin(c1[1]),.Y(s2[7]),.Cout(c2[7]));
    csa_dadda c27(.A(c1[2]),.B(gen_pp[2][6]),.Cin(gen_pp[1][7]),.Y(s2[8]),.Cout(c2[8]));
    csa_dadda c28(.A(s1[5]),.B(c1[3]),.Cin(c1[4]),.Y(s2[9]),.Cout(c2[9]));
    csa_dadda c29(.A(gen_pp[4][5]),.B(gen_pp[3][6]),.Cin(gen_pp[2][7]),.Y(s2[10]),.Cout(c2[10]));
    csa_dadda c210(.A(gen_pp[7][3]),.B(c1[5]),.Cin(gen_pp[6][4]),.Y(s2[11]),.Cout(c2[11]));
    csa_dadda c211(.A(gen_pp[5][5]),.B(gen_pp[4][6]),.Cin(gen_pp[3][7]),.Y(s2[12]),.Cout(c2[12]));
    csa_dadda c212(.A(gen_pp[7][4]),.B(gen_pp[6][5]),.Cin(gen_pp[5][6]),.Y(s2[13]),.Cout(c2[13]));
    
//Stage 3 - reducing fom 4 to 3

    HA h6(.a(gen_pp[3][0]),.b(gen_pp[2][1]),.Sum(s3[0]),.Cout(c3[0]));

    csa_dadda c31(.A(s2[0]),.B(gen_pp[2][2]),.Cin(gen_pp[1][3]),.Y(s3[1]),.Cout(c3[1]));
    csa_dadda c32(.A(s2[1]),.B(s2[2]),.Cin(c2[0]),.Y(s3[2]),.Cout(c3[2]));
    csa_dadda c33(.A(c2[1]),.B(c2[2]),.Cin(s2[3]),.Y(s3[3]),.Cout(c3[3]));
    csa_dadda c34(.A(c2[3]),.B(c2[4]),.Cin(s2[5]),.Y(s3[4]),.Cout(c3[4]));
    csa_dadda c35(.A(c2[5]),.B(c2[6]),.Cin(s2[7]),.Y(s3[5]),.Cout(c3[5]));
    csa_dadda c36(.A(c2[7]),.B(c2[8]),.Cin(s2[9]),.Y(s3[6]),.Cout(c3[6]));
    csa_dadda c37(.A(c2[9]),.B(c2[10]),.Cin(s2[11]),.Y(s3[7]),.Cout(c3[7]));
    csa_dadda c38(.A(c2[11]),.B(c2[12]),.Cin(s2[13]),.Y(s3[8]),.Cout(c3[8]));
    csa_dadda c39(.A(gen_pp[7][5]),.B(gen_pp[6][6]),.Cin(gen_pp[5][7]),.Y(s3[9]),.Cout(c3[9]));

//Stage 4 - reducing fom 3 to 2

    HA h7(.a(gen_pp[2][0]),.b(gen_pp[1][1]),.Sum(s4[0]),.Cout(c4[0]));


    csa_dadda c41(.A(s3[0]),.B(gen_pp[1][2]),.Cin(gen_pp[0][3]),.Y(s4[1]),.Cout(c4[1]));
    csa_dadda c42(.A(c3[0]),.B(s3[1]),.Cin(gen_pp[0][4]),.Y(s4[2]),.Cout(c4[2]));
    csa_dadda c43(.A(c3[1]),.B(s3[2]),.Cin(gen_pp[0][5]),.Y(s4[3]),.Cout(c4[3]));
    csa_dadda c44(.A(c3[2]),.B(s3[3]),.Cin(s2[4]),.Y(s4[4]),.Cout(c4[4]));
    csa_dadda c45(.A(c3[3]),.B(s3[4]),.Cin(s2[6]),.Y(s4[5]),.Cout(c4[5]));
    csa_dadda c46(.A(c3[4]),.B(s3[5]),.Cin(s2[8]),.Y(s4[6]),.Cout(c4[6]));
    csa_dadda c47(.A(c3[5]),.B(s3[6]),.Cin(s2[10]),.Y(s4[7]),.Cout(c4[7]));
    csa_dadda c48(.A(c3[6]),.B(s3[7]),.Cin(s2[12]),.Y(s4[8]),.Cout(c4[8]));
    csa_dadda c49(.A(c3[7]),.B(s3[8]),.Cin(gen_pp[4][7]),.Y(s4[9]),.Cout(c4[9]));
    csa_dadda c410(.A(c3[8]),.B(s3[9]),.Cin(c2[13]),.Y(s4[10]),.Cout(c4[10]));
    csa_dadda c411(.A(c3[9]),.B(gen_pp[7][6]),.Cin(gen_pp[6][7]),.Y(s4[11]),.Cout(c4[11]));
    
//Stage 5 - reducing fom 2 to 1
    // adding total sum and carry to get final output

    HA h8(.a(gen_pp[1][0]),.b(gen_pp[0][1]),.Sum(y[1]),.Cout(c5[0]));



    csa_dadda c51(.A(s4[0]),.B(gen_pp[0][2]),.Cin(c5[0]),.Y(y[2]),.Cout(c5[1]));
    csa_dadda c52(.A(c4[0]),.B(s4[1]),.Cin(c5[1]),.Y(y[3]),.Cout(c5[2]));
    csa_dadda c54(.A(c4[1]),.B(s4[2]),.Cin(c5[2]),.Y(y[4]),.Cout(c5[3]));
    csa_dadda c55(.A(c4[2]),.B(s4[3]),.Cin(c5[3]),.Y(y[5]),.Cout(c5[4]));
    csa_dadda c56(.A(c4[3]),.B(s4[4]),.Cin(c5[4]),.Y(y[6]),.Cout(c5[5]));
    csa_dadda c57(.A(c4[4]),.B(s4[5]),.Cin(c5[5]),.Y(y[7]),.Cout(c5[6]));
    csa_dadda c58(.A(c4[5]),.B(s4[6]),.Cin(c5[6]),.Y(y[8]),.Cout(c5[7]));
    csa_dadda c59(.A(c4[6]),.B(s4[7]),.Cin(c5[7]),.Y(y[9]),.Cout(c5[8]));
    csa_dadda c510(.A(c4[7]),.B(s4[8]),.Cin(c5[8]),.Y(y[10]),.Cout(c5[9]));
    csa_dadda c511(.A(c4[8]),.B(s4[9]),.Cin(c5[9]),.Y(y[11]),.Cout(c5[10]));
    csa_dadda c512(.A(c4[9]),.B(s4[10]),.Cin(c5[10]),.Y(y[12]),.Cout(c5[11]));
    csa_dadda c513(.A(c4[10]),.B(s4[11]),.Cin(c5[11]),.Y(y[13]),.Cout(c5[12]));
    csa_dadda c514(.A(c4[11]),.B(gen_pp[7][7]),.Cin(c5[12]),.Y(y[14]),.Cout(c5[13]));

    assign y[0] =  gen_pp[0][0];
    assign y[15] = c5[13];
       
endmodule 


// A - 16 bits , B - 16 bits, Y(output) - 32 bits
//Here we used 8*8 dadda to implement 16*16.

module dadda_16(A,B,Y);
    
    input [15:0]A;
    input [15:0]B;
    
    output wire [31:0] Y;
//outputs of 8*8 dadda.    
    wire [15:0]y11,y12,y21,y22;

//sum and carry of final 2 stages.     
    wire [15:0]s_1,c_1;    
    wire [22:0] c_2;
    
    dadda_8 d1(.A(A[7:0]),.B(B[7:0]),.y(y11));
    dadda_8 d2(.A(A[7:0]),.B(B[15:8]),.y(y12));
    dadda_8 d3(.A(A[15:8]),.B(B[7:0]),.y(y21));
    dadda_8 d4(.A(A[15:8]),.B(B[15:8]),.y(y22));
    assign Y[7:0] = y11[7:0];
    
//Stage 1 - reducing fom 3 to 2
    
    csa_dadda c_11(.A(y11[8]),.B(y12[0]),.Cin(y21[0]),.Y(s_1[0]),.Cout(c_1[0]));
    assign Y[8] = s_1[0];
    csa_dadda c_12(.A(y11[9]),.B(y12[1]),.Cin(y21[1]),.Y(s_1[1]),.Cout(c_1[1]));
    csa_dadda c_13(.A(y11[10]),.B(y12[2]),.Cin(y21[2]),.Y(s_1[2]),.Cout(c_1[2]));
    csa_dadda c_14(.A(y11[11]),.B(y12[3]),.Cin(y21[3]),.Y(s_1[3]),.Cout(c_1[3]));
    csa_dadda c_15(.A(y11[12]),.B(y12[4]),.Cin(y21[4]),.Y(s_1[4]),.Cout(c_1[4]));
    csa_dadda c_16(.A(y11[13]),.B(y12[5]),.Cin(y21[5]),.Y(s_1[5]),.Cout(c_1[5]));
    csa_dadda c_17(.A(y11[14]),.B(y12[6]),.Cin(y21[6]),.Y(s_1[6]),.Cout(c_1[6]));
    csa_dadda c_18(.A(y11[15]),.B(y12[7]),.Cin(y21[7]),.Y(s_1[7]),.Cout(c_1[7]));
    csa_dadda c_19(.A(y22[0]),.B(y12[8]),.Cin(y21[8]),.Y(s_1[8]),.Cout(c_1[8]));
    csa_dadda c_110(.A(y22[1]),.B(y12[9]),.Cin(y21[9]),.Y(s_1[9]),.Cout(c_1[9]));
    csa_dadda c_111(.A(y22[2]),.B(y12[10]),.Cin(y21[10]),.Y(s_1[10]),.Cout(c_1[10]));
    csa_dadda c_112(.A(y22[3]),.B(y12[11]),.Cin(y21[11]),.Y(s_1[11]),.Cout(c_1[11]));
    csa_dadda c_113(.A(y22[4]),.B(y12[12]),.Cin(y21[12]),.Y(s_1[12]),.Cout(c_1[12]));
    csa_dadda c_114(.A(y22[5]),.B(y12[13]),.Cin(y21[13]),.Y(s_1[13]),.Cout(c_1[13]));
    csa_dadda c_115(.A(y22[6]),.B(y12[14]),.Cin(y21[14]),.Y(s_1[14]),.Cout(c_1[14]));
    csa_dadda c_116(.A(y22[7]),.B(y12[15]),.Cin(y21[15]),.Y(s_1[15]),.Cout(c_1[15]));
    
//Stage 2 - reducing fom 2 to 1
        // adding total sum and carry to get final output
    HA h1(.a(s_1[1]),.b(c_1[0]),.Sum(Y[9]),.Cout(c_2[0]));


    csa_dadda c_22(.A(s_1[2]),.B(c_1[1]),.Cin(c_2[0]),.Y(Y[10]),.Cout(c_2[1]));
    csa_dadda c_23(.A(s_1[3]),.B(c_1[2]),.Cin(c_2[1]),.Y(Y[11]),.Cout(c_2[2]));
    csa_dadda c_24(.A(s_1[4]),.B(c_1[3]),.Cin(c_2[2]),.Y(Y[12]),.Cout(c_2[3]));
    csa_dadda c_25(.A(s_1[5]),.B(c_1[4]),.Cin(c_2[3]),.Y(Y[13]),.Cout(c_2[4]));
    csa_dadda c_26(.A(s_1[6]),.B(c_1[5]),.Cin(c_2[4]),.Y(Y[14]),.Cout(c_2[5]));
    csa_dadda c_27(.A(s_1[7]),.B(c_1[6]),.Cin(c_2[5]),.Y(Y[15]),.Cout(c_2[6]));
    csa_dadda c_28(.A(s_1[8]),.B(c_1[7]),.Cin(c_2[6]),.Y(Y[16]),.Cout(c_2[7]));
    csa_dadda c_29(.A(s_1[9]),.B(c_1[8]),.Cin(c_2[7]),.Y(Y[17]),.Cout(c_2[8]));
    csa_dadda c_210(.A(s_1[10]),.B(c_1[9]),.Cin(c_2[8]),.Y(Y[18]),.Cout(c_2[9]));
    csa_dadda c_211(.A(s_1[11]),.B(c_1[10]),.Cin(c_2[9]),.Y(Y[19]),.Cout(c_2[10]));
    csa_dadda c_212(.A(s_1[12]),.B(c_1[11]),.Cin(c_2[10]),.Y(Y[20]),.Cout(c_2[11]));
    csa_dadda c_213(.A(s_1[13]),.B(c_1[12]),.Cin(c_2[11]),.Y(Y[21]),.Cout(c_2[12]));
    csa_dadda c_214(.A(s_1[14]),.B(c_1[12]),.Cin(c_2[12]),.Y(Y[22]),.Cout(c_2[13]));
    csa_dadda c_215(.A(s_1[15]),.B(c_1[14]),.Cin(c_2[13]),.Y(Y[23]),.Cout(c_2[14]));
    csa_dadda c_216(.A(y22[8]),.B(c_1[15]),.Cin(c_2[14]),.Y(Y[24]),.Cout(c_2[15]));

    HA h2(.a(y22[9]),.b(c_2[15]),.Sum(Y[25]),.Cout(c_2[16]));
    HA h3(.a(y22[10]),.b(c_2[16]),.Sum(Y[26]),.Cout(c_2[17]));
    HA h4(.a(y22[11]),.b(c_2[17]),.Sum(Y[27]),.Cout(c_2[18]));
    HA h5(.a(y22[12]),.b(c_2[18]),.Sum(Y[28]),.Cout(c_2[19]));
    HA h6(.a(y22[13]),.b(c_2[19]),.Sum(Y[29]),.Cout(c_2[20]));
    HA h7(.a(y22[14]),.b(c_2[20]),.Sum(Y[30]),.Cout(c_2[21]));
    HA h8(.a(y22[15]),.b(c_2[21]),.Sum(Y[31]),.Cout(c_2[22]));
    
    
    
endmodule


module ALU_multi(A,B,Y,carryout,overflow,zero,N);//???§Ô??

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