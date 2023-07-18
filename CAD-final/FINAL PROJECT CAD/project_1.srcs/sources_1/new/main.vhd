library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_package.all;

entity Main is
    generic(n : integer:= 10);
    port(clk: in std_logic;
         output: out all_converted);
end Main;

architecture Behavioral of Main is

    signal my_filters: all_filters;
    signal result: all_converted;
    signal counter: integer := 0;


begin
    -- this part is for setting the filters
    G0: for n in 0 to 9 generate
        G1: for i in 0 to 2 generate
            G2: for j in 0 to 2 generate
                my_filters(n)(i,j) <= rand_real(0.0, 1.0);
            end generate;
        end generate;
    end generate;


    process(counter)
        variable temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8 : real;
    begin
        Q1: for n in 0 to 9 loop
            Q2: for i in 0 to 125 loop
                temp1 := (my_filters(n)(0,0) * real(image(i,counter))) + (my_filters(n)(0,1) * real(image(i,counter+1)));
                temp2 := (my_filters(n)(0,2) * real(image(i,counter+2)))  + (my_filters(n)(1,0) * real(image(i+1,counter)));
                temp3 := (my_filters(n)(1,1) * real(image(i+1,counter+1)))  + (my_filters(n)(1,2) * real(image(i+1,counter+2)));
                temp4 := (my_filters(n)(2,0) * real(image(i+2,counter))) + (my_filters(n)(2,1) * real(image(i+2,counter+1)));
                temp5 := temp1 + temp2;
                temp6 := temp3 + temp4;
                temp7 := temp5 + temp6;
                temp8 := temp7 + (my_filters(0)(2,2) * real(image(i+2,counter+2)));
                result(n)(i,counter) <= temp8 / 9.0;
            end loop;
        end loop;
    end process;

    process(clk)
    begin
        if (clk'event and clk = '1') then
            if (counter /= 125) then
                counter <= counter + 1;
            end if;
        end if;
    end process;



    output <= result;

end Behavioral;