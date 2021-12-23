library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_reti_logiche is
    port(
        i_clk       :   in std_logic;
        i_start     :   in std_logic;
        i_rst       :   in std_logic;
        i_data      :   in std_logic_vector(7 downto 0);
        o_address   :   out std_logic_vector(15 downto 0);
        o_done      :   out std_logic;
        o_en        :   out std_logic;
        o_we        :   out std_logic;
        o_data      :   out std_logic_vector(7 downto 0)
        );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is

    type state_type is (S0, S1, S2, S3, S4, S5);
    signal State : state_type;
    shared variable step: integer range 0 to 7;
    shared variable clk_cycle: integer range -1 to 1;
    shared variable data, wz_data, data_cod : std_logic_vector(7 downto 0);
        
begin

    process(i_clk, i_rst) is
    begin
        if(i_clk'event and i_clk = '1') then
            if(i_rst = '1') then
                State <= S0;
            else
                case State is
                    when S0 =>
                        -- Default values setting
                        o_done <= '0';
                        o_en <= '0';
                        o_we <= '0';
                        step := 0;
                        clk_cycle := -1;
                        data_cod := "00000000";
                        if(i_start = '1') then
                            -- Change of state
                            State <= S1;
                        else
                            State <= S0;
                        end if;
                        
                    when S1 =>
                        -- Condition to be sure that i_start remains high until the end of the computation (when o_done will go to 1)
                        if(i_start = '1') then
                            if(clk_cycle = -1) then
                                -- Read setting
                                o_en <= '1';
                                o_address <= "0000000000001000";
                                clk_cycle := 0;
                            elsif(clk_cycle = 0) then
                                -- Variables set in clk_cycle = -1 take the specified value
                                clk_cycle := 1;
                            else
                                -- Reading i_data value & Change of state
                                data := i_data;
                                clk_cycle := -1;
                                State <= S2;
                            end if;
                        else
                            State <= S0;
                        end if;
                    
                    when S2 =>
                        if(i_start = '1') then
                            if(clk_cycle = -1) then
                                -- Read setting
                                o_address <= std_logic_vector(to_unsigned(step, 16));
                                clk_cycle := 0;
                            elsif(clk_cycle = 0) then
                                -- Variables set in clk_cycle = -1 take the specified value
                                clk_cycle := 1;
                            else
                                wz_data := i_data;
                                -- Verification of the membership to one of the WZ
                                if(to_integer(unsigned(data - wz_data)) >= 0 and to_integer(unsigned(data - wz_data)) <= 3) then
                                    -- i_data belongs to the WZ (WZ_step) -> Change of state 
                                    clk_cycle := -1;
                                    State <= S3;
                                elsif(step = 7) then
                                    -- i_data does not belong to any WZ -> Change of state
                                    clk_cycle := -1;
                                    State <= S4;
                                else
                                    -- Variable increase step to the next value of WZ_num
                                    step := step + 1;
                                    clk_cycle := -1;
                                end if;
                            end if;
                        else
                            State <= S0;
                        end if;
                                                            
                    when S3 =>
                        if(i_start = '1') then
                            if(clk_cycle = -1) then
                                -- Setting the variables (Yes membership in WZ)
                                -- WZ_BIT = 1
                                data_cod(7) := '1';
                                -- WZ_NUM = WZ_step
                                data_cod(6 downto 4) := std_logic_vector(to_unsigned((step), 3));
                                -- WZ_OFFSET = WZ_(integer)(data-basic_index_WZ)
                                data_cod(to_integer(unsigned(data - wz_data))) := '1';
                                o_we <= '1';
                                o_address <= "0000000000001001";
                                clk_cycle := 0;
                            elsif(clk_cycle = 0) then
                                -- Variables set in clk_cycle = -1 take the specified value
                                clk_cycle := 1;
                            else
                                -- Writing the coded address & Change of state
                                o_data <= std_logic_vector(data_cod);
                                clk_cycle := -1;
                                State <= S5;
                            end if;
                        else
                            State <= S0;
                        end if;
                        
                    when S4 =>
                        if(i_start = '1') then
                            if(clk_cycle = -1) then
                            -- Setting the variables (No membership in WZ)
                                o_we <= '1';
                                o_address <= "0000000000001001";
                                clk_cycle := 0;
                            elsif(clk_cycle = 0) then
                                -- Variables set in clk_cycle = -1 take the specified value
                                clk_cycle := 1;
                            else
                                -- Writing the uncoded address & Change of state
                                o_data <= std_logic_vector(data);
                                clk_cycle := -1;
                                State <= S5;
                            end if;
                        else
                            State <= S0;
                        end if;
                        
                    when S5 =>
                    if(i_start = '1') then
                        if(clk_cycle = -1) then
                        -- Setting the variables
                            o_done <= '1';
                            clk_cycle := 0;
                        elsif(clk_cycle = 0) then
                            -- Variables set in clk_cycle = -1 take the specified value
                            clk_cycle := 1;
                        else    
                            -- o_done is set correctly & it remains in this state until i_start drops to 0
                            State <= S5;
                        end if;
                    else
                        State <= S0;
                    end if;
                        
                end case;
            end if;
        end if;
        
    end process;
    
end Behavioral;