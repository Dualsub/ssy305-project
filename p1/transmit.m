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
constellation = [];         % Specify constellation here (vector)
a = [];                     % Convert the bits in vector b to symbols in vector a

%2. Pulse Amplitude Modulation
Ns = [];                    % Specify the length of the transmit pulse here (scalar)
pulse = [];                 % Specify the transmit pulse here (vector)
s = [];                     % Perform PAM. The resulting transmit signal is the vector s.

%********** DON'T EDIT FROM HERE ON
% plot Tx signals
PlotSignals(plot_flag, 'Tx', a, s)
%********** End program