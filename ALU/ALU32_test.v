module ALU32_test(

    );
    reg [10:0] op;
    reg [31:0] in0,in1;
    wire [31:0] out;
    wire carryout,overflow,zero;
    ALU32 alu(op,in0,in1,carryout,overflow,zero,out);
    initial
    begin
    //add
         op=11'b00000100000;        
         in0=32'hf2340000;
         in1=32'h80000000;
    #20  in0=32'h7fffffff;
         in1=32'h70000001;
    #20  in0=32'h7fffffff;
         in1=32'hf0000001;
    #20  in0=32'hffffffff;
         in1=32'h00000001;
    //addu          
    #20  op=11'b00000100001;   
         in0=32'hf2340000;
         in1=32'h80000000;
    #20  in0=32'h7fffffff;
         in1=32'h70000001;
    #20  in0=32'hffffffff;
         in1=32'h00000001;
    //sub    
    #20  op=11'b00000100010;        
         in0=32'h72340000;
         in1=32'h60000000;
    #20  in0=32'h7fffffff;
         in1=32'hf0000001;
    #20  in0=32'hf00fffff;
         in1=32'h7ffffff1;
    #20  in0=32'hffffffff;
         in1=32'hffffffff;
    #20  in0=32'hf0000000;
         in1=32'h0fffffff; 
    //subu
    #20  op=11'b00000100011;        
         in0=32'h72340000;
         in1=32'h60000000;
    #20  in0=32'h7fffffff;
         in1=32'hf0000001;
    #20  in0=32'hffffffff;
         in1=32'hffffffff;
    #20  in0=32'hf0000000;
         in1=32'h0fffffff; 
    //and
    #20  op=11'b00000100100;        
         in0=32'h72340000;
         in1=32'h60000000;
    #20  in0=32'h7fffffff;
         in1=32'h00000000; 
    //or
    #20  op=11'b00000100101;        
         in0=32'h00000000;
         in1=32'h00000000;
    #20  in0=32'h7fffffff;
         in1=32'hf0000001;
    //xor
    #20  op=11'b00000100110;        
         in0=32'ha0000000;
         in1=32'h50000000;
    #20  in0=32'h7fffffff;
         in1=32'hf0000001;
    //nor
    #20  op=11'b00000100111;        
         in0=32'h123451ff;
         in1=32'h60000000;
    #20  in0=32'h7fffffff;
         in1=32'hf0000001;
    //slt
    #20  op=11'b00000101010;        
         in0=32'h72340000;
         in1=32'hf0000000;
    #20  in0=32'h7000000f;
         in1=32'h7f000001;
    #20  in0=32'hf0001231;
         in1=32'h7ac34545;
    //sltu
    #20  op=11'b00000101011;        
         in0=32'h72340000;
         in1=32'hf0000000;
    #20  in0=32'h7000000f;
         in1=32'h7f000001;
    #20  in0=32'hf0001231;
         in1=32'h7ac34545;
    //shl
    #20  op=11'b00000000100;
         in0=32'hffffffff;
         in1=32'd5;
    //shr
    #20  op=11'b00000000110;
         in0=32'hffffffff;
         in1=32'd5;
    //sar
    #20  op=11'b00000000111;
         in0=32'hffffffff;
         in1=32'd3;
    #20  in0=32'h0fffffff;
         in1=32'd5;
    end

initial
begin
   $dumpfile("ALU32.vcd");
   $dumpvars(0,ALU32_test);
end
endmodule

