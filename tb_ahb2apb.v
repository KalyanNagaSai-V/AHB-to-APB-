module tb_ahb2apb;

  reg        clk;
  reg        rstn;
  reg        hsel;
  reg [31:0] haddr;
  reg [1:0]  htrans;
  reg        hwrite;
  reg [31:0] hwdata;
  reg        hready_in;
  wire [31:0] hrdata;
  wire        hready_out;
  wire        hresp;

  wire        psel;
  wire        penable;
  wire        pwrite;
  wire [31:0] paddr;
  wire [31:0] pwdata;
  reg  [31:0] prdata;
  reg         pready;

  // Instantiate DUT
  ahb2apb dut (
    .clk(clk),
    .rstn(rstn),
    .hsel(hsel),
    .haddr(haddr),
    .htrans(htrans),
    .hwrite(hwrite),
    .hwdata(hwdata),
    .hready_in(hready_in),
    .hrdata(hrdata),
    .hready_out(hready_out),
    .hresp(hresp),
    .psel(psel),
    .penable(penable),
    .pwrite(pwrite),
    .paddr(paddr),
    .pwdata(pwdata),
    .prdata(prdata),
    .pready(pready)
  );

  // Clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset
  initial begin
    rstn      = 0;
    hsel      = 0;
    haddr     = 0;
    htrans    = 2'b00;
    hwrite    = 0;
    hwdata    = 0;
    hready_in = 1;
    prdata    = 32'h1234_ABCD;
    pready    = 1;

    #20 rstn = 1;
  end

  // Stimulus
  initial begin
    @(posedge rstn);
    #10;

    $display("WRITE txn...");
    hsel   = 1;
    haddr  = 32'h1000_0000;
    htrans = 2'b10;
    hwrite = 1;
    hwdata = 32'hDEAD_BEEF;

    @(posedge clk);
    hsel = 0;

    wait(hready_out);
    $display("WRITE done @ %t | paddr=%h, pwdata=%h", $time, paddr, pwdata);

    
    #20;
    $display("READ txn...");
    hsel   = 1;
    haddr  = 32'h1000_0004;
    htrans = 2'b10;
    hwrite = 0;

    @(posedge clk);
    hsel = 0;

    wait(hready_out);
    $display("READ done @ %t | hrdata=%h", $time, hrdata);

    #50 $finish;
  end


  initial begin
    $dumpfile("ahb2apb.vcd");
    $dumpvars(0, tb_ahb2apb);
  end

endmodule
