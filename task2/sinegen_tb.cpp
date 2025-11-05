#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsinegen.h"
#include "vbuddy.cpp"     // include vbuddy code
#define NO_OF_CYCLES 1000000
#define ADDRESS_WIDTH 8
#define ROM_SZ 256

int main(int argc, char **argv, char **env){
    int i;
    int clktick;


Verilated::commandArgs(argc, argv);
//init top verilog instance
Vsinegen* top = new Vsinegen;
//init trace dump 
Verilated::traceEverOn(true);
VerilatedVcdC* tfp = new VerilatedVcdC;
top->trace (tfp, 99);
tfp->open ("sinegen.vcd");

//init vbuddy
if(vbdOpen() != 1) return -1;
vbdHeader("Lab 2: Dual Sinewave Generator");


//init simulation inputs
top->clk = 1;
top->rst = 0;
top->en = 1;
top->incr = 1; //incr is now a constant
top->offset = 0;

for (i = 0; i < NO_OF_CYCLES; i++){
    //dump variables into VCD file and toggle clock
    for (clktick=0; clktick < 2; clktick++){
        tfp->dump(2*i + clktick);
        top->clk = !top->clk;
        top->eval();
    }

top->offset = vbdValue(); //offset between 2 waves
    // plot ROM output and print cycle count
    vbdPlot(int (top->dout1), 0, 255);
    vbdPlot(int (top->dout2), 0, 255);
    vbdCycle(i);
    

    if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
      exit(0);                // ... exit if finish OR 'q' pressed
}
vbdClose(); 
tfp->close();
exit(0);
}
