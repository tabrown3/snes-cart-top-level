`timescale 10ns/1ns
module tb_crc_manager();
    reg reset = 1'b0;
    reg en = 1'b0;
    reg spi_clk = 1'b0;
    reg mosi = 1'b0;
    wire [7:0] crc8;
    wire [15:0] crc16;

    integer i;

    crc_manager CRC_MANAGER(
        .reset(reset),
        .en(en),
        .spi_clk(spi_clk),
        .mosi(mosi),
        .crc8(crc8),
        .crc16(crc16)
    );

    initial begin
        #50;
        en = 1'b1;
        #2000;
        en = 1'b0;
        reset = 1'b1;
        #100;
        reset = 1'b0;
        #100;
        $stop;
    end

    always begin
        for(i = 0; i < 8; i = i + 1) begin
            spi_clk = 1'b1;
            mosi = $random;
            #20;
            spi_clk = 1'b0;
            #20;
        end
    end
endmodule