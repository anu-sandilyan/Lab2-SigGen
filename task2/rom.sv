
module rom (
    input  logic        clk,
    input  logic [7:0]  addr1, //port 1 addr
    output logic [7:0]  data1, //port 1 data
    input  logic [7:0]  addr2, // port 2 addr
    output logic [7:0]  data2  // port 2 data
);

    logic [7:0] mem [255:0]; //8 bit rom, matches sinerom.mem

    initial begin
        $readmemh("sinerom.mem", mem);
    end

    always_ff @(posedge clk) begin //synchronous
        data1 <= mem[addr1];
        data2 <= mem[addr2]; //updata data w memory address on positive clock edge
    end

endmodule
