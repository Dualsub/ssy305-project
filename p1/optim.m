function [] = optim()

alphas = [0.05]';
Nss = [51]';
P_bs = zeros([length(alphas) length(Nss)]);
P_e = 10^-3;

for M=[4]
    for C=[1 2]
        for i=1:length(alphas)
            for j=1:length(Nss)
                alpha = alphas(i);
                Ns = Nss(j);
                b = randn([1, 100000*log2(M)]);
                b(b > 0.5) = 1;
                b(b <= 0.5) = 0;
                [s, ~, A, pulse] = transmit_impl(b, M, Ns, alpha, C, P_e);
                r = simchannel(s, 1, C);
                [b_hat, ~, ~] = receive_impl(r, M, A, Ns, pulse);
                BER = sum(abs(b - b_hat))/length(b);
                P_bs(i, j) = BER;
                fprintf("M=%f, C=%f, alpha=%f, Ns=%f, P_b=%f \n", M, C, alphas(i), Nss(j), BER * 10^3);
            end
        end  
    end 
end

end