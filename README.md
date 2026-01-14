# VLSI-CAD-Project-
Multi-Clock APB System with Clock Domain Crossing Protection

<img width="1536" height="1024" alt="img" src="https://github.com/user-attachments/assets/b5cd631f-a0e6-4b68-81f2-55268493d449" />



RTL FLow:

rtl/

├── top.v

├── apb_master.v 

├── apb_slave.v

├── apb_async_bridge.v

├── cdc_handshake_ctrl.v

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


Project Proposal: 


[VLSI_CAD_Project_Proposal.pdf](https://github.com/user-attachments/files/24605533/VLSI_CAD_Project_Proposal.pdf)



