
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- 0 -> upper 16 bit: humidity, lower 16 bit: temperature
-- 1 -> lower word of timestamp
-- 2 -> upper word of timestamp

entity tb_infrared is
end entity tb_infrared;

architecture bhv of tb_infrared is
  signal avs_s0_address   : std_logic_vector(10 downto 0) := (others => '0'); -- avs_s0.address
  signal avs_s0_read      : std_logic                     := '0';             --       .read
  signal avs_s0_readdata  : std_logic_vector(31 downto 0);                    --       .readdata
  signal avs_s0_write     : std_logic                     := '0';             --       .write
  signal avs_s0_writedata : std_logic_vector(31 downto 0) := (others => '0'); --       .writedata
  signal clk              : std_logic                     := '0';             --  clock.clk
  signal nRst             : std_logic                     := '0';             --
  signal ir_rx            : std_logic                     := '0';             --
  signal ir_tx            : std_logic;
  signal irq              : std_logic;
  signal ir_rx_mirror     : std_logic;

  constant clk_cycle_duration_c  : time := 1 sec / 50E6; -- 50 MHz
  constant reset_duration_c : time := 20 * clk_cycle_duration_c;

begin

  nRst <= '1' after reset_duration_c;
  clk  <= not clk after clk_cycle_duration_c / 2;

  DUT : entity work.infrared
  port map (
    clk_i                => clk,
    rst_n_i              => nRst,
    avs_s0_address       => avs_s0_address,
    avs_s0_read          => avs_s0_read,
    avs_s0_readdata      => avs_s0_readdata,
    avs_s0_write         => avs_s0_write,
    avs_s0_writedata     => avs_s0_writedata,
    ir_rx_i              => ir_rx,
    ir_tx_o              => ir_tx,
    done_recording_irq_o => irq,
    ir_rx_o              => ir_rx_mirror);

  test_proc : process
  begin
    wait for reset_duration_c + 5 ns;
    ir_rx_input : for i in 0 to 10 loop
      ir_rx <= not ir_rx;
      wait for 100 ns;
    end loop;
    wait;
  end process test_proc;

  -- test_proc : process
  -- begin
  --   ir_rx_i <= '1';
  --   mpuInt     <= '1';
  --   wait for 700 ns;
  --   wait until clk = '0';

  --   reg_loop1 : for i in 0 to 10 loop
  --       avs_s0_address  <= std_logic_vector(to_unsigned(i, avs_s0_address'length));
  --       avs_s0_read     <= '1';

  --       wait until clk  <= '1';
  --       wait until clk  <= '0';
  --   end loop ; -- reg_loop

  --   avs_s0_address  <= X"0";
  --   avs_s0_read     <= '0';

  --   wait for 100 ns;
  --   wait until clk = '0';

  --   mpuInt <= '0';
  --   avm_m0_readdata <= X"0000DEAD";

  --   wait until clk = '1';
  --   wait until clk = '0';
  --   wait until clk = '1';
  --   wait until clk = '0';

  --   mpuInt <= '1';

  --   wait for 500 ns;
  --   wait until clk = '0';

  --   reg_loop2 : for i in 0 to 10 loop
  --       avs_s0_address  <= std_logic_vector(to_unsigned(i, avs_s0_address'length));
  --       avs_s0_read     <= '1';

  --       wait until clk  <= '1';
  --       wait until clk  <= '0';
  --   end loop ; -- reg_loop

  --   avs_s0_address  <= X"0";
  --   avs_s0_read     <= '0';

  --   wait;
  -- end process; -- test_proc

end architecture bhv; -- of new_component
