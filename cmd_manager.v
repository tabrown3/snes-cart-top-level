module cmd_manager
(
    input reset,
    input en,
    input clk,
    input [7:0] in_byte,
    input byte_finished,
    output [7:0] cmd,
    output [7:0] arg1,
    output [7:0] arg2,
    output [7:0] crc
);
    reg [2:0] byte_cnt = 3'h4;
    reg prev_finished = 1'b0;
    reg [31:0] cmd_frame = 32'h00000000;

    assign cmd = cmd_frame[31:24];
    assign arg1 = cmd_frame[23:16];
    assign arg2 = cmd_frame[15:8];
    assign crc = cmd_frame[7:0];

    always @(posedge clk) begin
        if (reset) begin
            byte_cnt <= 3'h4;
            prev_finished <= byte_finished;
            cmd_frame <= 32'h00000000;
        end else begin
            if (en) begin
                if (byte_finished ^ prev_finished) begin
                    prev_finished <= byte_finished;
                    cmd_frame[(byte_cnt * 8) - 1-:8] <= in_byte;
                    
                    if (byte_cnt > 3'h1) begin
                        byte_cnt <= byte_cnt - 3'h1;
                    end else begin
                        byte_cnt <= 3'h4;
                    end
                end
            end
        end
    end
endmodule