module alu_display(
    //ʱ���븴λ�ź�
    input clk,
    input resetn,
    input [1:0] input_sel,//��Ӧop
    input [1:0] input_sel1,

    
    
    //��������ؽӿڣ�����Ҫ����
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
//-----{����ALUģ��}begin
    reg   [3:0] alu_control;  // ALU�����ź�op
    /*
    00 = adder
    01 = weiyi
    10 = Logic
    11 = multi
    */
    reg   [3:0] alu_control1; //op1
    reg   [31:0] alu_src1;     // ALU������1
    reg   [31:0] alu_src2;     // ALU������2
    wire  [31:0] alu_result;   // ALU���
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
//-----{����ALUģ��}end
//---------------------{���ô�����ģ��}begin--------------------//
//-----{ʵ����������}begin
//��С�ڲ���Ҫ����
    reg         display_valid;
    reg  [39:0] display_name;
    reg  [31:0] display_value;
    wire [5 :0] display_number;
    wire        input_valid;
    wire [31:0] input_value;

    lcd_module lcd_module(
        .clk            (clk           ),   //10Mhz
        .resetn         (resetn        ),

        //���ô������Ľӿ�
        .display_valid  (display_valid ),
        .display_name   (display_name  ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid   ),
        .input_value    (input_value   ),

        //lcd��������ؽӿڣ�����Ҫ����
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
//-----{ʵ����������}end

//-----{�Ӵ�������ȡ����}begin
//����ʵ����Ҫ��������޸Ĵ�С�ڣ�
//�����ÿһ���������룬��д����һ��always��
    //��input_selΪ00ʱ����ʾ����op�źţ���alu_control
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
    
    //��input_selΪ10ʱ����ʾ������ΪԴ������1����alu_src1,in0
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

    //��input_selΪ11ʱ����ʾ������ΪԴ������2����alu_src2
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
//-----{�Ӵ�������ȡ����}end

//-----{�������������ʾ}begin
//������Ҫ��ʾ�����޸Ĵ�С�ڣ�
//�������Ϲ���44����ʾ���򣬿���ʾ44��32λ����
//44����ʾ�����1��ʼ��ţ����Ϊ1~44��
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
//-----{�������������ʾ}end
//----------------------{���ô�����ģ��}end---------------------//
endmodule