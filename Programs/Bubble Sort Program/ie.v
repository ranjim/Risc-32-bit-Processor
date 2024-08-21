module register #(parameter WIDTH = 32)
(
    input clk, rin, rout1, rout2,
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout1, dout2
);

reg signed [WIDTH-1:0] data;

always @(posedge clk) begin
    if (rin) data <= din;

    if (rout1) dout1 <= data;
    else dout1 <= 32'bz;

    if (rout2) dout2 <= data;
    else dout2 <= 32'bz;
end

initial begin
    data <= 0;
end

endmodule

module addr_decoder_5x32
(
    input en,
    input [4:0] in,
    output reg [31:0] out
);

always @(*) begin
    if (en) begin
        case (in)
            5'b00000 : out <= {31'b0, 1'b1};
            5'b00001 : out <= {30'b0, 1'b1, 1'b0};
            5'b00010 : out <= {29'b0, 1'b1, 2'b0};
            5'b00011 : out <= {28'b0, 1'b1, 3'b0};
            5'b00100 : out <= {27'b0, 1'b1, 4'b0};
            5'b00101 : out <= {26'b0, 1'b1, 5'b0};
            5'b00110 : out <= {25'b0, 1'b1, 6'b0};
            5'b00111 : out <= {24'b0, 1'b1, 7'b0};
            5'b01000 : out <= {23'b0, 1'b1, 8'b0};
            5'b01001 : out <= {22'b0, 1'b1, 9'b0};
            5'b01010 : out <= {21'b0, 1'b1, 10'b0};
            5'b01011 : out <= {20'b0, 1'b1, 11'b0};
            5'b01100 : out <= {19'b0, 1'b1, 12'b0};
            5'b01101 : out <= {18'b0, 1'b1, 13'b0};
            5'b01110 : out <= {17'b0, 1'b1, 14'b0};
            5'b01111 : out <= {16'b0, 1'b1, 15'b0};
            5'b10000 : out <= {15'b0, 1'b1, 16'b0};
            5'b10001 : out <= {14'b0, 1'b1, 17'b0};
            5'b10010 : out <= {13'b0, 1'b1, 18'b0};
            5'b10011 : out <= {12'b0, 1'b1, 19'b0};
            5'b10100 : out <= {11'b0, 1'b1, 20'b0};
            5'b10101 : out <= {10'b0, 1'b1, 21'b0};
            5'b10110 : out <= {9'b0, 1'b1, 22'b0};
            5'b10111 : out <= {8'b0, 1'b1, 23'b0};
            5'b11000 : out <= {7'b0, 1'b1, 24'b0};
            5'b11001 : out <= {6'b0, 1'b1, 25'b0};
            5'b11010 : out <= {5'b0, 1'b1, 26'b0};
            5'b11011 : out <= {4'b0, 1'b1, 27'b0};
            5'b11100 : out <= {3'b0, 1'b1, 28'b0};
            5'b11101 : out <= {2'b0, 1'b1, 29'b0};
            5'b11110 : out <= {1'b0, 1'b1, 30'b0};
            5'b11111 : out <= {1'b1, 31'b0};
        endcase
    end
    else out <= 32'b0;
end

endmodule


module register_bank #(parameter ADDR_WIDTH = 5, WIDTH = 32)
(
    input clk,
    input read_port_1, read_port_2, write_port,
    input [ADDR_WIDTH-1:0] addr_port_1, addr_port_2, addr_port_write,
    input [WIDTH-1:0] din_port_write,
    output [WIDTH-1:0] dout_port_1, dout_port_2
);

wire [WIDTH-1:0] rin, rout1, rout2;

addr_decoder_5x32 D1 (read_port_1, addr_port_1, rout1);
addr_decoder_5x32 D2 (read_port_2, addr_port_2, rout2);
addr_decoder_5x32 D3 (write_port, addr_port_write, rin);

