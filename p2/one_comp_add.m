function [sum] = one_comp_add(a, b, n)
    if a + b < 2^n
        sum = a + b;
    else
        sum = a + b - (2^n - 1);
    end
end