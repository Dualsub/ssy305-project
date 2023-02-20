function [b_hat, y, y_sampled] = receive_impl(r, M, A, Ns, pulse)

%1. filter with Rx filter (Matched filter)
MF = conj(fliplr(pulse)); % Specify Rx filter here (vector)
y = filter(MF,1,r);       % Here the received signal r is passed through the matched filter to obtain y 
% hold off;
% stem(r)
% stem(y)
%2. Sample filter output
y_sampled = y(Ns:Ns:length(y)); % Compute the sampled signal y_sampled
%3. Make decision on which symbol was transmitted
% Split into rows of Ns-elements

num_sym = length(y_sampled);
% a_hat = mean(y_mat, 2); % Compute the received symbols (in vector a_hat) from  
                        % the sampled signal, based on your decision

%4. Convert symbols to bits
k = log2(M);
bits_per_sym = k;
b_hat = zeros(num_sym, bits_per_sym); % Convert the symbols in vector a_hat to bits in vector b_hat
for i=1:num_sym
    [~,closestIndex] = min(abs(A-y_sampled(i)));
    bits = int2bit(closestIndex-1, bits_per_sym);
    b_hat(i,:) = bits;
end

b_hat = b_hat';
b_hat = b_hat(:)';

end