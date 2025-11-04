
module rom (
    input  logic        clk,
    input  logic [7:0]  addr,
    output logic [7:0]  data
);

    logic [7:0] mem [255:0]; //8 bit rom, matches sinerom.mem

    initial begin
        $readmemh("sinerom.mem", mem);
    end

    always_ff @(posedge clk) begin //synchronous
        data <= mem[addr]; //updata data w memory address on positive clock edge
    end

endmodule

