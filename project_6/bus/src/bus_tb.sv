module bus_tb;
  // Instantiate a 16-bit bus
  Bus #(16) myBus (
    .busInput(dataFromSource),
    .busOutput(dataToDestination)
  );

  // Additional logic for MyModule
  // ...
endmodule
