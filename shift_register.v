// simple shift register design

module shift_register (
    input clk,
    input reset,
    input [1:0] mode,   // 00: hold, 01: shift left, 10: shift right, 11: load
    input serial_in,
    input [3:0] parallel_in,
    output reg [3:0] data_out,
    output serial_out
);

assign serial_out = data_out[0];

always @(posedge clk or posedge reset) begin
    if (reset)
        data_out <= 4'b0000;
    else begin
        case(mode)

            2'b00: data_out <= data_out; // hold

            2'b01: data_out <= {data_out[2:0], serial_in}; // shift left

            2'b10: data_out <= {serial_in, data_out[3:1]}; // shift right

            2'b11: data_out <= parallel_in; // load

            default: data_out <= data_out;

        endcase
    end
end

endmodule
