module spi_slave
(
    input cs,
    input spi_clk,
    input mosi,
    input [7:0] out_byte,
    output reg miso = 1'b0,
    output busy,
    output [7:0] in_byte
);

    reg started = 1'b0;
    reg finished = 1'b0;
    reg [3:0] bit_cnt = 4'h7;
    reg [7:0] in_byte_reg = 8'h00;

    assign busy = started ^ finished;
    assign in_byte = in_byte_reg;

    always @(posedge spi_clk) begin
        if (!cs) begin
            if (bit_cnt == 4'h7) begin
                started <= ~started;
                miso <= out_byte[bit_cnt];
            end else begin
                miso <= out_byte[bit_cnt];
            end
        end
    end

    always @(negedge spi_clk) begin
        if (!cs) begin
            if (bit_cnt == 4'h0) begin
                finished <= started;
                in_byte_reg[bit_cnt] <= mosi;
                bit_cnt <= 4'h7;
            end else begin
                in_byte_reg[bit_cnt] <= mosi;
                bit_cnt <= bit_cnt - 1;
            end
        end
    end
endmodule