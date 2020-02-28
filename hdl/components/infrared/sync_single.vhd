-------------------------------------------------------------------------------
--! @file      sync_single.vhd
--! @author    Michael Wurm <wurm.michael95@gmail.com>
--! @copyright 2020 Michael Wurm
--! @brief     Implementation of sync_single.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--! @brief Entity declaration of sync_single
--! @details
--! The sync_single implementation.

entity sync_single is
  generic (
    init_value_g : std_ulogic := '0';
    num_delays_g : natural    := 2);
  port (
    --! @name Clocks and resets
    --! @{

    --! System clock
    clk_i   : in std_ulogic;
    --! Asynchronous reset
    rst_n_i : in std_ulogic;

    --! @}
    --! @name Sync signals
    --! @{

    --! Asynchronous input
    async_i : in  std_ulogic;
    --! Synchronous output
    sync_o  : out std_ulogic);

  --! @}

end entity sync_single;

--! RTL implementation of sync_single
architecture rtl of sync_single is
  -----------------------------------------------------------------------------
  --! @name Internal Registers
  -----------------------------------------------------------------------------
  --! @{

  signal delay : std_ulogic_vector(num_delays_g-1 downto 0) := (others => '0');

  --! @}
  -----------------------------------------------------------------------------
  --! @name Internal Wires
  -----------------------------------------------------------------------------
  --! @{

  signal next_delay : std_ulogic_vector(delay'range);

  --! @}

begin  -- architecture rtl

  ------------------------------------------------------------------------------
  -- Outputs
  ------------------------------------------------------------------------------

  sync_o <= delay(delay'high);

  -----------------------------------------------------------------------------
  -- Signal Assignments
  -----------------------------------------------------------------------------

  next_delay <= delay(delay'high-1 downto delay'low) & async_i;

  ------------------------------------------------------------------------------
  -- Registers
  ------------------------------------------------------------------------------

  regs : process(clk_i, rst_n_i)
    procedure reset is
    begin
      delay <= (others => init_value_g);
    end procedure reset;
  begin  -- process regs
    if rst_n_i = '0' then
      reset;
    elsif rising_edge(clk_i) then
      delay <= next_delay;
    end if;
  end process regs;

end architecture rtl;
