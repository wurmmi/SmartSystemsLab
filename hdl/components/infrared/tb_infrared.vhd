
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

begin -- architecture bhv

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

    -- Default sensor value (idle)
    ir_rx <= '1';
    wait for 200 * clk_cycle_duration_c;

    -- Generate infrared input signal
    ir_rx_input : for i in 0 to 10 loop
      ir_rx <= not ir_rx;
      wait for 10 * clk_cycle_duration_c;
    end loop;

    -- Default sensor value (idle)
    ir_rx <= '1';

    -- Wait for interrupt generation (end of recieved IR sequence)
    wait until irq = '1';
    report "(MWURM) IRQ occured (end of received IR sequence)." severity note;
    wait for 10 * clk_cycle_duration_c;

    -- Read data (RAM)
    read_ram_data : for i in 0 to 255 loop
        avs_s0_address  <= std_logic_vector(to_unsigned(i, avs_s0_address'length));
        avs_s0_read     <= '1';

        wait until clk  <= '1';
        wait until clk  <= '0';
        wait until clk  <= '1';
        wait until clk  <= '0';
    end loop read_ram_data;

    wait for 20 * clk_cycle_duration_c;

    -- Read data (control and status registers)
    read_ctrl_status_data : for i in 256 to 266 loop
        avs_s0_address  <= std_logic_vector(to_unsigned(i, avs_s0_address'length));
        avs_s0_read     <= '1';

        wait until clk  <= '1';
        wait until clk  <= '0';
        wait until clk  <= '1';
        wait until clk  <= '0';
    end loop read_ctrl_status_data;

    wait;
  end process test_proc;

end architecture bhv;
