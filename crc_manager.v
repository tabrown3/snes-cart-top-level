module crc_manager(
    input reset,
    input en,
    input spi_clk,
    input mosi,
    output reg [7:0] crc8 = 8'h00,
    output reg [15:0] crc16 = 16'h0000
);
    always @(negedge spi_clk or posedge reset) begin
        if (reset) begin
            crc8 <= 8'h00;
            crc16 <= 16'h0000;
        end else begin
            if (en) begin
                // CRC-8 CCITT, polynomial 0x07
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

                // CRC-16 CCITT, polynomial 0x1021
                crc16 <= {
                    crc16[14],
                    crc16[13],
                    crc16[12],
                    crc16[11]^crc16[15],
                    crc16[10],
                    crc16[9],
                    crc16[8],
                    crc16[7],
                    crc16[6],
                    crc16[5],
                    crc16[4]^crc16[15],
                    crc16[3],
                    crc16[2],
                    crc16[1],
                    crc16[0],
                    mosi^crc16[15]
                };
            end
        end
    end
endmodule