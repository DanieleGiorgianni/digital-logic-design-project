# Digital Logic Design
### Project of the year 2019 in VHDL language
## PROJECT
The purpose of this project is to design and implement a **VHDL component**, based on the xc7a200tfbg484-1 FPGA, capable of **encoding** the most frequently accessed **memory addresses** efficiently.<br />
If an address belongs to the frequently accessed memory areas, called **Working Zones**, it will be encoded in an appropriate way, respecting the delivery indications, otherwise it will remain unchanged.

## STRUCTURE  
The component is developed based on a 6-state FSM.<br />
The resources occupied by the component are:
- 176 Cells
- 213 Nets
- 81 LUT
- FF 47

Optimized values thanks to a careful reading of the code, removing unnecessary assignments and inserting appropriate if-then-else conditions.<br />
In the [documentation](https://github.com/DanieleGiorgianni/digital-logic-design-project/tree/main/documentation) folder you can find the [project report](https://github.com/DanieleGiorgianni/digital-logic-design-project/blob/main/documentation/Project_Report_eng.pdf), containing more detailed information about the implementation choices and the project specification (available both in [English](https://github.com/DanieleGiorgianni/digital-logic-design-project/blob/main/documentation/Project_Report_eng.pdf) and [Italian](https://github.com/DanieleGiorgianni/digital-logic-design-project/blob/main/documentation/Project_Report_ita.pdf)).