register R0 (clk, 1'b1, rout1[0], rout2[0], 32'b0, dout_port_1, dout_port_2);
register R1 (clk, rin[1], rout1[1], rout2[1], din_port_write, dout_port_1, dout_port_2);
register R2 (clk, rin[2], rout1[2], rout2[2], din_port_write, dout_port_1, dout_port_2);
register R3 (clk, rin[3], rout1[3], rout2[3], din_port_write, dout_port_1, dout_port_2);
register R4 (clk, rin[4], rout1[4], rout2[4], din_port_write, dout_port_1, dout_port_2);
register R5 (clk, rin[5], rout1[5], rout2[5], din_port_write, dout_port_1, dout_port_2);
register R6 (clk, rin[6], rout1[6], rout2[6], din_port_write, dout_port_1, dout_port_2);
register R7 (clk, rin[7], rout1[7], rout2[7], din_port_write, dout_port_1, dout_port_2);
register R8 (clk, rin[8], rout1[8], rout2[8], din_port_write, dout_port_1, dout_port_2);
register R9 (clk, rin[9], rout1[9], rout2[9], din_port_write, dout_port_1, dout_port_2);
register R10 (clk, rin[10], rout1[10], rout2[10], din_port_write, dout_port_1, dout_port_2);
register R11 (clk, rin[11], rout1[11], rout2[11], din_port_write, dout_port_1, dout_port_2);
register R12 (clk, rin[12], rout1[12], rout2[12], din_port_write, dout_port_1, dout_port_2);
register R13 (clk, rin[13], rout1[13], rout2[13], din_port_write, dout_port_1, dout_port_2);
register R14 (clk, rin[14], rout1[14], rout2[14], din_port_write, dout_port_1, dout_port_2);
register R15 (clk, rin[15], rout1[15], rout2[15], din_port_write, dout_port_1, dout_port_2);
register R16 (clk, rin[16], rout1[16], rout2[16], din_port_write, dout_port_1, dout_port_2);

register SP (clk, rin[31], rout1[31], rout2[32], din_port_write, dout_port_1, dout_port_2);

endmodule

module andop (a, b, r);
    parameter W = 32;
    input [W-1:0] a, b;
    output [W-1:0] r;
    assign r = a & b;
endmodule


module notop (a, r);
    parameter W = 32;
    input [W-1:0] a;
    output [W-1:0] r;
    assign r = ~a;
endmodule


module orop (a, b, r);
    parameter W = 32;
    input [W-1:0] a, b;
    output [W-1:0] r;
    assign r = a | b;
endmodule


module slaop (a, b, r);
    parameter W = 32;
    input [W-1:0] a, b;
    output [W-1:0] r;
    assign r = (b[0] == 1) ? (a << 1) : a;
endmodule


