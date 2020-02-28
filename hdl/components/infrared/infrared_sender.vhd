-------------------------------------------------------------------------------
--! @file      infrared_sender.vhd
--! @author    Michael Wurm <wurm.michael95@gmail.com>
--! @copyright 2020 Michael Wurm
--! @brief     Implementation of infrared_sender.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! @brief Entity declaration of infrared_sender
--! @details
--! Implements an interface to receive timestamps and store them.
--! The IR output signal changes, whenever the local time matches a timestamp.

entity infrared_sender is
  port (
    --! @name Clocks and resets
    --! @{

    --! System clock
    clk_i   : in std_logic;
    --! Asynchronous reset
    rst_n_i : in std_logic;

    --! @}
    --! @name Avalon MM Bus
    --! @{
    avs_s0_address     : in  std_logic_vector(10 downto 0);
    avs_s0_read        : in  std_logic;
    avs_s0_readdata    : out std_logic_vector(31 downto 0);
    avs_s0_write       : in  std_logic;
    avs_s0_writedata   : in  std_logic_vector(31 downto 0);

    --! @}
    --! @name Infrared transmitter signals
    --! @{

    --! IR transmitter signel
    ir_tx_o : out std_logic;

    --! @}
    --! @name Status signals
    --! @{

    --! Done replaying of IR sequence
    done_replay_o : out std_logic;
    --! Start replay of IR sequence
    start_replay_i : in std_logic);

  --! @}

end entity infrared_sender;

--! RTL implementation of infrared_sender
architecture rtl of infrared_sender is

  -----------------------------------------------------------------------------
  --! @name Types and Constants
  -----------------------------------------------------------------------------
  --! @{

  --! @}
  -----------------------------------------------------------------------------
  --! @name Internal Registers
  -----------------------------------------------------------------------------
  --! @{

  subtype timestamp_t is unsigned(31 downto 0);
  type ram_t is array(0 to 255) of timestamp_t;

  signal ram_data : ram_t := (others => (others => '0'));
  signal ram_readdata : timestamp_t := (others => '0');
  signal ram_addr : unsigned(7 downto 0) := (others => '0');

  signal replay_done : std_ulogic;
  signal replay_running : std_ulogic;
  signal ir_tx : std_ulogic;

  --! @}
  -----------------------------------------------------------------------------
  --! @name Internal Wires
  -----------------------------------------------------------------------------
  --! @{

  signal timestamp : timestamp_t;
  signal end_of_sequence : std_ulogic;
  signal timestamp_match : std_ulogic;

  --! @}

begin  -- architecture rtl

  ------------------------------------------------------------------------------
  -- Outputs
  ------------------------------------------------------------------------------

  done_replay_o <= replay_done;
  ir_tx_o <= ir_tx;

  -----------------------------------------------------------------------------
  -- Signal Assignments
  -----------------------------------------------------------------------------

  timestamp_match <= '1' when timestamp = ram_readdata else '0';
  end_of_sequence <= '1' when to_integer(ram_addr) > 5 and
                              ram_readdata = (others => '0')
                      else '0';

  -----------------------------------------------------------------------------
  -- Instantiations
  -----------------------------------------------------------------------------

  timestamp_counter_inst : entity work.counter
    generic map (
      counter_width_g => 32)
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_n_i,
        enable_i => replay_running,
        overflow_o => open,
        count_o  => timestamp);

  ------------------------------------------------------------------------------
  -- Registers
  ------------------------------------------------------------------------------

  regs : process (clk_i, rst_n_i) is
    procedure reset is
    begin
      ram_addr  <= to_unsigned(0, ram_addr'length);
      replay_running <= '0';
      replay_done <= '0';
      ir_tx <= '1'; -- default IR signal value
    end procedure reset;
  begin  -- process strobe
    if rst_n_i = '0' then
      reset;
    elsif rising_edge(clk_i) then
      -- Defaults

      if start_replay_i = '1' and replay_running = '0' then
        replay_running <= '1';
        replay_done <= '0';
      end if;

      if timestamp_match = '1' then
        ram_addr <= ram_addr + 1;
        ir_tx <= not ir_tx; -- toggle IR signal with a timestamp match
      end if;

      if end_of_sequence = '1' then
        ram_addr <= to_unsigned(0, ram_addr'length);
        replay_running <= '0';
        replay_done <= '1';
      end if;
    end if;
  end process regs;

  ram : process (clk_i) is
  begin
    if rising_edge(clk_i) then
      if avs_s0_write = '1' then
        ram_data(to_integer(avs_s0_address(ram_addr'range))) <=
          unsigned(avs_s0_writedata);
        end if;

      if replay_running = '1' then
        ram_readdata <= ram_data(to_integer(unsigned(avs_s0_address(ram_addr'range))));
      end if;
    end if;
  end process ram;

end architecture rtl;
