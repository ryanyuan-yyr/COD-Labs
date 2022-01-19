`timescale 1ns / 1ps

module show_what_recv(
	input clk,
	output [7:0] led,
	output[2:0] an,
	output[3:0] seg,
	input rxd, 
	output txd
);
// wire data;
// reg[7:0] counter0;
// reg[19:0] hexcnt;
// reg[7:0] register_file[3:0];
// wire rx_vld;
// wire[7:0] rx_data;
// initial begin
// 	counter0 <= 8'b0;
// 	hexcnt <= 20'b0;
// end
// rx rx(.clk(clk), .rst(0), .rx(data), .rx_vld(rx_vld), .rx_data(rx_data));

// always @(posedge clk) begin
// 	if(rx_vld)begin
// 		register_file[counter0] <= rx_data;
// 		counter0 <= counter0 + 1;
// 	end
// end

// always @(*) begin
// 	led <= counter0;
// end

// assign an = hexcnt[19:17];

// always @(posedge clk) begin
// 	hexcnt <= hexcnt + 1;
// end

// always @(*) begin
// 	case (an)
// 		3'd0: seg = register_file[0][3:0];
// 		3'd1: seg = register_file[0][7:4];
// 		3'd2: seg = register_file[1][3:0];
// 		3'd3: seg = register_file[1][7:4];
// 		3'd4: seg = register_file[2][3:0];
// 		3'd5: seg = register_file[2][7:4];
// 		3'd6: seg = register_file[3][3:0];
// 		3'd7: seg = register_file[3][7:4];
// 		default: ;
// 	endcase
// end

// assign led[0] = rxd;
wire tx_output;

// assign txd = tx_output;
// assign led[1] = tx_output;

reg tx_ready;
reg [7:0] tx_data;
wire tx_rd;
wire [3:0] tx_cnt_debug;
reg [63:0] counter;
tx tx(.clk(clk), .rst(rst), .tx_ready(tx_ready), .tx_data(tx_data), .tx_rd(tx_rd), .tx(tx_output),
.tx_cnt_debug(tx_cnt_debug));

// Debug
assign led = tx_data;
assign an[0] = rxd;
assign an[1] = tx_output;
assign an[2] = tx_rd;
assign seg = tx_cnt_debug;

initial begin
	counter = 64'b0;
	tx_data = 8'd48;
	tx_ready = 1;
end
always @(posedge clk) begin
	if(tx_rd)begin
		if(counter == 64'h02)begin
			tx_data <= 8'h0a;
			counter <= counter + 1;
			tx_ready <= 1;
		end
		else if(counter < 64'h02)begin
			tx_data <= tx_data + 1;
			counter <= counter + 1;
			tx_ready <= 1;
		end
		else
			tx_ready <= 0;
	end
end

endmodule