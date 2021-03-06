
// You can use this skeleton testbench code, the textbook testbench code, or your own
module MIPS_Testbench();
  reg CLK;
  wire CS, WE;

  reg[31:0] truevalue[10:1];

  wire[31:0] Mem_Bus;
  wire[6:0] Address, Address_Mux;
  reg[6:0] AddressTB;
  wire WE_Mux, CS_Mux;
  reg init, rst, WE_TB, CS_TB;
  reg HALT; //added
  wire [7:0]regout1;//added
  integer i;

  MIPS CPU(HALT,CLK, rst, CS, WE, Address, Mem_Bus,regout1); //added regout1
  Memory MEM(CS_Mux, WE_Mux, CLK, Address_Mux, Mem_Bus);

  assign Address_Mux = (init)? AddressTB : Address;
  assign WE_Mux = (init)? WE_TB : WE;
  assign CS_Mux = (init)? CS_TB : CS;

  always
    #10 CLK = ~CLK;

  initial begin
    HALT = 0; //added
    truevalue[1]  = 32'h00000006;
    truevalue[2]  = 32'h00000012;
    truevalue[3]  = 32'h00000018;
    truevalue[4]  = 32'h0000000C;
    truevalue[5]  = 32'h00000002;
    truevalue[6]  = 32'h00000016;
    truevalue[7]  = 32'h00000001;
    truevalue[8]  = 32'h00000120;
    truevalue[9]  = 32'h00000003;
    truevalue[10] = 32'h00412022;
    CLK = 0;
  end

  always begin
    rst = 1;
    @(posedge CLK);  // wait until posedge CLK
    // Initialize the instructions from the testbench
    init <= 1; CS_TB <= 1; WE_TB <= 1;
    @(posedge CLK);
    CS_TB <= 0; WE_TB <= 0; init <= 0;
    @(posedge CLK);
    rst <= 0;
    for(i = 1; i <= 10; i = i + 1) begin
      @(posedge WE);  // When a store word is executed
      @(posedge CLK);
      if (Mem_Bus != truevalue[i])
        $display("Output mismatch: got %d, expect %d", Mem_Bus, truevalue[i]);

      else $display("Correct: got %d, expect %d", Mem_Bus, truevalue[i]);
	end
    $display("Testing Finished:");
    $stop;
  end
endmodule
