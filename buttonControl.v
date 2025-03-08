`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module buttonControl(
input clk,
input rst,
input button,
output reg validVote
    );
    
reg [30:0] counter;
//1sec /10ms=10^8 
//100 MHz clock frequency
//pressing the button for a second ,time period of clock is 10ms
always@(posedge clk)
begin 
if(rst)
counter<=0;
else 
begin 
if(button & counter<11)//valid vote for exactly 1 pulse
counter<=counter+1;
else if(!button)
counter<=0;
end 
end

always@(posedge clk)
begin if(rst)
validVote<=0;
else 
begin
if(counter == 10)
validVote<=1;
else 
validVote<=0;
end
end  
endmodule
