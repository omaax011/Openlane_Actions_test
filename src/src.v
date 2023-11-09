`include "sumador_completo.v"
`include "sumador_medio.v"

module src (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset

);

    wire [3:0] A;
    wire [3:0] B;
    wire [4:0] S;
    wire [3:0] C;
    
   // assign uio_in = 8'b11111111;
    assign uio_out = 8'b11111111;
    assign uio_oe = 8'b11111111;
    
    assign A = ui_in[3:0];
    assign B = ui_in[7:4];
 
    sumadormedio SM(.A(A[0]),
        .B(B[0]),
        .S(S[0]),
        .C(C[0]));
    
    sumadorcompleto  SC1(.A(A[1]),
        .Cin(C[0]),
        .B(B[1]),
        .S(S[1]),
        .Cout(C[1])
    );
  
    sumadorcompleto  SC2(.A(A[2]),
        .Cin(C[1]),
        .B(B[2]),
        .S(S[2]),
        .Cout(C[2])
    );

        
    sumadorcompleto  SC3(.A(A[3]),
        .Cin(C[2]),
        .B(B[3]),
        .S(S[3]),
        .Cout(C[3])
    );

    
    assign S[4] = C[3];

   assign  uo_out [4:0]= S; 
   assign uo_out [7:5] = 3'd0; 
    
endmodule