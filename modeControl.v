`timescale 1ns / 1ps
 
//////////////////////////////////////////////////////////////////////////////////
module modeControl(
input clk,
input rst,
input mode,
input valid_vote_casted,
input [7:0] vote_cand1,
input [7:0] vote_cand2,
input [7:0] vote_cand3,
input [7:0] vote_cand4,
input candidate1_button_press,
input candidate2_button_press,
input candidate3_button_press,
input candidate4_button_press,
output reg [7:0] leds);


reg [30:0] counter;
always@(posedge clk)
begin 
if(rst)
counter<=0;
else if(valid_vote_casted)  //if counter is not 0 ,increment till 10^8
counter<=counter+1;
else if(counter !=0 & counter<10)
counter<=counter+1;
else 
counter<=0;
end 

always@(posedge clk)
begin 
if(rst)
leds<=0;
else    
begin   
if(mode==0 & counter>0) //mode=0 -> vote casted,mode=1 ->result display
leds<=8'hFF;
else if(mode==0)
leds<=0;   
else if(mode==1)//result display    
begin
   if(candidate1_button_press)
   leds<=vote_cand1;
   if(candidate2_button_press)
   leds<=vote_cand2;
   if(candidate3_button_press)
   leds<=vote_cand3;
   if(candidate4_button_press)
   leds<=vote_cand4;
end 
end
end

endmodule
