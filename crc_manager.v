module crc_manager(
    input reset,
    input en,
    input spi_clk,
    input mosi,
    output reg [7:0] crc8 = 8'h00,
    output reg [15:0] crc16 = 16'h00
);
    always @(posedge spi_clk) begin
        if (reset) begin
            crc8 <= 8'h00;
            crc16 <= 16'h00;
        end else begin
            if (en) begin
                crc8 <= {
                    crc8[6],
                    crc8[5],
                    crc8[4],
                    crc8[3],
                    crc8[2],
                    crc8[1]^crc8[7],
                    crc8[0]^crc8[7],
                    mosi^crc8[7]
                };
            end
        end
    end
endmodule