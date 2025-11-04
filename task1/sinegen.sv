module sinegen(
    input  logic        clk,    // system clock
    input  logic        rst,    // system reset
    input  logic        en,     // enable signal
    input  logic [7:0]  incr,   // address input
    output logic [7:0]  dout // output signal

);

    // add counter
    logic [7:0] addr;
    counter #(.WIDTH(8)) u_counter (
        .clk(clk),
        .rst(rst),
        .en(en),
        .incr(incr),
        .count(addr)
    );

    // add ROM
    logic [7:0] data;
    rom u_rom (
        .clk(clk),
        .addr(addr),
        .data(data)
    );

    // assign output
    assign dout = data;
endmodule

