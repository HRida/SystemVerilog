// Testbench
module MyFerrari_tb;
  // Instantiate the car object
  MyFerrari myCar = new("Red", 200);

  initial begin
    // Display initial information about the car
    myCar.displayInfo(); // add code here

    // Accelerate the car
    myCar.accelerate(50); // add code here

    // Brake the car
    myCar.brake(20); // add code here

    // Display final information about the car
    myCar.displayInfo(); // add code here

    // End simulation
    $finish;
  end
endmodule

