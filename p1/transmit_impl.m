function [s, a, A, pulse] = transmit_impl(b, M, Ns, alpha, C)

amp = 0;
if C==1
    amp = 5;
elseif C==2
    amp = 15;
end

k = uint8(log2(M));
A = (1-M:2:M-1);         % Specify constellation here (vector)
A = amp * A ./ max(A);
% Translate k bits into a index into the A vector.
idx = bit2int(b', k) + 1; % Add one because of one-based indexing.
a = A(idx);           % Convert the bits in vector b to symbols in vector a


% 2. Pulse Amplitude Modulation
pulse = rcosdesign(alpha, 1, Ns-1); % Specify the transmit pulse here (vector)
P = (pulse' * a);
s = P(:)'; % Perform PAM. The resulting transmit signal is the vector s.

end