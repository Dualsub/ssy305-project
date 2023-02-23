function [s, a, A, pulse] = transmit_impl(b, M, Ns, alpha, C, P_e)

% We calcuclate the conm c.
sigma2 = 15;
c = sqrt(sigma2) * qfuncinv(P_e * M/(2*(M-1)));
display(c);
k = uint8(log2(M));
A = (1-M:2:M-1);         % Specify constellation here (vector)
A = c * A;
% Translate k bits into a index into the A vector.
idx = bit2int(b', k) + 1; % Add one because of one-based indexing.
a = A(idx);           % Convert the bits in vector b to symbols in vector a


% 2. Pulse Amplitude Modulation
pulse = rcosdesign(alpha, 1, Ns-1, 'sqrt'); % Specify the transmit pulse here (vector)
P = (pulse' * a);
s = P(:)'; % Perform PAM. The resulting transmit signal is the vector s.

end