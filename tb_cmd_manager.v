`timescale 10ns/1ns
module tb_cmd_manager();
    reg reset = 1'b0;
    reg en = 1'b0;
    reg clk = 1'b0;
    reg [7:0] in_byte = 8'h00;
    reg byte_finished = 1'b0;
    wire [7:0] cmd;
    wire [7:0] arg1;
    wire [7:0] arg2;
    wire [7:0] crc;

    cmd_manager CMD_MANAGER(
        .reset(reset),
        .en(en),
        .clk(clk),
        .in_byte(in_byte),
        .byte_finished(byte_finished),
        .cmd(cmd),
        .arg1(arg1),
        .arg2(arg2),
        .crc(crc)
    );

    initial begin
        #50;
        en = 1'b1;
        #1750;
        en = 1'b0;
        reset = 1'b1;
        #20;
        reset = 1'b0;
        #180;
        $stop;
    end

    always begin
        #5;
        clk = 1'b1;
        #5;
        clk = 1'b0;
    end

    always begin
        in_byte = $random;
        #40;
        byte_finished = ~byte_finished;
    end
endmodule