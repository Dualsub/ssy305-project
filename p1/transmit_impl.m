function [s, a, A, pulse] = transmit_impl(b, M, Ns, alpha, C, P_e)

% We choose amplitude based on the channel.
sigma = 0;
if C==1
    sigma = 5;
elseif C==2
    sigma = 15;
end

% We calcuclate the conm c.
c = sigma * qfuncinv(P_e / log2(M) * M/(2*(M-1)));
k = uint8(log2(M));
A = (1-M:2:M-1);         % Specify constellation here (vector)
A = c *A;
% Translate k bits into a index into the A vector.
idx = bit2int(b', k) + 1; % Add one because of one-based indexing.
a = A(idx);           % Convert the bits in vector b to symbols in vector a


% 2. Pulse Amplitude Modulation
pulse = rcosdesign(alpha, 1, Ns-1); % Specify the transmit pulse here (vector)
P = (pulse' * a);
s = P(:)'; % Perform PAM. The resulting transmit signal is the vector s.

end