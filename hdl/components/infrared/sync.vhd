-------------------------------------------------------------------------------
--! @file      sync.vhd
--! @author    Michael Wurm <wurm.michael95@gmail.com>
--! @copyright 2020 Michael Wurm
--! @brief     Implementation of sync.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--! @brief Entity declaration of sync
--! @details
--! The sync implementation.

entity sync is
  generic (
    init_value_g : std_ulogic := '0';
    num_delays_g : natural    := 2;
    sig_width_g  : natural    := 1);
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
    async_i : in  std_ulogic_vector(sig_width_g-1 downto 0);
    --! Synchronous output
    sync_o  : out std_ulogic_vector(sig_width_g-1 downto 0));

  --! @}

end entity sync;

--! RTL implementation of sync
architecture rtl of sync is
  -----------------------------------------------------------------------------
  --! @name Types and Constants
  -----------------------------------------------------------------------------
  --! @{

  type delay_t is array(num_delays_g-1 downto 0) of
    std_ulogic_vector(sig_width_g-1 downto 0);

  --! @}
  -----------------------------------------------------------------------------
  --! @name Internal Registers
  -----------------------------------------------------------------------------
  --! @{

  signal delay : delay_t := (others => (others => init_value_g));

  --! @}
  -----------------------------------------------------------------------------
  --! @name Internal Wires
  -----------------------------------------------------------------------------
  --! @{

  signal next_delay : delay_t := (others => (others => init_value_g));

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
      delay <= (others => (others => init_value_g));
    end procedure reset;
  begin  -- process regs
    if rst_n_i = '0' then
      reset;
    elsif rising_edge(clk_i) then
      delay <= next_delay;
    end if;
  end process regs;

end architecture rtl;
