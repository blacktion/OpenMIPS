`include "defines.v"

module pc_reg(
	input	wire				clk,
	input	wire				rst,
	input 	wire[5:0]			stall,	//来自控制模块CTRL
	
	output	reg[`InstAddrBus]	pc,
	output	reg					ce	
);

	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			ce <= `ChipDisable;
		end else begin
			ce <= `ChipEnable;
		end
	end
		
	always @ (posedge clk) begin
		if(ce == `ChipDisable) begin
			pc <= 32'h00000000;
		end else if(stall[0] == `NoStop) begin	//当stall[0]为NoStop时，pc加4，否则，保持pc不变
			pc <= pc + 4'h4;
		end
	end
	
endmodule