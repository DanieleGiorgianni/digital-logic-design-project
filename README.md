# Digital Logic Design
### Project of the year 2019 in VHDL language
## PROJECT
The purpose of this project is to design and implement a **VHDL component**, based on the xc7a200tfbg484-1 FPGA, capable of **encoding** the most frequently accessed **memory addresses** efficiently.<br />
If an address belongs to the frequently accessed memory areas, called **Working Zones**, it will be encoded in an appropriate way, respecting the [specifications](https://github.com/DanieleGiorgianni/digital-logic-design-project/tree/main/specs) provided, otherwise it will remain unchanged.

## STRUCTURE  
The [component](https://github.com/DanieleGiorgianni/digital-logic-design-project/blob/main/project/code.vhd) is developed based on a 6-state FSM.<br />
The resources occupied by the component are:
- 176 Cells
- 213 Nets
- 81 LUT
- FF 47

Optimized values thanks to a careful reading of the code, removing unnecessary assignments and inserting appropriate if-then-else conditions.<br />
In the [documentation](https://github.com/DanieleGiorgianni/digital-logic-design-project/tree/main/documentation) folder you can find the [project report](https://github.com/DanieleGiorgianni/digital-logic-design-project/blob/main/documentation/Project_Report_eng.pdf), containing more detailed information about the implementation choices and the project specification (available both in [English](https://github.com/DanieleGiorgianni/digital-logic-design-project/blob/main/documentation/Project_Report_eng.pdf) and [Italian](https://github.com/DanieleGiorgianni/digital-logic-design-project/blob/main/documentation/Project_Report_ita.pdf)).

## TESTBENCH
The synthesized component positively passes both the tests provided by the teachers and those independently generated to go and cover as many cases as possible.<br />
The [tests](https://github.com/DanieleGiorgianni/digital-logic-design-project/tree/main/tests) performed, with clock periods of 100ns, can be summarized according to the cases covered:
- Various memory configurations, so as to test a large number of addresses to been coded, both in case of WZ membership and in opposite case, and assign various basic addresses to WZ contained in memory, including boundary cases;
- Multiple start, so as to evaluate both the correct start of a processing and its 
correct execution throughout the entire coding process;
- Multiple resets, so that the machine checks the correct transaction at the initial state when the reset signal is raised in any available state.

These categories have been combined in a way that provides the most comprehensive testing possible.
