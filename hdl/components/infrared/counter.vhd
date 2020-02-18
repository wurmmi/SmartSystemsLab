-------------------------------------------------------------------------------
--! @file      counter.vhd
--! @author    Michael Wurm <wurm.michael95@gmail.com>
--! @copyright 2020 Michael Wurm
--! @brief     Entity implementation of counter.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! @brief Entity declaration of counter
--! @details
--! Provides a counter value of clock ticks of clk_i.
--! The counter is free-running, and thus overflows at its maximum.

entity counter is
  port (
    --! @name Clocks and resets
    --! @{

    --! System clock
    clk_i   : in std_logic;
    --! Asynchronous reset
    rst_n_i : in std_logic;

    --! @}
    --! @name Control signals
    --! @{

    --! Enable
    enable_i : in  std_ulogic;
    --! Generated strobe
    count_o : out std_ulogic_vector(31 downto 0));

  --! @}

end entity counter;

--! RTL implementation of counter
architecture rtl of counter is
  -----------------------------------------------------------------------------
  --! @name Internal Registers
  -----------------------------------------------------------------------------
  --! @{

  signal count : unsigned(count_o'range);

  --! @}
  -----------------------------------------------------------------------------
  --! @name Internal Wires
  -----------------------------------------------------------------------------
  --! @{


  --! @}

begin  -- architecture rtl

  ------------------------------------------------------------------------------
  -- Outputs
  ------------------------------------------------------------------------------

  count_o <= count;

  -----------------------------------------------------------------------------
  -- Signal Assignments
  -----------------------------------------------------------------------------

  ------------------------------------------------------------------------------
  -- Registers
  ------------------------------------------------------------------------------

  regs : process (clk_i, rst_n_i) is
    procedure reset is
    begin
      count <= to_unsigned(0, count'length);
    end procedure reset;
  begin  -- process strobe
    if rst_n_i = '0' then
      reset;
    elsif rising_edge(clk_i) then
      if enable_i = '0' then
        reset;
      else
        count <= count + 1;
      end if;
    end if;
  end process regs;

end architecture rtl;
