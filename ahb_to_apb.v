module ahb2apb (
    input         clk,
    input         rstn,

    // AHB Slave Side
    input         hsel,
    input  [31:0] haddr,
    input  [1:0]  htrans,
    input         hwrite,
    input  [31:0] hwdata,
    input         hready_in,

    output reg [31:0] hrdata,
    output reg        hready_out,
    output reg        hresp,

    // APB Master Side
    output reg        psel,
    output reg        penable,
    output reg        pwrite,
    output reg [31:0] paddr,
    output reg [31:0] pwdata,
    input      [31:0] prdata,
    input             pready
);

    reg [1:0] state, next;
    localparam IDLE   = 2'b00,
               SETUP  = 2'b01,
               ACCESS = 2'b10;

    // State Register
    always @(posedge clk or negedge rstn) begin
        if (!rstn)
            state <= IDLE;
        else
            state <= next;
    end

    // Next State Logic
    always @(*) begin
        next = state;
        case (state)
            IDLE: if (hsel && htrans[1] && hready_in) next = SETUP;
            SETUP: next = ACCESS;
            ACCESS: if (pready) next = IDLE;
        endcase
    end

    // Output Logic
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            {psel, penable, pwrite} <= 0;
            {hready_out, hresp} <= 1;
            hrdata <= 0;
            paddr  <= 0;
            pwdata <= 0;
        end else begin
            case (state)
                IDLE: begin
                    psel      <= 0;
                    penable   <= 0;
                    hready_out <= 1;
                end
                SETUP: begin
                    psel      <= 1;
                    penable   <= 0;
                    paddr     <= haddr;
                    pwrite    <= hwrite;
                    pwdata    <= hwdata;
                    hready_out <= 0;
                end
                ACCESS: begin
                    penable <= 1;
                    if (pready) begin
                        hready_out <= 1;
                        if (!pwrite)
                            hrdata <= prdata;
                    end
                end
            endcase
        end
    end

endmodule
