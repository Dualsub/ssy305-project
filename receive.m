function [b_hat] = receive(r,plot_flag)
% [b_hat] = receive(r,plot_flag)
% Receiver program for part 1 of the project. The program should produce the
% received information bits given the samples of the received signal (sampled 
% at fs Hz.)
%
% Input:
%   r = samples of the received signal
%   plot_flag = flag for plotting [0: don't plot, 1: plot] 
%
% Output:
%   b_hat = vector containing the received information bits
%
% Rev. C (VT 2016)

%********** Begin program EDIT HERE

% Complete the code below:     

% r = r + randn(size(r)) * 0.1^2 % Noise simulation

load filter.mat pulse Ns
load parameters.mat M A

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

display(y_sampled)
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
display(b_hat);

%********** DON'T EDIT FROM HERE ON
% plot Rx signals
PlotSignals(plot_flag, 'Rx', r, y, y_sampled)
%********** End program