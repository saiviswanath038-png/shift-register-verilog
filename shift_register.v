module shift_register (
    input clk,
    input reset,
    input [1:0] mode,   // 00: Hold, 01: Shift Left, 10: Shift Right, 11: Parallel Load
    input serial_in,
    input [3:0] parallel_in,
    output reg [3:0] data_out,
    output serial_out
);

assign serial_out = data_out[0];  // Output during right shift

always @(posedge clk or posedge reset) begin
    if (reset)
        data_out <= 4'b0000;
    else begin
        case(mode)
            2'b00: data_out <= data_out; // Hold

            2'b01: // Shift Left
                data_out <= {data_out[2:0], serial_in};

            2'b10: // Shift Right
                data_out <= {serial_in, data_out[3:1]};

            2'b11: // Parallel Load
                data_out <= parallel_in;

            default: data_out <= data_out;
        endcase
    end
end

endmodule
