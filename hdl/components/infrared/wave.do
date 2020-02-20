onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_infrared/avs_s0_address
add wave -noupdate /tb_infrared/avs_s0_read
add wave -noupdate /tb_infrared/avs_s0_readdata
add wave -noupdate /tb_infrared/avs_s0_write
add wave -noupdate /tb_infrared/avs_s0_writedata
add wave -noupdate /tb_infrared/clk
add wave -noupdate /tb_infrared/nRst
add wave -noupdate /tb_infrared/ir_rx
add wave -noupdate /tb_infrared/ir_tx
add wave -noupdate /tb_infrared/irq
add wave -noupdate /tb_infrared/ir_rx_mirror
add wave -noupdate -divider stop_counter
add wave -noupdate /tb_infrared/DUT/stop_counter_inst/clk_i
add wave -noupdate /tb_infrared/DUT/stop_counter_inst/rst_n_i
add wave -noupdate /tb_infrared/DUT/stop_counter_inst/enable_i
add wave -noupdate /tb_infrared/DUT/stop_counter_inst/overflow_o
add wave -noupdate /tb_infrared/DUT/stop_counter_inst/count_o
add wave -noupdate /tb_infrared/DUT/stop_counter_inst/count
add wave -noupdate /tb_infrared/DUT/stop_counter_inst/overflow
add wave -noupdate -divider DUT
add wave -noupdate /tb_infrared/DUT/clk_i
add wave -noupdate /tb_infrared/DUT/rst_n_i
add wave -noupdate /tb_infrared/DUT/avs_s0_address
add wave -noupdate /tb_infrared/DUT/avs_s0_read
add wave -noupdate /tb_infrared/DUT/avs_s0_readdata
add wave -noupdate /tb_infrared/DUT/avs_s0_write
add wave -noupdate /tb_infrared/DUT/avs_s0_writedata
add wave -noupdate /tb_infrared/DUT/avs_s0_waitrequest
add wave -noupdate /tb_infrared/DUT/ir_rx_i
add wave -noupdate /tb_infrared/DUT/ir_tx_o
add wave -noupdate /tb_infrared/DUT/done_recording_irq_o
add wave -noupdate /tb_infrared/DUT/ir_rx_o
add wave -noupdate /tb_infrared/DUT/ram_readdata
add wave -noupdate /tb_infrared/DUT/ctrl_readdata
add wave -noupdate -expand -subitemconfig {/tb_infrared/DUT/ir_rx(1) {-color Magenta -height 16}} /tb_infrared/DUT/ir_rx
add wave -noupdate /tb_infrared/DUT/store_timestamp
add wave -noupdate /tb_infrared/DUT/irq_active
add wave -noupdate /tb_infrared/DUT/irq_reset
add wave -noupdate /tb_infrared/DUT/ir_rx_sync
add wave -noupdate /tb_infrared/DUT/next_ir_rx
add wave -noupdate /tb_infrared/DUT/rising
add wave -noupdate /tb_infrared/DUT/falling
add wave -noupdate /tb_infrared/DUT/recording_stopped
add wave -noupdate -radix decimal /tb_infrared/DUT/timestamp
add wave -noupdate /tb_infrared/DUT/ctrl_access
add wave -noupdate -radix decimal -childformat {{/tb_infrared/DUT/ram_data(0) -radix decimal} {/tb_infrared/DUT/ram_data(1) -radix decimal} {/tb_infrared/DUT/ram_data(2) -radix decimal} {/tb_infrared/DUT/ram_data(3) -radix decimal} {/tb_infrared/DUT/ram_data(4) -radix decimal} {/tb_infrared/DUT/ram_data(5) -radix decimal} {/tb_infrared/DUT/ram_data(6) -radix decimal} {/tb_infrared/DUT/ram_data(7) -radix decimal} {/tb_infrared/DUT/ram_data(8) -radix decimal} {/tb_infrared/DUT/ram_data(9) -radix decimal} {/tb_infrared/DUT/ram_data(10) -radix decimal} {/tb_infrared/DUT/ram_data(11) -radix decimal} {/tb_infrared/DUT/ram_data(12) -radix decimal} {/tb_infrared/DUT/ram_data(13) -radix decimal} {/tb_infrared/DUT/ram_data(14) -radix decimal} {/tb_infrared/DUT/ram_data(15) -radix decimal} {/tb_infrared/DUT/ram_data(16) -radix decimal} {/tb_infrared/DUT/ram_data(17) -radix decimal} {/tb_infrared/DUT/ram_data(18) -radix decimal} {/tb_infrared/DUT/ram_data(19) -radix decimal} {/tb_infrared/DUT/ram_data(20) -radix decimal} {/tb_infrared/DUT/ram_data(21) -radix decimal} {/tb_infrared/DUT/ram_data(22) -radix decimal} {/tb_infrared/DUT/ram_data(23) -radix decimal} {/tb_infrared/DUT/ram_data(24) -radix decimal} {/tb_infrared/DUT/ram_data(25) -radix decimal} {/tb_infrared/DUT/ram_data(26) -radix decimal} {/tb_infrared/DUT/ram_data(27) -radix decimal} {/tb_infrared/DUT/ram_data(28) -radix decimal} {/tb_infrared/DUT/ram_data(29) -radix decimal} {/tb_infrared/DUT/ram_data(30) -radix decimal} {/tb_infrared/DUT/ram_data(31) -radix decimal} {/tb_infrared/DUT/ram_data(32) -radix decimal} {/tb_infrared/DUT/ram_data(33) -radix decimal} {/tb_infrared/DUT/ram_data(34) -radix decimal} {/tb_infrared/DUT/ram_data(35) -radix decimal} {/tb_infrared/DUT/ram_data(36) -radix decimal} {/tb_infrared/DUT/ram_data(37) -radix decimal} {/tb_infrared/DUT/ram_data(38) -radix decimal} {/tb_infrared/DUT/ram_data(39) -radix decimal} {/tb_infrared/DUT/ram_data(40) -radix decimal} {/tb_infrared/DUT/ram_data(41) -radix decimal} {/tb_infrared/DUT/ram_data(42) -radix decimal} {/tb_infrared/DUT/ram_data(43) -radix decimal} {/tb_infrared/DUT/ram_data(44) -radix decimal} {/tb_infrared/DUT/ram_data(45) -radix decimal} {/tb_infrared/DUT/ram_data(46) -radix decimal} {/tb_infrared/DUT/ram_data(47) -radix decimal} {/tb_infrared/DUT/ram_data(48) -radix decimal} {/tb_infrared/DUT/ram_data(49) -radix decimal} {/tb_infrared/DUT/ram_data(50) -radix decimal} {/tb_infrared/DUT/ram_data(51) -radix decimal} {/tb_infrared/DUT/ram_data(52) -radix decimal} {/tb_infrared/DUT/ram_data(53) -radix decimal} {/tb_infrared/DUT/ram_data(54) -radix decimal} {/tb_infrared/DUT/ram_data(55) -radix decimal} {/tb_infrared/DUT/ram_data(56) -radix decimal} {/tb_infrared/DUT/ram_data(57) -radix decimal} {/tb_infrared/DUT/ram_data(58) -radix decimal} {/tb_infrared/DUT/ram_data(59) -radix decimal} {/tb_infrared/DUT/ram_data(60) -radix decimal} {/tb_infrared/DUT/ram_data(61) -radix decimal} {/tb_infrared/DUT/ram_data(62) -radix decimal} {/tb_infrared/DUT/ram_data(63) -radix decimal} {/tb_infrared/DUT/ram_data(64) -radix decimal} {/tb_infrared/DUT/ram_data(65) -radix decimal} {/tb_infrared/DUT/ram_data(66) -radix decimal} {/tb_infrared/DUT/ram_data(67) -radix decimal} {/tb_infrared/DUT/ram_data(68) -radix decimal} {/tb_infrared/DUT/ram_data(69) -radix decimal} {/tb_infrared/DUT/ram_data(70) -radix decimal} {/tb_infrared/DUT/ram_data(71) -radix decimal} {/tb_infrared/DUT/ram_data(72) -radix decimal} {/tb_infrared/DUT/ram_data(73) -radix decimal} {/tb_infrared/DUT/ram_data(74) -radix decimal} {/tb_infrared/DUT/ram_data(75) -radix decimal} {/tb_infrared/DUT/ram_data(76) -radix decimal} {/tb_infrared/DUT/ram_data(77) -radix decimal} {/tb_infrared/DUT/ram_data(78) -radix decimal} {/tb_infrared/DUT/ram_data(79) -radix decimal} {/tb_infrared/DUT/ram_data(80) -radix decimal} {/tb_infrared/DUT/ram_data(81) -radix decimal} {/tb_infrared/DUT/ram_data(82) -radix decimal} {/tb_infrared/DUT/ram_data(83) -radix decimal} {/tb_infrared/DUT/ram_data(84) -radix decimal} {/tb_infrared/DUT/ram_data(85) -radix decimal} {/tb_infrared/DUT/ram_data(86) -radix decimal} {/tb_infrared/DUT/ram_data(87) -radix decimal} {/tb_infrared/DUT/ram_data(88) -radix decimal} {/tb_infrared/DUT/ram_data(89) -radix decimal} {/tb_infrared/DUT/ram_data(90) -radix decimal} {/tb_infrared/DUT/ram_data(91) -radix decimal} {/tb_infrared/DUT/ram_data(92) -radix decimal} {/tb_infrared/DUT/ram_data(93) -radix decimal} {/tb_infrared/DUT/ram_data(94) -radix decimal} {/tb_infrared/DUT/ram_data(95) -radix decimal} {/tb_infrared/DUT/ram_data(96) -radix decimal} {/tb_infrared/DUT/ram_data(97) -radix decimal} {/tb_infrared/DUT/ram_data(98) -radix decimal} {/tb_infrared/DUT/ram_data(99) -radix decimal} {/tb_infrared/DUT/ram_data(100) -radix decimal} {/tb_infrared/DUT/ram_data(101) -radix decimal} {/tb_infrared/DUT/ram_data(102) -radix decimal} {/tb_infrared/DUT/ram_data(103) -radix decimal} {/tb_infrared/DUT/ram_data(104) -radix decimal} {/tb_infrared/DUT/ram_data(105) -radix decimal} {/tb_infrared/DUT/ram_data(106) -radix decimal} {/tb_infrared/DUT/ram_data(107) -radix decimal} {/tb_infrared/DUT/ram_data(108) -radix decimal} {/tb_infrared/DUT/ram_data(109) -radix decimal} {/tb_infrared/DUT/ram_data(110) -radix decimal} {/tb_infrared/DUT/ram_data(111) -radix decimal} {/tb_infrared/DUT/ram_data(112) -radix decimal} {/tb_infrared/DUT/ram_data(113) -radix decimal} {/tb_infrared/DUT/ram_data(114) -radix decimal} {/tb_infrared/DUT/ram_data(115) -radix decimal} {/tb_infrared/DUT/ram_data(116) -radix decimal} {/tb_infrared/DUT/ram_data(117) -radix decimal} {/tb_infrared/DUT/ram_data(118) -radix decimal} {/tb_infrared/DUT/ram_data(119) -radix decimal} {/tb_infrared/DUT/ram_data(120) -radix decimal} {/tb_infrared/DUT/ram_data(121) -radix decimal} {/tb_infrared/DUT/ram_data(122) -radix decimal} {/tb_infrared/DUT/ram_data(123) -radix decimal} {/tb_infrared/DUT/ram_data(124) -radix decimal} {/tb_infrared/DUT/ram_data(125) -radix decimal} {/tb_infrared/DUT/ram_data(126) -radix decimal} {/tb_infrared/DUT/ram_data(127) -radix decimal} {/tb_infrared/DUT/ram_data(128) -radix decimal} {/tb_infrared/DUT/ram_data(129) -radix decimal} {/tb_infrared/DUT/ram_data(130) -radix decimal} {/tb_infrared/DUT/ram_data(131) -radix decimal} {/tb_infrared/DUT/ram_data(132) -radix decimal} {/tb_infrared/DUT/ram_data(133) -radix decimal} {/tb_infrared/DUT/ram_data(134) -radix decimal} {/tb_infrared/DUT/ram_data(135) -radix decimal} {/tb_infrared/DUT/ram_data(136) -radix decimal} {/tb_infrared/DUT/ram_data(137) -radix decimal} {/tb_infrared/DUT/ram_data(138) -radix decimal} {/tb_infrared/DUT/ram_data(139) -radix decimal} {/tb_infrared/DUT/ram_data(140) -radix decimal} {/tb_infrared/DUT/ram_data(141) -radix decimal} {/tb_infrared/DUT/ram_data(142) -radix decimal} {/tb_infrared/DUT/ram_data(143) -radix decimal} {/tb_infrared/DUT/ram_data(144) -radix decimal} {/tb_infrared/DUT/ram_data(145) -radix decimal} {/tb_infrared/DUT/ram_data(146) -radix decimal} {/tb_infrared/DUT/ram_data(147) -radix decimal} {/tb_infrared/DUT/ram_data(148) -radix decimal} {/tb_infrared/DUT/ram_data(149) -radix decimal} {/tb_infrared/DUT/ram_data(150) -radix decimal} {/tb_infrared/DUT/ram_data(151) -radix decimal} {/tb_infrared/DUT/ram_data(152) -radix decimal} {/tb_infrared/DUT/ram_data(153) -radix decimal} {/tb_infrared/DUT/ram_data(154) -radix decimal} {/tb_infrared/DUT/ram_data(155) -radix decimal} {/tb_infrared/DUT/ram_data(156) -radix decimal} {/tb_infrared/DUT/ram_data(157) -radix decimal} {/tb_infrared/DUT/ram_data(158) -radix decimal} {/tb_infrared/DUT/ram_data(159) -radix decimal} {/tb_infrared/DUT/ram_data(160) -radix decimal} {/tb_infrared/DUT/ram_data(161) -radix decimal} {/tb_infrared/DUT/ram_data(162) -radix decimal} {/tb_infrared/DUT/ram_data(163) -radix decimal} {/tb_infrared/DUT/ram_data(164) -radix decimal} {/tb_infrared/DUT/ram_data(165) -radix decimal} {/tb_infrared/DUT/ram_data(166) -radix decimal} {/tb_infrared/DUT/ram_data(167) -radix decimal} {/tb_infrared/DUT/ram_data(168) -radix decimal} {/tb_infrared/DUT/ram_data(169) -radix decimal} {/tb_infrared/DUT/ram_data(170) -radix decimal} {/tb_infrared/DUT/ram_data(171) -radix decimal} {/tb_infrared/DUT/ram_data(172) -radix decimal} {/tb_infrared/DUT/ram_data(173) -radix decimal} {/tb_infrared/DUT/ram_data(174) -radix decimal} {/tb_infrared/DUT/ram_data(175) -radix decimal} {/tb_infrared/DUT/ram_data(176) -radix decimal} {/tb_infrared/DUT/ram_data(177) -radix decimal} {/tb_infrared/DUT/ram_data(178) -radix decimal} {/tb_infrared/DUT/ram_data(179) -radix decimal} {/tb_infrared/DUT/ram_data(180) -radix decimal} {/tb_infrared/DUT/ram_data(181) -radix decimal} {/tb_infrared/DUT/ram_data(182) -radix decimal} {/tb_infrared/DUT/ram_data(183) -radix decimal} {/tb_infrared/DUT/ram_data(184) -radix decimal} {/tb_infrared/DUT/ram_data(185) -radix decimal} {/tb_infrared/DUT/ram_data(186) -radix decimal} {/tb_infrared/DUT/ram_data(187) -radix decimal} {/tb_infrared/DUT/ram_data(188) -radix decimal} {/tb_infrared/DUT/ram_data(189) -radix decimal} {/tb_infrared/DUT/ram_data(190) -radix decimal} {/tb_infrared/DUT/ram_data(191) -radix decimal} {/tb_infrared/DUT/ram_data(192) -radix decimal} {/tb_infrared/DUT/ram_data(193) -radix decimal} {/tb_infrared/DUT/ram_data(194) -radix decimal} {/tb_infrared/DUT/ram_data(195) -radix decimal} {/tb_infrared/DUT/ram_data(196) -radix decimal} {/tb_infrared/DUT/ram_data(197) -radix decimal} {/tb_infrared/DUT/ram_data(198) -radix decimal} {/tb_infrared/DUT/ram_data(199) -radix decimal} {/tb_infrared/DUT/ram_data(200) -radix decimal} {/tb_infrared/DUT/ram_data(201) -radix decimal} {/tb_infrared/DUT/ram_data(202) -radix decimal} {/tb_infrared/DUT/ram_data(203) -radix decimal} {/tb_infrared/DUT/ram_data(204) -radix decimal} {/tb_infrared/DUT/ram_data(205) -radix decimal} {/tb_infrared/DUT/ram_data(206) -radix decimal} {/tb_infrared/DUT/ram_data(207) -radix decimal} {/tb_infrared/DUT/ram_data(208) -radix decimal} {/tb_infrared/DUT/ram_data(209) -radix decimal} {/tb_infrared/DUT/ram_data(210) -radix decimal} {/tb_infrared/DUT/ram_data(211) -radix decimal} {/tb_infrared/DUT/ram_data(212) -radix decimal} {/tb_infrared/DUT/ram_data(213) -radix decimal} {/tb_infrared/DUT/ram_data(214) -radix decimal} {/tb_infrared/DUT/ram_data(215) -radix decimal} {/tb_infrared/DUT/ram_data(216) -radix decimal} {/tb_infrared/DUT/ram_data(217) -radix decimal} {/tb_infrared/DUT/ram_data(218) -radix decimal} {/tb_infrared/DUT/ram_data(219) -radix decimal} {/tb_infrared/DUT/ram_data(220) -radix decimal} {/tb_infrared/DUT/ram_data(221) -radix decimal} {/tb_infrared/DUT/ram_data(222) -radix decimal} {/tb_infrared/DUT/ram_data(223) -radix decimal} {/tb_infrared/DUT/ram_data(224) -radix decimal} {/tb_infrared/DUT/ram_data(225) -radix decimal} {/tb_infrared/DUT/ram_data(226) -radix decimal} {/tb_infrared/DUT/ram_data(227) -radix decimal} {/tb_infrared/DUT/ram_data(228) -radix decimal} {/tb_infrared/DUT/ram_data(229) -radix decimal} {/tb_infrared/DUT/ram_data(230) -radix decimal} {/tb_infrared/DUT/ram_data(231) -radix decimal} {/tb_infrared/DUT/ram_data(232) -radix decimal} {/tb_infrared/DUT/ram_data(233) -radix decimal} {/tb_infrared/DUT/ram_data(234) -radix decimal} {/tb_infrared/DUT/ram_data(235) -radix decimal} {/tb_infrared/DUT/ram_data(236) -radix decimal} {/tb_infrared/DUT/ram_data(237) -radix decimal} {/tb_infrared/DUT/ram_data(238) -radix decimal} {/tb_infrared/DUT/ram_data(239) -radix decimal} {/tb_infrared/DUT/ram_data(240) -radix decimal} {/tb_infrared/DUT/ram_data(241) -radix decimal} {/tb_infrared/DUT/ram_data(242) -radix decimal} {/tb_infrared/DUT/ram_data(243) -radix decimal} {/tb_infrared/DUT/ram_data(244) -radix decimal} {/tb_infrared/DUT/ram_data(245) -radix decimal} {/tb_infrared/DUT/ram_data(246) -radix decimal} {/tb_infrared/DUT/ram_data(247) -radix decimal} {/tb_infrared/DUT/ram_data(248) -radix decimal} {/tb_infrared/DUT/ram_data(249) -radix decimal} {/tb_infrared/DUT/ram_data(250) -radix decimal} {/tb_infrared/DUT/ram_data(251) -radix decimal} {/tb_infrared/DUT/ram_data(252) -radix decimal} {/tb_infrared/DUT/ram_data(253) -radix decimal} {/tb_infrared/DUT/ram_data(254) -radix decimal} {/tb_infrared/DUT/ram_data(255) -radix decimal}} -subitemconfig {/tb_infrared/DUT/ram_data(0) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(1) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(2) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(3) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(4) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(5) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(6) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(7) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(8) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(9) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(10) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(11) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(12) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(13) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(14) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(15) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(16) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(17) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(18) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(19) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(20) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(21) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(22) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(23) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(24) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(25) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(26) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(27) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(28) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(29) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(30) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(31) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(32) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(33) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(34) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(35) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(36) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(37) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(38) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(39) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(40) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(41) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(42) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(43) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(44) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(45) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(46) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(47) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(48) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(49) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(50) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(51) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(52) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(53) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(54) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(55) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(56) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(57) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(58) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(59) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(60) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(61) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(62) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(63) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(64) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(65) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(66) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(67) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(68) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(69) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(70) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(71) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(72) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(73) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(74) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(75) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(76) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(77) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(78) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(79) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(80) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(81) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(82) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(83) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(84) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(85) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(86) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(87) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(88) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(89) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(90) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(91) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(92) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(93) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(94) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(95) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(96) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(97) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(98) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(99) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(100) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(101) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(102) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(103) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(104) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(105) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(106) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(107) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(108) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(109) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(110) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(111) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(112) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(113) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(114) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(115) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(116) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(117) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(118) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(119) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(120) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(121) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(122) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(123) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(124) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(125) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(126) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(127) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(128) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(129) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(130) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(131) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(132) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(133) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(134) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(135) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(136) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(137) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(138) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(139) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(140) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(141) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(142) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(143) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(144) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(145) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(146) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(147) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(148) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(149) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(150) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(151) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(152) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(153) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(154) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(155) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(156) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(157) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(158) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(159) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(160) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(161) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(162) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(163) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(164) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(165) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(166) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(167) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(168) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(169) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(170) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(171) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(172) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(173) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(174) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(175) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(176) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(177) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(178) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(179) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(180) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(181) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(182) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(183) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(184) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(185) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(186) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(187) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(188) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(189) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(190) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(191) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(192) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(193) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(194) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(195) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(196) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(197) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(198) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(199) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(200) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(201) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(202) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(203) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(204) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(205) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(206) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(207) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(208) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(209) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(210) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(211) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(212) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(213) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(214) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(215) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(216) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(217) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(218) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(219) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(220) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(221) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(222) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(223) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(224) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(225) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(226) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(227) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(228) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(229) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(230) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(231) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(232) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(233) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(234) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(235) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(236) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(237) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(238) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(239) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(240) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(241) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(242) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(243) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(244) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(245) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(246) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(247) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(248) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(249) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(250) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(251) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(252) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(253) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(254) {-height 16 -radix decimal} /tb_infrared/DUT/ram_data(255) {-height 16 -radix decimal}} /tb_infrared/DUT/ram_data
add wave -noupdate -divider timestamp_counter
add wave -noupdate /tb_infrared/DUT/timestamp_counter_inst/clk_i
add wave -noupdate /tb_infrared/DUT/timestamp_counter_inst/rst_n_i
add wave -noupdate /tb_infrared/DUT/timestamp_counter_inst/enable_i
add wave -noupdate /tb_infrared/DUT/timestamp_counter_inst/overflow_o
add wave -noupdate /tb_infrared/DUT/timestamp_counter_inst/count_o
add wave -noupdate /tb_infrared/DUT/timestamp_counter_inst/count
add wave -noupdate /tb_infrared/DUT/timestamp_counter_inst/overflow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1530000 ps} 0} {{Cursor 2} {241876 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 415
configure wave -valuecolwidth 164
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {31500 ns}
