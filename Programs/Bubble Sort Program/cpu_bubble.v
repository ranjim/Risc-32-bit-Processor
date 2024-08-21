`include "ie.v"
`include "inst_bubble.v"

module cpu (
    input clk
);

// Special instructions

parameter HALT = 0;
parameter NOP = 32'b00010000000000000000000000000000;

// Registers

reg [31:0] pc;
wire [31:0] npc;

wire [31:0] inst;

programs IM (
    .clk(clk),
    .en_read(1'b1),
    .pc(pc),
    .inst(inst)
);

instruction_executor IE (
    .clk(clk),
    .pc(pc),
    .instruction(inst),
    .npc(npc)
);

reg slow_clk;

always @(posedge clk) begin
    slow_clk <= ~slow_clk;
end

reg slower_clk;

always @(posedge slow_clk) begin
    slower_clk <= ~slower_clk;
end

always @(posedge slower_clk) begin
    if (inst != HALT) begin
        pc <= npc;
        $display("%4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d : pc = %4d : r14 = %4d : r15 = %4d", IE.RB.R1.data, IE.RB.R2.data, IE.RB.R3.data, IE.RB.R4.data, IE.RB.R5.data, IE.RB.R6.data, IE.RB.R7.data, IE.RB.R8.data, IE.RB.R9.data, IE.RB.R10.data, pc, IE.RB.R14.data, IE.RB.R15.data);
    end
    else begin
        $display("\nSorted Array of 10 numbers is:");
        $display("%4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d", IE.RB.R1.data, IE.RB.R2.data, IE.RB.R3.data, IE.RB.R4.data, IE.RB.R5.data, IE.RB.R6.data, IE.RB.R7.data, IE.RB.R8.data, IE.RB.R9.data, IE.RB.R10.data);
        $finish;
    end
    
end

initial begin
    slow_clk <= 0;
    slower_clk <= 0;
    pc <= 0;
end

endmodule