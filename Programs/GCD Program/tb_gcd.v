`include "cpu_gcd.v"

module testbench ();

reg clk;

cpu CPU (
    .clk(clk)
);

always begin
    #10 clk = ~clk;
end

initial begin
    clk = 0;
end

endmodule