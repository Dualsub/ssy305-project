function [] = paramsurf()

alphas = 0.02:0.01:0.2;
Nss = 3:2:15;
P_bs = zeros([length(alphas) length(Nss)]);
M = 4;
C = 2;
for i=1:length(alphas)
    for j=1:length(Nss)
        alpha = alphas(i);
        Ns = Nss(j);
        b = randn([1, 10000*log2(M)]);
        b(b > 0.5) = 1;
        b(b <= 0.5) = 0;
        [s, ~, A, pulse] = transmit_impl(b, M, Ns, alpha, C);
        r = simchannel(s, 1, C);
        [b_hat, ~, ~] = receive_impl(r, M, A, Ns, pulse);
        BER = sum(b ~= b_hat)/length(b);
        P_bs(i, j) = BER;
    end
end
hold on;
surf(alphas, Nss, P_bs');
surf(alphas, Nss, 10^-3*ones([length(Nss) length(alphas)]));
end