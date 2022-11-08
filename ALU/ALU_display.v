module alu_display(
    //时钟与复位信号
    input clk,
    input resetn,
    input [1:0] input_sel,//对应op
    input [1:0] input_sel1,

    
    
    //触摸屏相关接口，不需要更改
    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout[15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn
    );
//-----{调用ALU模块}begin
    reg   [3:0] alu_control;  // ALU控制信号op
    /*
    00 = adder
    01 = weiyi
    10 = Logic
    11 = multi
    */
    reg   [3:0] alu_control1; //op1
    reg   [31:0] alu_src1;     // ALU操作数1
    reg   [31:0] alu_src2;     // ALU操作数2
    wire  [31:0] alu_result;   // ALU结果
    wire  overflow;
    wire  carryout;
    wire  zero;
    wire  N;
    ALU32 ALU32(
        .op     (alu_control),
        .op1    (alu_control1),
        .in0    (alu_src1),
        .in1    (alu_src2),
        .out    (alu_result),
        .zero   (zero),
        .overflow   (overflow),
        .carryout   (carryout),
        .N          (N)
    );
//-----{调用ALU模块}end
//---------------------{调用触摸屏模块}begin--------------------//
//-----{实例化触摸屏}begin
//此小节不需要更改
    reg         display_valid;
    reg  [39:0] display_name;
    reg  [31:0] display_value;
    wire [5 :0] display_number;
    wire        input_valid;
    wire [31:0] input_value;

    lcd_module lcd_module(
        .clk            (clk           ),   //10Mhz
        .resetn         (resetn        ),

        //调用触摸屏的接口
        .display_valid  (display_valid ),
        .display_name   (display_name  ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid   ),
        .input_value    (input_value   ),

        //lcd触摸屏相关接口，不需要更改
        .lcd_rst        (lcd_rst       ),
        .lcd_cs         (lcd_cs        ),
        .lcd_rs         (lcd_rs        ),
        .lcd_wr         (lcd_wr        ),
        .lcd_rd         (lcd_rd        ),
        .lcd_data_io    (lcd_data_io   ),
        .lcd_bl_ctr     (lcd_bl_ctr    ),
        .ct_int         (ct_int        ),
        .ct_sda         (ct_sda        ),
        .ct_scl         (ct_scl        ),
        .ct_rstn        (ct_rstn       )
    ); 
//-----{实例化触摸屏}end

//-----{从触摸屏获取输入}begin
//根据实际需要输入的数修改此小节，
//建议对每一个数的输入，编写单独一个always块
    //当input_sel为00时，表示输入op信号，即alu_control
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            alu_control <= 12'd0;
        end
        else if (input_valid && input_sel==2'b00)
        begin
            alu_control <= input_value[3:0];
        end
    end 
/*
    always @(posedge clk)
    begin
        case(alu_control)
        4'b0000:
        begin
          ALU32.O = 0;
        end
        4'b0001:
           ALU32.O = 1;
        4'b0010:
             ALU32.O = 2;
        4'b0011:
             ALU32.O = 3;
        default:;
        endcase

    end
*/
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            alu_control1 <= 12'd0;
        end
        else if (input_valid && input_sel==2'b01)
        begin
            alu_control1 <= input_value[3:0];
        end
    end
    
    //当input_sel为10时，表示输入数为源操作数1，即alu_src1,in0
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            alu_src1 <= 32'd0;
        end
        else if (input_valid && input_sel==2'b10)
        begin
            alu_src1 <= input_value;
        end
    end

    //当input_sel为11时，表示输入数为源操作数2，即alu_src2
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            alu_src2 <= 32'd0;
        end
        else if (input_valid && input_sel==2'b11)
        begin
            alu_src2 <= input_value;
        end
    end
//-----{从触摸屏获取输入}end

//-----{输出到触摸屏显示}begin
//根据需要显示的数修改此小节，
//触摸屏上共有44块显示区域，可显示44组32位数据
//44块显示区域从1开始编号，编号为1~44，
    always @(posedge clk)
    begin
        case(display_number)
            10'd1 :
            begin
                display_valid <= 1'b1;
                display_name  <= "IN0";
                display_value <= alu_src1;
            end
            10'd2 :
            begin
                display_valid <= 1'b1;
                display_name  <= "IN1";
                display_value <= alu_src2;
            end
            10'd3 :
            begin
                display_valid <= 1'b1;
                display_name  <= "OUT";
                display_value <= alu_result;
            end
            10'd4 :
            begin
                display_valid <= 1'b1;
                display_name  <= "OP";
                display_value <= alu_control;
            end
            10'd5 :
            begin
                display_valid <= 1'b1;
                display_name  <= "OP1";
                display_value <= alu_control1;
            end
            10'd6 :
            begin
                
                display_valid <= 1'b1;
                display_name  <= "OV";
                display_value <= overflow;
            end
            10'd7 :
            begin
                display_valid <= 1'b1;
                display_name  <= "ZO";
                display_value <= zero;
            end
            10'd8 :
            begin
                display_valid <= 1'b1;
                display_name  <= "CO";
                display_value <= carryout;
            end
            10'd9:
            begin
                display_valid <= 1'b1;
                display_name  <= "N";
                display_value <= N;
            end
            default :
            begin
                display_valid <= 1'b0;
                display_name  <= 40'd0;
                display_value <= 32'd0;
            end
        endcase
    end
//-----{输出到触摸屏显示}end
//----------------------{调用触摸屏模块}end---------------------//
endmodule