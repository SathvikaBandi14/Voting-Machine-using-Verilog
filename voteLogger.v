`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module voteLogger(
input clk,
input rst,
input mode,
input cand1_valid_vote,
input cand2_valid_vote,
input cand3_valid_vote,
input cand4_valid_vote,
output reg [7:0] vote_recv_cand1,
output reg [7:0] vote_recv_cand2,
output reg [7:0] vote_recv_cand3,
output reg [7:0] vote_recv_cand4
);

always@(posedge clk)
begin   
if(rst)
begin 
vote_recv_cand1<=0;
vote_recv_cand2<=0;
vote_recv_cand3<=0;
vote_recv_cand4<=0;
end 

else    
begin 
if(cand1_valid_vote & mode==0)
vote_recv_cand1<=vote_recv_cand1+1;
else if(cand2_valid_vote & mode==0)
vote_recv_cand2<=vote_recv_cand2+1;
else if(cand3_valid_vote & mode==0)
vote_recv_cand3<=vote_recv_cand3+1;
else if(cand4_valid_vote & mode==0)
vote_recv_cand4<=vote_recv_cand4+1;
end 
end 
endmodule
