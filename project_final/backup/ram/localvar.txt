
signal output_r: std_logic;

process(clk,reset)

begin
  if reset = '1' then
  output_r <= '0';
  elsif clk'event and clk = '1' then
    if bla = '1' then
    output_r <= '0';
    else
    output_r <= '1';
end if;
end if;
end process;
ouitput <= output_r;