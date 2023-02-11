module spi_slave
(
    input clk,
    input spi_clk,
    input mosi,
    input [7:0] out_byte,
    output reg miso = 1'b0,
    output busy,
    output [7:0] in_byte
);

    reg started = 1'b0;
    reg finished = 1'b0;
    reg [3:0] bit_cnt = 4'h0;
    reg [7:0] in_byte_reg = 8'h00;
    // Tracks whether the spi_clk rising transition has been handled,
    //  since it should only be handled once, and the falling can only
    //  be handled after the rising.
    reg posedge_handled = 1'b0;

    assign busy = started ^ finished;
    assign in_byte = in_byte_reg;

    always @(posedge clk) begin
        if (spi_clk && !posedge_handled) begin
            posedge_handled <= 1'b1;

            if (bit_cnt == 4'h0) begin
                started <= ~started;
                in_byte_reg[bit_cnt] <= mosi;
            end else begin
                in_byte_reg[bit_cnt] <= mosi;
            end
        end else if (!spi_clk && posedge_handled) begin
            posedge_handled <= 1'b0;

            if (bit_cnt == 7) begin
                finished <= started;
                miso <= out_byte[bit_cnt];
                bit_cnt <= 0;
            end else begin
                miso <= out_byte[bit_cnt];
                bit_cnt <= bit_cnt + 1;
            end
        end
    end
endmodule