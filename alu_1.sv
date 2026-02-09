module ALU_32b #(parameter N = 32)
            (input  logic [N-1:0] a, b,
            input  logic [1:0] ctrl,
            output logic [N-1:0] result
);

    logic [N-1:0] b_inv;
    logic [N-1:0] b_final;
    logic [N-1:0] sum;

    assign b_inv   = ~b;
    
    assign b_final = ctrl[0] ? b_inv : b;

    // if ctrl[0] is 1, we want to perform subtraction, which is a + (~b) + 1
    // if ctrl[0] is 0, we want to perform addition, which is a + b + 0
    assign sum     = a + b_final + ctrl[0];

    always_comb begin
        case (ctrl)
            2'b00: result = sum;
            2'b01: result = sum; 
            2'b10: result = a & b; 
            2'b11: result = a | b; 
            default: result = {N{1'bx}}; 
        endcase
    end
    
endmodule