-------------------------------------------------------------------------------
--! @file      infrared.vhd
--! @author    Michael Wurm <wurm.michael95@gmail.com>
--! @copyright 2020 Michael Wurm
--! @brief     Entity implementation of infrared.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! @brief Entity declaration of infrared
--! @details
--! TODO

entity infrared is
  generic (
    --! System clock frequency
    clk_freq_g : natural := clk_freq_c;
    --! Period between two strobes
    period_g   : time    := 100 us);
  port (
    --! @name Clocks and resets
    --! @{

    --! System clock
    clk_i   : in std_logic;
    --! Asynchronous reset
    rst_n_i : in std_logic;

    --! @}
    --! @name Strobe signals
    --! @{

    --! Enable
    enable_i : in  std_ulogic;
    --! Generated strobe
    strobe_o : out std_ulogic);

  --! @}

begin

  -- pragma translate_off
  assert ((1 sec / clk_freq_g) <= period_g)
    report "infrared: The Clk frequency is to low to generate such a short strobe cycle."
    severity error;
  -- pragma translate_on

end entity infrared;

--! RTL implementation of infrared
architecture rtl of infrared is
  -----------------------------------------------------------------------------
  --! @name Types and Constants
  -----------------------------------------------------------------------------
  --! @{

  constant clks_per_strobe_c : natural := clk_freq_g / (1 sec / period_g);

  --! @}
  -----------------------------------------------------------------------------
  --! @name Internal Registers
  -----------------------------------------------------------------------------
  --! @{

  signal count : unsigned(log_dualis(clks_per_strobe_c) downto 0);

  --! @}
  -----------------------------------------------------------------------------
  --! @name Internal Wires
  -----------------------------------------------------------------------------
  --! @{

  signal strobe : std_ulogic;

  --! @}

begin  -- architecture rtl

  ------------------------------------------------------------------------------
  -- Outputs
  ------------------------------------------------------------------------------

  strobe_o <= strobe;

  ------------------------------------------------------------------------------
  -- Registers
  ------------------------------------------------------------------------------

  -- Count the number of clk_i cycles from strobe pulse to strobe pulse.
  regs : process (clk_i, rst_n_i) is
    procedure reset is
    begin
      count  <= to_unsigned(0, count'length);
      strobe <= '0';
    end procedure reset;
  begin  -- process strobe
    if rst_n_i = '0' then
      reset;
    elsif rising_edge(clk_i) then
      if enable_i = '0' then
        reset;
      else
        if count = clks_per_strobe_c-1 then
          count  <= (others => '0');
          strobe <= '1';
        else
          count  <= count + 1;
          strobe <= '0';
        end if;
      end if;
    end if;
  end process regs;

end architecture rtl;
