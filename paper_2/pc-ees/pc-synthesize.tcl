# Synthesis script created by: ees-synthesize, written by Gundolf Kiefer <gundolf.kiefer@hs-augsburg.de>.
#
# Command line:         ees-synthesize -r pc.vhdl
# Running this script:  vivado -notrace -nojournal -mode batch -source pc-ees/pc-synthesize.tcl



puts "\n\n"
puts "###########################################################################"
puts "#"
puts "#          Setup project and read sources ..."
puts "#"
puts "###########################################################################"
puts ""

create_project -in_memory -part xc7z010clg400-1
read_vhdl -verbose pc.vhdl
set_property top pc [current_fileset]



puts "\n\n"
puts "###########################################################################"
puts "#"
puts "#          RTL-Synthesize design and open it in GUI ..."
puts "#"
puts "###########################################################################"
puts ""

synth_design -rtl
start_gui
