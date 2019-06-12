	component qsys_system is
		port (
			ain_ch0_export        : in  std_logic_vector(11 downto 0) := (others => 'X'); -- export
			ain_ch1_export        : in  std_logic_vector(11 downto 0) := (others => 'X'); -- export
			ain_ch2_export        : in  std_logic_vector(11 downto 0) := (others => 'X'); -- export
			ain_ch3_export        : in  std_logic_vector(11 downto 0) := (others => 'X'); -- export
			ain_ch4_export        : in  std_logic_vector(11 downto 0) := (others => 'X'); -- export
			clk_clk               : in  std_logic                     := 'X';             -- clk
			end_o_export          : in  std_logic                     := 'X';             -- export
			h2_one_export         : out std_logic_vector(3 downto 0);                     -- export
			h2_ten_export         : out std_logic_vector(3 downto 0);                     -- export
			harmful_one_export    : out std_logic_vector(3 downto 0);                     -- export
			harmful_ten_export    : out std_logic_vector(3 downto 0);                     -- export
			heart_rate_hun_export : out std_logic_vector(3 downto 0);                     -- export
			heart_rate_one_export : out std_logic_vector(3 downto 0);                     -- export
			heart_rate_ten_export : out std_logic_vector(3 downto 0);                     -- export
			liquefied_one_export  : out std_logic_vector(3 downto 0);                     -- export
			liquefied_ten_export  : out std_logic_vector(3 downto 0);                     -- export
			max30102_0_export     : in  std_logic_vector(23 downto 0) := (others => 'X'); -- export
			max30102_1_export     : in  std_logic_vector(23 downto 0) := (others => 'X'); -- export
			natural_one_export    : out std_logic_vector(3 downto 0);                     -- export
			natural_ten_export    : out std_logic_vector(3 downto 0);                     -- export
			oxy_one_export        : out std_logic_vector(3 downto 0);                     -- export
			oxy_ten_export        : out std_logic_vector(3 downto 0);                     -- export
			reset_reset_n         : in  std_logic                     := 'X'              -- reset_n
		);
	end component qsys_system;

	u0 : component qsys_system
		port map (
			ain_ch0_export        => CONNECTED_TO_ain_ch0_export,        --        ain_ch0.export
			ain_ch1_export        => CONNECTED_TO_ain_ch1_export,        --        ain_ch1.export
			ain_ch2_export        => CONNECTED_TO_ain_ch2_export,        --        ain_ch2.export
			ain_ch3_export        => CONNECTED_TO_ain_ch3_export,        --        ain_ch3.export
			ain_ch4_export        => CONNECTED_TO_ain_ch4_export,        --        ain_ch4.export
			clk_clk               => CONNECTED_TO_clk_clk,               --            clk.clk
			end_o_export          => CONNECTED_TO_end_o_export,          --          end_o.export
			h2_one_export         => CONNECTED_TO_h2_one_export,         --         h2_one.export
			h2_ten_export         => CONNECTED_TO_h2_ten_export,         --         h2_ten.export
			harmful_one_export    => CONNECTED_TO_harmful_one_export,    --    harmful_one.export
			harmful_ten_export    => CONNECTED_TO_harmful_ten_export,    --    harmful_ten.export
			heart_rate_hun_export => CONNECTED_TO_heart_rate_hun_export, -- heart_rate_hun.export
			heart_rate_one_export => CONNECTED_TO_heart_rate_one_export, -- heart_rate_one.export
			heart_rate_ten_export => CONNECTED_TO_heart_rate_ten_export, -- heart_rate_ten.export
			liquefied_one_export  => CONNECTED_TO_liquefied_one_export,  --  liquefied_one.export
			liquefied_ten_export  => CONNECTED_TO_liquefied_ten_export,  --  liquefied_ten.export
			max30102_0_export     => CONNECTED_TO_max30102_0_export,     --     max30102_0.export
			max30102_1_export     => CONNECTED_TO_max30102_1_export,     --     max30102_1.export
			natural_one_export    => CONNECTED_TO_natural_one_export,    --    natural_one.export
			natural_ten_export    => CONNECTED_TO_natural_ten_export,    --    natural_ten.export
			oxy_one_export        => CONNECTED_TO_oxy_one_export,        --        oxy_one.export
			oxy_ten_export        => CONNECTED_TO_oxy_ten_export,        --        oxy_ten.export
			reset_reset_n         => CONNECTED_TO_reset_reset_n          --          reset.reset_n
		);