module sraop (a, b, r);
    parameter W = 32;
    input [W-1:0] a, b;
    output [W-1:0] r;
    assign r = (b[0] == 1) ? (a >> 1)|{{a[31]}, 31'b0} : a;
endmodule


module srlop ( a, b, r );
    parameter W = 32;
    input [W-1:0] a, b;
    output [W-1:0] r;
    assign r = (b[0] == 1) ? (a >> 1) : a;
endmodule


module subop ( a, b, r );
    parameter W = 32;
    input [W-1:0] a, b;
    output [W-1:0] r;
    assign r = a - b;
endmodule


module xorop ( a, b, r );
    parameter W = 32;
    input [W-1:0] a, b;
    output [W-1:0] r;
    assign r = a ^ b;
endmodule


module addop (a, b, r);
    parameter W = 32;
    input [W-1:0] a, b;
    output [W-1:0] r;
    assign r = a + b;
endmodule


module alu #(parameter WIDTH = 32)
(
    input clk,
    input [3:0] opcode,
    input [WIDTH-1:0] A, B,
    output reg [WIDTH-1:0] R
);

wire [WIDTH-1:0] add_result, sub_result, and_result, or_result, xor_result, not_result, sla_result, sra_result, srl_result;

addop add_unit (A, B, add_result);
subop sub_unit (A, B, sub_result);
andop and_unit (A, B, and_result);
orop or_unit (A, B, or_result);
xorop xor_unit (A, B, xor_result);
notop not_unit (A, not_result);
slaop sla_unit (A, B, sla_result);
sraop sra_unit (A, B, sra_result);
srlop srl_unit (A, B, srl_result);

always @(*)
begin
    case (opcode)
        4'b0000: R <= add_result;
        4'b0001: R <= sub_result;
        4'b0010: R <= and_result;
        4'b0011: R <= or_result;
        4'b0100: R <= xor_result;
        4'b0101: R <= not_result;
        4'b0110: R <= sla_result;
        4'b0111: R <= sra_result;
        4'b1000: R <= srl_result;
        4'b1001: R <= A;
        
        4'b1010: R <= B - 1; // PUSH
        4'b1011: R <= B + 1; // POP
        4'b1100: R <= B; // Get B
        default: R <= 0;
    endcase
end

endmodule

module bram #(parameter BRAM_ADDR_WIDTH = 10, BRAM_DATA_WIDTH = 32) (
    input clk, 
    input [BRAM_ADDR_WIDTH-1:0] addr, 
    input en_w, 
    input en_r,
    input [BRAM_DATA_WIDTH-1:0] bram_data_in,
    output reg [BRAM_DATA_WIDTH-1:0] bram_data_out
);



    reg [BRAM_DATA_WIDTH-1:0] mem [(1<<BRAM_ADDR_WIDTH)-1:0];

    always @(posedge clk)
        begin
            if (en_w == 1'b1) mem[(addr)] <= bram_data_in;
            if (en_r == 1'b1) bram_data_out <= mem[addr];
        end
endmodule

module instruction_executor (
    input clk,
    input [31:0] pc, instruction,
    output reg [31:0] npc
);

parameter ADDR_WIDTH = 5; 
parameter WIDTH = 32;

wire signed [31:0] A, B, R;
wire signed [31:0] ImmOrA, write_data, M;

reg signed [31:0] Imm;
reg [4:0] rs1, rs2, rd;

// Register Bank

// Control signals  
reg en_rp1, en_rp2, en_wp;

// Instance
register_bank #(ADDR_WIDTH, WIDTH) RB (
    .clk(clk),
    .read_port_1(en_rp1), .read_port_2(en_rp2), .write_port(en_wp),
    .addr_port_1(rs1), .addr_port_2(rs2), .addr_port_write(rd),
    .din_port_write(write_data),
    .dout_port_1(A), .dout_port_2(B)
);

reg selA; // Control Signal
assign ImmOrA = (selA == 1) ? A : Imm;

// ALU

reg [3:0] alu_opcode;

// Instance
alu #(WIDTH) ALU (
    .clk(clk),
    .opcode(alu_opcode),
    .A(ImmOrA), .B(B),
    .R(R)
);

reg selR; // Control Signal
assign write_data = (selR == 1) ? R : M;

// Memory

// Control Signals
reg we, re;

wire [31:0] Addr;
assign Addr = B + Imm;

// Instance
bram #(10, 32) DM(
    .clk(clk),
    .addr(Addr[9:0]),
    .en_w(we),
    .en_r(re),
    .bram_data_in(A),
    .bram_data_out(M)
);

wire [2:0] opcode, func;
assign opcode = instruction[31:29];
assign func = instruction[28:26];

