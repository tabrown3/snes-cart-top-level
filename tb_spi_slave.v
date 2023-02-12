`timescale 10ns/1ns
module tb_spi_slave();

    reg cs = 1'b1;
    reg spi_clk = 1'b0;
    reg mosi = 1'b0;
    reg [7:0] out_byte = 8'h59;
    wire miso;
    wire busy;
    wire [7:0] in_byte;

    integer i = 0;

    spi_slave SPI_SLAVE(
        .cs(cs),
        .spi_clk(spi_clk),
        .mosi(mosi),
        .out_byte(out_byte),
        .miso(miso),
        .busy(busy),
        .in_byte(in_byte)
    );

    initial begin
        #50;
        cs = 1'b0;
        #4950;
        $stop;
    end

    always begin
        #50;
        for(i = 0; i < 8; i = i + 1) begin
            spi_clk = 1'b1;
            mosi = $random;
            #20;
            spi_clk = 1'b0;
            #20;
        end

        out_byte = $random;
    end
endmodule