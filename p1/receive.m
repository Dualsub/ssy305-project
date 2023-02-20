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


load filter.mat pulse Ns
load parameters.mat M A

[b_hat, y, y_sampled] = receive_impl(r, M, A, Ns, pulse);

%********** DON'T EDIT FROM HERE ON
% plot Rx signals
PlotSignals(plot_flag, 'Rx', r, y, y_sampled)
%********** End program