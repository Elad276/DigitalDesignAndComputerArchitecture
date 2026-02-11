module ALU_32b #(parameter N = 32)
            (input  logic [N-1:0] a, b,
            input  logic [1:0] ctrl,
            output logic [N-1:0] result,
            output logic negative, zero, carry, overflow
);

    logic [N-1:0] b_inv;
    logic [N-1:0] b_final;
    logic [N-1:0] sum;
    logic c_out; 

    assign b_inv   = ~b;
    
    assign b_final = ctrl[0] ? b_inv : b;

    // if ctrl[0] is 1, we want to perform subtraction, which is a + (~b) + 1
    // if ctrl[0] is 0, we want to perform addition, which is a + b + 0
    assign {c_out, sum}     = a + b_final + ctrl[0];

    always_comb begin
        case (ctrl)
            2'b00: result = sum;
            2'b01: result = sum;
            2'b10: result = a & b; 
            2'b11: result = a | b; 
            default: result = {N{1'bx}}; 
        endcase
    end

    assign negative = result[N-1];
    assign zero = ~|result;
    assign carry = ~ctrl[1] & c_out;
    assign overflow = (a[N-1] ~^ b[N-1] ~^ ctrl[0]) & (sum[N-1] ^ a[N-1]) & ~ctrl[1];
    
endmodule