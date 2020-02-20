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
--! Stores timestamps on every change of the IR LED input.
--! In that way, a sequence can be recorded and reproduced afterwards.

entity infrared is
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
    avs_s0_waitrequest : out std_logic;

    --! @}
    --! @name Infrared transceiver signals
    --! @{

    --! IR Receive
    ir_rx_i : in std_logic;
    --! IR Transmit
    ir_tx_o : out std_logic;

    --! @}
    --! @name Status signals
    --! @{

    --! Done recording interrupt
    done_recording_irq_o : out std_logic;
    --! IR Receive Mirror
    ir_rx_o : out std_logic);

  --! @}

end entity infrared;

--! RTL implementation of infrared
architecture rtl of infrared is
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
  signal ctrl_readdata : timestamp_t := (others => '0');

  signal store_addr            : unsigned(7 downto 0) := (others => '0');
  signal ir_rx           : std_ulogic_vector(1 downto 0) := (others => '0');
  signal store_timestamp : std_ulogic := '0';
  signal irq_active : std_ulogic  := '0';
  signal irq_reset  : std_ulogic  := '0';

  --! @}
  -----------------------------------------------------------------------------
  --! @name Internal Wires
  -----------------------------------------------------------------------------
  --! @{

  signal ir_rx_sync : std_ulogic;
  signal next_ir_rx : std_ulogic_vector(1 downto 0);
  signal rising     : std_ulogic;
  signal falling    : std_ulogic;
  signal recording_stopped : std_ulogic;
  signal timestamp : timestamp_t;
  signal ctrl_access : std_ulogic;
  signal end_of_sequence : std_ulogic;

  --! @}

begin  -- architecture rtl

  ------------------------------------------------------------------------------
  -- Outputs
  ------------------------------------------------------------------------------

  ir_rx_o <= ir_rx(ir_rx'high); -- mirror rx signal (for debug only)
  ir_tx_o <= ir_rx(ir_rx'high); -- mirror rx signal (until tx is implemented)
  avs_s0_readdata <= std_logic_vector(ram_readdata) when ctrl_access = '0'
                     else std_logic_vector(ctrl_readdata);
  done_recording_irq_o <= irq_active;

  -----------------------------------------------------------------------------
  -- Signal Assignments
  -----------------------------------------------------------------------------

  next_ir_rx <= ir_rx(ir_rx'high-1 downto ir_rx'low) & ir_rx_sync;
  rising     <= '1' when ir_rx(1)='0' and ir_rx(0)='1' else '0';
  falling    <= '1' when ir_rx(1)='1' and ir_rx(0)='0' else '0';
  ctrl_access <= '1' when to_integer(unsigned(avs_s0_address)) > ram_t'length-1 else '0';
  end_of_sequence <= '1' when to_integer(store_addr) > 0 and ir_rx(1) = '1' else '0';

  -----------------------------------------------------------------------------
  -- Instantiations
  -----------------------------------------------------------------------------

  sync_inst : entity work.sync_single
    generic map (
      init_value_g => '0',
      num_delays_g => 2)
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      async_i => ir_rx_i,
      sync_o  => ir_rx_sync);

  timestamp_counter_inst : entity work.counter
    generic map (
      counter_width_g => 32)
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_n_i,
        enable_i => '1',
        overflow_o => open,
        count_o  => timestamp);

  stop_counter_inst : entity work.counter
    generic map (
      counter_width_g => 10) -- 2^25 steps @ 50MHz => 0.6711 sec
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_n_i,
        enable_i => end_of_sequence,
        overflow_o => recording_stopped,
        count_o  => open);

  ------------------------------------------------------------------------------
  -- Registers
  ------------------------------------------------------------------------------

  regs : process (clk_i, rst_n_i) is
    procedure reset is
    begin
      store_addr  <= to_unsigned(0, store_addr'length);
      store_timestamp <= '0';
      irq_active <= '0';
    end procedure reset;
  begin  -- process strobe
    if rst_n_i = '0' then
      reset;
    elsif rising_edge(clk_i) then
      -- Defaults
      ir_rx <= next_ir_rx;
      store_timestamp <= '0';

      if rising = '1' or falling = '1' then
        store_addr <= store_addr + 1;
        store_timestamp <= '1';
      elsif recording_stopped = '1' then
        irq_active <= '1';
        store_addr <= (others => '0');
      end if;
      if irq_reset = '1' then
        irq_active <= '0';
      end if;
    end if;
  end process regs;

  ram : process (clk_i) is
  begin
    if rising_edge(clk_i) then
      if store_timestamp = '1' then
        ram_data(to_integer(store_addr)) <= timestamp;
        end if;

      if avs_s0_read = '1' then
        ram_readdata <= ram_data(to_integer(unsigned(avs_s0_address(store_addr'range))));
      end if;
    end if;
  end process ram;

  ctrl_interface : process (clk_i) is
    procedure reset is
    begin
      ctrl_readdata <= (others => '0');
      irq_reset <= '0';
    end procedure reset;
  begin -- process ctrl_interface
      if rst_n_i = '0' then
        reset;
      elsif rising_edge(clk_i) then
        if avs_s0_read = '1' then
          -- Defaults
          ctrl_readdata <= (others => '0');
          irq_reset <= '0';

          -- addresses higher 255
          case (to_integer(unsigned(avs_s0_address(avs_s0_address'high downto store_addr'high+1)))) is
            when 0 => -- magic number
              ctrl_readdata <= x"ABCD1234";
            when 1 => -- magic number
              ctrl_readdata <= x"11111111";
            when 2 => -- magic number
              ctrl_readdata <= x"22222222";
            when 3 => -- magic number
              ctrl_readdata <= x"33333333";
            when 4 => -- read and clear irq status
              ctrl_readdata(0) <= irq_active;
              irq_reset <= '1';
            when others =>
              ctrl_readdata <= x"DEADBEEF";
          end case;
        end if;
      end if;
  end process ctrl_interface;

end architecture rtl;
