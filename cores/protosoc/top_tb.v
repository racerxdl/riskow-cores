`timescale 1 ns/1 ns  // time-unit = 1 ns, precision = 10 ps

module ProtoSoCTest;

  localparam ms = 1e6;
  localparam us = 1e3;

  integer i, j;
  reg                 clk;
  reg                 reset;
  wire                led;
  wire        [5:0]   lcd;
  // wire        [31:0]  IOPortA;
  // wire        [31:0]  IOPortB;
  assign led = dut.portB.direction[0] ? 1'bZ : 1'b1;
  assign lcd = 5'bZZZZZ;
  // generate
  //   genvar idx;
  //   for(idx = 0; idx < 32; idx = idx+1) begin: register
  //     assign IOPortA[idx] = dut.portA.direction[idx] ? 1'bZ : 1'b1;
  //     assign IOPortB[idx] = dut.portB.direction[idx] ? 1'bZ : 1'b1;
  //   end
  // endgenerate

  wire SPIOut;
  reg  SPIIn = 0;
  wire SPIClk;
  wire SPICSn;
  wire uartTx;
  reg  uartRx = 0;

  // Our device under test
  ProtoSOC dut(
    clk,
    reset,
    led,
    lcd,

    SPIOut,
    SPIIn,
    SPICSn,
    SPIclk,

    uartTx,
    uartRx
  );

  initial begin
    $dumpfile("top_tb.vcd");
    $dumpvars(0, ProtoSoCTest);

    $readmemh("gcc/test.mem", dut.ROM);

    for (i = 0; i < 8192; i=i+1)
    begin
      dut.RAM[i] = 0;
    end

    reset = 1;
    clk = 0;

    #10
    clk = 1;
    #10
    clk = 0;

    reset = 0;

    repeat(100000)
    begin
      #10
      clk = 1;
      #10
      clk = 0;
    end

    $finish;
  end

endmodule

