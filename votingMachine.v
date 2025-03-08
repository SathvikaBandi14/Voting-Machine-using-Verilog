`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module votingMachine(
input clk,
input rst,
input mode,
input button1,
input button2,
input button3,
input button4,
output wire [7:0] led);//output of instatiated module should be wire

wire valid_vote_1;
wire valid_vote_2;
wire valid_vote_3;
wire valid_vote_4;
wire [7:0] vote_recv_cand1;
wire [7:0] vote_recv_cand2;
wire [7:0] vote_recv_cand3;
wire [7:0] vote_recv_cand4;
wire anyValidVote;

assign anyValidVote=valid_vote_1 |valid_vote_2|valid_vote_3|valid_vote_4;

buttonControl bc1(
.clk(clk),
.rst(rst),
.button(button1),
.validVote(valid_vote_1)
);

buttonControl bc2(
.clk(clk),
.rst(rst),
.button(button2),
.validVote(valid_vote_2)
);
buttonControl bc3(
.clk(clk),
.rst(rst),
.button(button3),
.validVote(valid_vote_3)
);

buttonControl bc4(
.clk(clk),
.rst(rst),
.button(button4),
.validVote(valid_vote_4)
);

voteLogger vl(
.clk(clk),
.rst(rst),
.mode(mode),
.cand1_valid_vote(valid_vote_1),
.cand2_valid_vote(valid_vote_2),
.cand3_valid_vote(valid_vote_3),
.cand4_valid_vote(valid_vote_4),
.vote_recv_cand1(vote_recv_cand1),
.vote_recv_cand2(vote_recv_cand2),
.vote_recv_cand3(vote_recv_cand3),
.vote_recv_cand4(vote_recv_cand4)
);


modeControl mc(
.clk(clk),
.rst(rst),
.mode(mode),
.valid_vote_casted(anyValidVote),
.vote_cand1(vote_recv_cand1),
.vote_cand2(vote_recv_cand2),
.vote_cand3(vote_recv_cand3),
.vote_cand4(vote_recv_cand4),
.candidate1_button_press(valid_vote_1),
.candidate2_button_press(valid_vote_2),
.candidate3_button_press(valid_vote_3),
.candidate4_button_press(valid_vote_4),
.leds(led)
);
endmodule
