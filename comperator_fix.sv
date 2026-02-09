module comparators #(parameter N = 8)
                    (input  logic signed [N-1:0] a, b,
                    output logic eq, neq, lt, lte, gt, gte);

    // we will need to handle the case for overflow/underflow when comparing signed numbers:
    //if both a and b are positive or both are negative, we can compare them directly.

    logic signed [N-1:0] diff;
    logic v; // Overflow flag
    logic n; // Negative flag

    assign diff = a - b;
    assign n = diff[N-1];
    assign v = (a[N-1] != b[N-1]) && (diff[N-1] != a[N-1]);

    assign eq = (a == b);
    assign neq = (a != b);
    assign lt = (n ^ v); // a < b if the result is negative and there is no overflow, or if there is an overflow and the result is positive
    assign lte = (lt | eq);
    assign gt = (!lte);
    assign gte = (!lt);
endmodule