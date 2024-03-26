// Class Definition
class MyFerrari;
  // Properties
  string color;
  int speed;
  int maxSpeed;

  // Methods
  // Constructor
  function new(string color, int maxSpeed); //complete arguments
	  //complete here
    this.color = color;
    this.maxSpeed = maxSpeed;
    this.speed = 0;
  endfunction

  // Method to display information about the car
  function void displayInfo();
    $display("Color: %s, Speed: %d, Max Speed: %d", color, speed, maxSpeed); //complete this 
  endfunction

  // Method to accelerate the car
  function void accelerate(int increment); //add necessary argument
	  //complete here
     if ((speed + increment) <= maxSpeed) begin
      speed = speed + increment;
    end else begin
      speed = maxSpeed;
    end
  endfunction

  // Method to brake the car
  function void brake(int decrement); //add necessary argument
	  // complete here
    if ((speed - decrement) >= 0) begin
      speed = speed - decrement;
    end else begin
      speed = 0;
    end
  endfunction

endclass