always @(posedge clk) begin

    npc <= pc + 1;
    case(opcode)
        
        3'b000: begin // NOP AND HALT
            case(func[2])
                0: begin // NOP
                    en_rp1 <= 0;
                    en_rp2 <= 0;
                    en_wp <= 0;
                    we <= 0;
                    re <= 0;
                    selA <= 0;
                    selR <= 0;
                    alu_opcode <= 4'b1001;
                end

                1: begin // HALT
                    en_rp1 <= 0;
                    en_rp2 <= 0;
                    en_wp <= 0;
                    we <= 0;
                    re <= 0;
                    selA <= 0;
                    selR <= 0;
                    alu_opcode <= 4'b1001;
                end
            endcase
        end

        3'b001: begin // ALU 
            
            rd <= instruction[4:0];
            rs1 <= instruction[9:5];
            rs2 <= instruction[14:10];
            en_rp1 <= 1;
            en_rp2 <= 1;
            en_wp <= 1;
            selA <= 1;
            selR <= 1;

            case(func)
                0: alu_opcode <= 4'b0000;
                1: alu_opcode <= 4'b0001;
                2: alu_opcode <= 4'b0010;
                3: alu_opcode <= 4'b0011;
                4: alu_opcode <= 4'b0100;
                5: alu_opcode <= 4'b0110;
                6: alu_opcode <= 4'b0111;
                7: alu_opcode <= 4'b1000;
            endcase
        end

        3'b010: begin // ALU IMMEDIATE
            
            rd <= instruction[4:0];
            rs2 <= instruction[9:5];
            Imm <= {{17{instruction[25]}}, instruction[24:10]};
            en_rp2 <= 1;
            en_rp1 <= 0;
            en_wp <= 1;
            selA <= 0;
            selR <= 1;

            case(func)
                0: alu_opcode <= 4'b0000;
                1: alu_opcode <= 4'b0001;
                2: alu_opcode <= 4'b0010;
                3: alu_opcode <= 4'b0011;
                4: alu_opcode <= 4'b0100;
                5: alu_opcode <= 4'b0110;
                6: alu_opcode <= 4'b0111;
                7: alu_opcode <= 4'b1000;
            endcase

        end

        3'b011: begin // NOT INSTRUCTION

            rd <= instruction[4:0];
            alu_opcode <= 4'b0101;
            en_wp <= 1;

            case(func)
                0: begin // NOT
                    rs1 <= instruction[9:5];
                    en_rp1 <= 1;
                    selA <= 1;
                end

                1: begin // NOTI
                    Imm <= {{17{instruction[25]}}, instruction[24:10]};
                    selA <= 0;
                end
            endcase

        end

        3'b100: begin // LOAD STORE INSTRUCTIONS

            rs2 <= instruction[9:5];
            en_rp2 <= 1;
            Imm <= {{17{instruction[25]}}, instruction[24:10]};

            case(func[2:1])
                0: // LOAD
                    begin
                        rd <= instruction[4:0];
                        en_wp <= 1;
                        selR <= 0;
                        we <= 0;
                        re <= 1;
                    end
                    
                3: // STORE
                    begin
                        rs1 <= instruction[4:0];
                        en_rp1 <= 1;
                        en_wp <= 0;
                        we <= 1;
                        re <= 0;
                    end
                
                1: // LOAD STACK
                    begin
                        rd <= 5'b11111;
                        en_wp <= 1;
                        selR <= 0;
                        we <= 0;
                        re <= 1;
                    end
                
                2: // STORE STACK
                    begin
                        rs1 <= 5'b11111;
                        en_rp1 <= 1;
                        en_wp <= 0;
                        we <= 1;
                        re <= 0;
                    end
            endcase
        end

        3'b101: begin
            rs2 <= instruction[4:0];
            en_rp2 <= 1;
            en_rp1 <= 0;
            en_wp <= 0;
            
            case(func[2:1])
                0: begin // BZ R==0
                    if (B == 0) npc <= instruction[26:5];
                    else npc <= pc + 1;
                end

                1: begin // BMI R<0
                    if (B < 0) npc <= instruction[26:5];
                    else npc <= pc + 1;
                end

                2: begin // BPL R>0
                    if (B > 0) npc <= instruction[26:5];
                    else npc <= pc + 1;
                end
                    
                3: begin // Branch Unconditional
                    npc <= instruction[26:5];
                end
            endcase
        end

        3'b110: begin
        
            case(func[2:1])
            
                2'b10: begin // Push
                    rs1 <= 5'b11111;
                    en_rp1 <= 1;
                    en_wp <= 1;
                    selA <= 1;
                    alu_opcode <= 4'b1010;
                end

                2'b01: begin // Pop
                    rs1 <= 5'b11111;
                    en_rp1 <= 1;
                    en_wp <= 1;
                    selA <= 1;
                    alu_opcode <= 4'b1011;
                end

                2'b11: begin // Call
                    rs1 <= 5'b11111;
                    en_rp1 <= 1;
                    en_wp <= 1;
                    selA <= 1;
                    alu_opcode <= 4'b1010;
                    npc <= pc + {{17{instruction[25]}}, instruction[24:10]};
                end

                2'b00: begin // Return
                    rs1 <= 5'b11111;
                    en_rp1 <= 1;
                    npc <= A;
                end
            
            endcase
        
        end

        3'b111: begin // MOVE
            rs1 <= instruction[9:5];
            rd <= instruction[4:0];
            en_rp1 <= 1;
            en_wp <= 1;
            selA <= 1;
            alu_opcode <= 4'b1001;
            selR <= 1;
        end

    endcase

end

endmodule