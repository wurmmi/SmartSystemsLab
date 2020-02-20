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
  generic (
    counter_width_g : natural := 32);
  port (
    --! @name Clocks and resets
    --! @{

    --! System clock
    clk_i   : in std_logic;
    --! Asynchronous reset
    rst_n_i : in std_logic;

    --! @}
    --! @name Control and status signals
    --! @{

    --! Enable
    enable_i : in  std_ulogic;
    --! Overflow
    overflow_o : out std_ulogic;
    --! Generated strobe
    count_o : out unsigned(counter_width_g-1 downto 0));

  --! @}

end entity counter;

--! RTL implementation of counter
architecture rtl of counter is

  -----------------------------------------------------------------------------
  --! @name Types and Constants
  -----------------------------------------------------------------------------
  --! @{

  constant max_count_c : unsigned(count_o'range) := (others => '1');

  --! @}

  -----------------------------------------------------------------------------
  --! @name Internal Registers
  -----------------------------------------------------------------------------
  --! @{

  signal count : unsigned(count_o'range);
  signal overflow : std_ulogic := '0';

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

  count_o    <= count;
  overflow_o <= overflow;

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
      overflow <= '0';
    end procedure reset;
  begin  -- process regs
    if rst_n_i = '0' then
      reset;
    elsif rising_edge(clk_i) then
      -- Defaults
      overflow <= '0';

      if enable_i = '0' then
        reset;
      else
        count <= count + 1;
        if count = max_count_c then
          overflow <= '1';
        end if;
      end if;
    end if;
  end process regs;

end architecture rtl;
