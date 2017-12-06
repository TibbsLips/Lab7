module clockDivider(CLK, slowClk);
  input CLK; 			//fast clock
  output reg slowClk; 		//slow clock

  reg[27:0] counter;

  initial begin
    counter = 0;
    slowClk = 0;
  end

  always @ (posedge CLK)
  begin
    //slowClk <= ~slowClk;

     if(counter == 5000000) begin 
       counter <= 1;
       slowClk <= ~slowClk;
     end
     else begin
       counter <= counter + 1;
     end
  end
endmodule

