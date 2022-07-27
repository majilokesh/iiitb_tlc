`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:31:28 07/27/2022
// Design Name:   traffic_light
// Module Name:   /home/ise/traffic/tb_traffic.v
// Project Name:  traffic
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: traffic_light
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
// 1. Preprocessor Directives
`define DELAY 1
// 2. Include Statements
//`include "counter_define.h"
module iiitb_tlc_tb;
// 3. Parameter definitions
parameter ENDTIME  = 40000;
// 4. DUT Input regs
//integer count, count1, a;
reg clk;
reg rst_n;
reg sensor;
wire [2:0] light_farm;
// 5. DUT Output wires
wire [2:0] light_highway;
// 6. DUT Instantiation
iiitb_tlc test(light_highway, light_farm, sensor, clk, rst_n);

// 7. Initial Conditions
initial
 begin
 clk = 1'b0;
 rst_n = 1'b0;
 sensor = 1'b0;
 // count = 0;
//// count1=0;
// a=0;
 end
 initial
  begin
   $dumpfile("tlc_out.vcd");
   $dumpvars(0, iiitb_tlc_tb);
  end
 // 8. Generating Test Vectors
initial
 begin
 main;
 end
task main;
 fork
 clock_gen;
 reset_gen;
 operation_flow;
 debug_output;
 endsimulation;
 join
endtask
task clock_gen;
 begin
 forever #`DELAY clk = !clk;
 end
 endtask

task reset_gen;
 begin
 rst_n = 0;
 # 20
 rst_n = 1;
 end
endtask
task operation_flow;
 begin
  sensor = 0;
 # 600
 sensor = 1;
 # 1200
 sensor = 0;
 # 1200
 sensor = 1;
 end
endtask
// 9. Debug output
task debug_output;
 begin
 $display("----------------------------------------------");
        $display("------------------     -----------------------");
 $display("----------- SIMULATION RESULT ----------------");
  $display("--------------             -------------------");
 $display("----------------         ---------------------");
 $display("----------------------------------------------");
 $monitor("TIME = %d, reset = %b, sensor = %b, light of highway = %h, light of farm road = %h",$time,rst_n ,sensor,light_highway,light_farm );
 end
endtask
//10. Determines the simulation limit
task endsimulation;
 begin
 #ENDTIME
 $display("-------------- THE SIMUALTION END ------------");
 $finish;
 end
endtask
    
endmodule
