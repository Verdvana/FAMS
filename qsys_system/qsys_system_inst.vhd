	component qsys_system is
		port (
			clk_clk           : in  std_logic                     := 'X';             -- clk
			end_o_export      : in  std_logic                     := 'X';             -- export
			heart_rate_export : out std_logic_vector(7 downto 0);                     -- export
			heignt_dec_export : out std_logic_vector(7 downto 0);                     -- export
			heignt_int_export : out std_logic_vector(7 downto 0);                     -- export
			max30102_0_export : in  std_logic_vector(23 downto 0) := (others => 'X'); -- export
			max30102_1_export : in  std_logic_vector(23 downto 0) := (others => 'X'); -- export
			reset_reset_n     : in  std_logic                     := 'X';             -- reset_n
			dig_t1_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_t2_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_t3_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_p1_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_p2_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_p3_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_p4_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_p5_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_p6_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_p7_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_p8_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dig_p9_export     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			adc_t_export      : in  std_logic_vector(23 downto 0) := (others => 'X'); -- export
			adc_p_export      : in  std_logic_vector(23 downto 0) := (others => 'X')  -- export
		);
	end component qsys_system;

	u0 : component qsys_system
		port map (
			clk_clk           => CONNECTED_TO_clk_clk,           --        clk.clk
			end_o_export      => CONNECTED_TO_end_o_export,      --      end_o.export
			heart_rate_export => CONNECTED_TO_heart_rate_export, -- heart_rate.export
			heignt_dec_export => CONNECTED_TO_heignt_dec_export, -- heignt_dec.export
			heignt_int_export => CONNECTED_TO_heignt_int_export, -- heignt_int.export
			max30102_0_export => CONNECTED_TO_max30102_0_export, -- max30102_0.export
			max30102_1_export => CONNECTED_TO_max30102_1_export, -- max30102_1.export
			reset_reset_n     => CONNECTED_TO_reset_reset_n,     --      reset.reset_n
			dig_t1_export     => CONNECTED_TO_dig_t1_export,     --     dig_t1.export
			dig_t2_export     => CONNECTED_TO_dig_t2_export,     --     dig_t2.export
			dig_t3_export     => CONNECTED_TO_dig_t3_export,     --     dig_t3.export
			dig_p1_export     => CONNECTED_TO_dig_p1_export,     --     dig_p1.export
			dig_p2_export     => CONNECTED_TO_dig_p2_export,     --     dig_p2.export
			dig_p3_export     => CONNECTED_TO_dig_p3_export,     --     dig_p3.export
			dig_p4_export     => CONNECTED_TO_dig_p4_export,     --     dig_p4.export
			dig_p5_export     => CONNECTED_TO_dig_p5_export,     --     dig_p5.export
			dig_p6_export     => CONNECTED_TO_dig_p6_export,     --     dig_p6.export
			dig_p7_export     => CONNECTED_TO_dig_p7_export,     --     dig_p7.export
			dig_p8_export     => CONNECTED_TO_dig_p8_export,     --     dig_p8.export
			dig_p9_export     => CONNECTED_TO_dig_p9_export,     --     dig_p9.export
			adc_t_export      => CONNECTED_TO_adc_t_export,      --      adc_t.export
			adc_p_export      => CONNECTED_TO_adc_p_export       --      adc_p.export
		);

