AHB to APB Bridge
About AMBA Buses

The Advanced Microcontroller Bus Architecture (AMBA) is a widely used on-chip communication standard that provides efficient connectivity between processors, memories, and peripherals. It defines three main types of buses:

Advanced High-performance Bus (AHB)

Advanced System Bus (ASB)

Advanced Peripheral Bus (APB)

Advanced High-performance Bus (AHB)

The AHB is designed for high-speed, high-frequency system modules. It acts as the primary backbone of the system, supporting processors, on-chip memory, and external memory interfaces. AHB ensures efficient system design with support for synthesis, testing, and automation, while allowing low-power peripherals to be integrated.

Advanced System Bus (ASB)

ASB is another high-performance bus but with fewer advanced features than AHB. It is suitable for systems where moderate performance is acceptable, still offering seamless connectivity for processors, memories, and peripherals.

Advanced Peripheral Bus (APB)

The APB is targeted at low-power, low-complexity peripherals. It is optimized for minimal interface overhead and reduced switching activity, making it ideal for UARTs, timers, and GPIOs. Unlike AHB/ASB, the APB does not support bursts and always performs transfers in two cycles (setup and access).

Basic Terminology

Bus cycle: One clock period of the bus.

Bus transfer: A read/write operation, which may span multiple cycles in AHB/ASB but always takes two cycles in APB.

Burst transfer: A sequence of data transfers with incrementing/wrapping addresses. Supported in AHB, but not in APB.

AMBA Signals
AHB Main Signals

HCLK – Main clock for AHB operations.

HRESETn – Active-low reset.

HADDR[31:0] – 32-bit address bus.

HTRANS[1:0] – Transfer type: IDLE, BUSY, NONSEQ, SEQ.

HWRITE – Indicates read/write.

HSIZE[2:0] – Transfer size (byte/halfword/word).

HBURST[2:0] – Burst type (single, incr, wrap).

HWDATA[31:0] – Data from master to slave (write).

HRDATA[31:0] – Data from slave to master (read).

HREADY – Indicates transfer completion.

HRESP[1:0] – Response (OKAY, ERROR, RETRY, SPLIT).

APB Main Signals

PCLK – APB clock.

PRESETn – Active-low reset.

PADDR[31:0] – APB address bus.

PSELx – Slave select line.

PENABLE – Indicates second cycle of APB transfer.

PWRITE – Read/write indicator.

PWDATA[31:0] – Data from bridge to APB slave.

PRDATA[31:0] – Data from slave to bridge
