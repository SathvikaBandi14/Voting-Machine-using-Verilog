`timescale 1ns / 1ps

module tb_voting_machine;
// Inputs
reg clk;
reg rst;
reg mode;
reg button1;
reg button2;
reg button3;
reg button4;
wire [7:0] led;

// Instantiate the voting machine module
votingMachine uut (
    .clk(clk),
    .rst(rst),
    .mode(mode),
    .button1(button1),
    .button2(button2),
    .button3(button3),
    .button4(button4),
    .led(led)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
end

// Testbench logic
initial begin
    // Initialize inputs
    rst = 1;
    mode=0;
    button1 = 0;
    button2 = 0;
    button3 = 0;
    button4=0;

    // Apply reset
    #10 rst = 0;

    // Simulate votes
    #100 button1 = 1; #100 button1 = 0; // Vote for A
    #100 button2 = 1; #100 button2 = 0; // Vote for B
    #100 button1 = 1; #100 button1 = 0; // Another vote for A
    #100 button3 = 1; #100 button3 = 0; // Vote for C
    #100 button2 = 1; #100 button2 = 0; // Another vote for B
    #100 button2 = 1; #100 button2 = 0; // One more vote for B
    #100 button1 = 1; #100 button1 = 0; // One more vote for A

    // Allow time for winner to stabilize
    #100 mode=1; button1=1;
    #100 button1=0;

    // Display results
    $display("Final vote counts:");
    $display("led %d", led);

    // End simulation
    $stop;
end

endmodule
