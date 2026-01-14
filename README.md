# VLSI-CAD-Project-
Multi-Clock APB System with Clock Domain Crossing Protection

RTL FLow:

rtl/

├── top.v

├── apb_master.v 

├── apb_slave.v

├── apb_async_bridge.v

├── cdc_handshake_bus.v

├── async_fifo.v

├── bin2gray.v

├── gray2bin.v

├── bit_sync.v

└── reset_sync.v



Signal FLow:

APB Master (clk A)

        │
        ▼
   APB Async Bridge
   
   ├── Handshake CDC (control)
   
   ├── Async FIFO (data)
   
   ├── bit_sync
   
   └── reset_sync
   
        │
        ▼
        
APB Slave (clk B)



