function s = transmit(b,plot_flag)
% s = transmit(b,plot_flag)
% Transmitter program for part 1 of the project. The program should produce samples
% of the transmitted signal. The sample rate is fs Hz.
%
% Input:
%   b = vector containing the information bits to be transmitted
%   plot_flag = flag for plotting [0: don't plot, 1: plot]  
%
% Output:
%   s = vector containing samples of the transmitted signal at at rate of fs Hz
%
% Rev. C (VT 2016)

%********** Begin program, EDIT HERE

% Complete the code below to create samples of the transmitted signal.

%1. Convert bits to symbols
Ns = 5;
alpha = 0.05;
M = 4;
C = 2;
P_b = 10^-3;
[s, a, A, pulse] = transmit_impl(b, M, Ns, alpha, C, P_b);

save filter.mat pulse Ns
save parameters.mat M A

%********** DON'T EDIT FROM HERE ON
% plot Tx signals
PlotSignals(plot_flag, 'Tx', a, s)
%********** End program