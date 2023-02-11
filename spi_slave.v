module spi_slave
(
    input clk,
    input spi_clk,
    input mosi,
    output miso
);
    reg busy = 1'b0;
    reg finished = 1'b0;
    reg [3:0] bit_cnt = 4'h0;
    reg [7:0] in_byte_reg = 8'h00;

    wire [7:0] in_byte;

    assign in_byte = in_byte_reg;

    always @(posedge clk) begin
        if (finished) begin
            finished <= 1'b0;
        end

        if (bit_cnt == 4'h0 && spi_clk) begin
            busy <= 1'b1;
            bit_cnt <= bit_cnt + 1;
            in_byte_reg[bit_cnt] <= mosi;
        end else if (bit_cnt < 8) begin
            bit_cnt <= bit_cnt + 1;
            in_byte_reg[bit_cnt] <= mosi;
        end else begin
            busy <= 1'b0;
            bit_cnt <= 4'h0;
            finished <= 1'b1;
        end
    end
endmodule