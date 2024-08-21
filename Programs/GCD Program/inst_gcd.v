module programs (
    input clk,
    input en_read,
    input [31:0] pc,
    output reg [31:0] inst
);

parameter HALT = 0;
parameter NOP = 32'b00010000000000000000000000000000;

// define memory of 32 words of 32 bits each
reg [31:0] mem [0:31];

initial begin

    // Store the 2 numbers in R13 and R14 whose GCD is to be calculated.
    // R13 = 15 ; R14 = 3
    mem[0] <= NOP;
    mem[1] <= {3'b010, 3'b000, 16'b0000000000001111, 5'b00000, 5'b01101}; // 15 in R13
    mem[2] <= {3'b111, 19'b0000000000000000000, 5'b01101, 5'b00001}; // R1 <- R13
    mem[3] <= {3'b010, 3'b000, 16'b0000000000000011, 5'b00000, 5'b01110}; // 3 in R14
    mem[4] <= {3'b111, 19'b0000000000000000000, 5'b01110, 5'b00010}; // R2 <- R14
    
    // Now calculate the GCD of the 2 numbers.
    
    // LABEL Line 5 : comparator
    mem[5] <= NOP;
    mem[6] <= {3'b001, 3'b001, 11'b00000000000, 5'b00010, 5'b00001, 5'b00011}; // R3 <- R1 - R2
    mem[7] <= {3'b101, 2'b00, 22'b0000000000000000010011, 5'b00011}; // if R3 == 0 jump to result

    mem[8] <= NOP;
    mem[9] <= {3'b101, 2'b10, 22'b0000000000000000001101, 5'b00011}; // if R3 > 0 jump to a - b
    mem[11] <= {3'b101, 2'b01, 22'b0000000000000000010000, 5'b00011}; // if R3 < 0 jump to b - a

    // LABEL Line 12 : a - b

    mem[13] <= NOP;
    mem[14] <= {3'b111, 19'b0000000000000000000, 5'b00011, 5'b00001}; // R1 <- R3
    mem[15] <= {3'b101, 2'b11, 22'b0000000000000000000101, 5'b00011}; // unconditional jump to comparator

    // LABEL Line 16 : b - a
    mem[16] <= NOP;
    mem[17] <= {3'b001, 3'b001, 11'b00000000000, 5'b00011, 5'b00000, 5'b00010}; // R2 <- R0 - R3
    mem[18] <= {3'b101, 2'b11, 22'b0000000000000000000101, 5'b00011}; // unconditional jump to comparator

    // LABEL Line 19 : result
    mem[19] <= NOP;
    mem[20] <= {3'b111, 19'b0000000000000000000, 5'b00001, 5'b01111}; // R15 <- R1
    mem[21] <= NOP;
    mem[22] <= HALT;
end

always @(posedge clk) begin
    if (en_read) begin
        inst <= mem[pc];
    end
end

endmodule