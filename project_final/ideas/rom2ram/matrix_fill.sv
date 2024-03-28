// 1st idea
// for (int i=0; i < ADDR_WIDTH-1; i=i+1)
//   for (int j=0; j < ADDR_WIDTH-1; j=j+1)
//     matrix_data[i][j] <= "data";

// 2nd idea
// foreach (matrix_data[i][j])
//   matrix_data[i][j] <= element_data;

// 3rd idea
// matrix_data[i][(ADDR_WIDTH-1) - i] <= element_data;

// 4th idea
// for (int i=0; i < ADDR_WIDTH-1; i=i+1)
//   matrix_data[i][0] <= "data";
//   matrix_data[i][1] <= "data";
//   matrix_data[i][2] <= "data";
//   matrix_data[i][3] <= "data";

// 5th idea
// for (int i=0, j=ADDR_WIDTH-1; i < ADDR_WIDTH-1 && j >= 0; i=i+1, j=j-1)
//   matrix_data[i][j] <= "data";
//   matrix_data[i][j] <= "data";
//   matrix_data[i][j] <= "data";
//   matrix_data[i][j] <= "data";
