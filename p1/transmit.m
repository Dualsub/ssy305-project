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
M = 4;
k = uint8(log2(M));
A = (1-M:2:M-1);         % Specify constellation here (vector)
% Translate k bits into a index into the A vector.
idx = bit2int(b', k) + 1; % Add one because of one-based indexing.
a = A(idx);           % Convert the bits in vector b to symbols in vector a
save parameters.mat M A

% 2. Pulse Amplitude Modulation
alpha = 0.8;
Ns = 8; % Specify the length of the transmit pulse here (scalar)
pulse = rcosdesign(alpha, M, Ns / M); % Specify the transmit pulse here (vector)
P = (pulse' * a);
s = P(:)'; % Perform PAM. The resulting transmit signal is the vector s.

save filter.mat pulse Ns
%********** DON'T EDIT FROM HERE ON
% plot Tx signals
PlotSignals(plot_flag, 'Tx', a, s)
%********** End program