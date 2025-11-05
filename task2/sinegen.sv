module sinegen(
    input  logic        clk,    // system clock
    input  logic        rst,    // system reset
    input  logic        en,     // enable signal
    input  logic [7:0]  incr,   // address input
    input logic  [7:0]  offset, // offset between 2 sine waves
    output logic [7:0]  dout1, // output signal 1
    output logic [7:0]  dout2 //output signal 2

);

    // add counter
    logic [7:0] addr1;
    logic [7:0] addr2;
    counter #(.WIDTH(8)) u_counter (
        .clk(clk),
        .rst(rst),
        .en(en),
        .incr(incr),
        .count(addr1) //initial wave
    );

    assign addr2 = addr1 + offset; 

    // add ROM
    logic [7:0] data;
    rom u_rom (
        .clk(clk),
        .addr1(addr1),
        .data1(dout1),
        .addr2(addr2),
        .data2(dout2)
    );

endmodule

