`include "ie.v"
`include "inst_gcd.v"

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
        $display("r1 = %4d, r2 = %4d, r3 = %4d; PC = %2d", IE.RB.R1.data, IE.RB.R2.data, IE.RB.R3.data, pc);
    end
    else begin
        $display("\nGCD of %4d and %4d is %4d.", IE.RB.R13.data, IE.RB.R14.data, IE.RB.R15.data);
        $finish;
    end
    
end

initial begin
    slow_clk <= 0;
    slower_clk <= 0;
    pc <= 0;
end

endmodule