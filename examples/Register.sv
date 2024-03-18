class Register;
  string name;
  rand bit [3:0] rank;
  rand bit [3:0] pages;

  function new(string name);
    this.name = name;
  endfunction

  function void print();
    $display("name=%s rank=%0d pages=%0d", name, rank, pages);
  endfunction
endclass

module tb;
  Register rt[4];
  string name_arr[4] = '{"alexa", "siri", "google home", "cortana"};
  
  initial begin
    $display("-------------- Initial Values ---------------");
    foreach (rt[i]) begin
      rt = new(name_arr[i]);
      rt[i].randomize();
      rt[i].print();
    end

    $display("-------------- Sort by name ---------------");
    rt.sort(x) with (x.name);
    foreach (rt[i]) rt[i].print();

    $display("--------------Sort by rank, pages ---------------");
    rt.sort(x) with ({x.rank, x.pages});
    foreach (rt[i]) rt[i].print();
  end
endmodule
