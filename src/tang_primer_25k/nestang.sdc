
// NES clocks
create_clock -name clk -period 20 [get_nets {sys_clk}]       // 50 Mhz
//create_generated_clock -name clk -source [get_nets {pclk}] -master_clock pclk -divide_by 3 [get_nets {clk}]     // 32.25 Mhz

// USB clock
//create_clock -name clk_usb -period 83.33 [get_nets {clk_usb}]       // 12 Mhz

// HDMI clocks
create_clock -name clk_p5 -period 2.6936 [get_nets {clk_p5}]                    // 371.25 Mhz
//create_generated_clock -name clk_p -source [get_nets {clk_p}] -master_clock clk_p5 -divide_by 5 [get_nets {clk_p}]     // 74.25 Mhz: 720p pixel clock

//set_clock_groups -asynchronous -group [get_clocks {pclk} get_clocks{clk}] -group [get_clocks {clk_p5} get_clocks{clk_p}]
report_timing -hold -from_clock [get_clocks {clk*}] -to_clock [get_clocks {clk*}] -max_paths 25 -max_common_paths 1
report_timing -setup -from_clock [get_clocks {clk*}] -to_clock [get_clocks {clk*}] -max_paths 25 -max_common_paths 1

//False Path Constraints
set_false_path -from [get_pins {sys_resetn_s0/Q}] -to [get_pins {u_hdmi/hdmi/serializer/gwSer0/RESET u_hdmi/hdmi/serializer/gwSer1/RESET u_hdmi/hdmi/serializer/gwSer2/RESET}]  -setup
//set_false_path -from [get_pins {sys_resetn_s0/Q}] -to [get_pins {clk_div/clkdiv_inst/RESETN}] 

create_generated_clock -name clk_27m -source [get_nets {sys_clk}] -master_clock clk -divide_by 50 -multiply_by 27 -duty_cycle 50 [get_pins {pll27/PLLA_inst/CLKOUT0}]
//set_clock_groups -asynchronous -group [get_clocks {clk_p5}] -group [get_clocks {clk_27m}]