module brain(
    input clk,
    input byte_finished,
    input frame_finished,
    input [7:0] cmd,
    input [7:0] arg1,
    input [7:0] arg2,
    input [7:0] checksum_crc8,
    input [15:0] checksum_crc16,
    output reg cmd_reset = 1'b0,
    output reg crc_reset = 1'b0,
    output reg cmd_en = 1'b1,
    output reg crc_en = 1'b1,
    output reg [7:0] out_byte = 8'h00
);
    localparam [7:0] AWAITING_INIT_CMD = 8'h01;
    localparam [7:0] INITIALIZING_RAM = 8'h02;
endmodule