function [] = optim()

alphas = [0.05];
Nss = 3:2:7;
P_bs = zeros([length(alphas) length(Nss)]);

for M=[2 4]
    for C=[1 2]
        for i=1:length(alphas)
            for j=1:length(Nss)
                alpha = alphas(i);
                Ns = Nss(j);
                b = randn([1, 1000000*log2(M)]);
                b(b > 0.5) = 1;
                b(b <= 0.5) = 0;
                [s, ~, A, pulse] = transmit_impl(b, M, Ns, alpha, C);
                r = simchannel(s, 1, C);
                [b_hat, ~, ~] = receive_impl(r, M, A, Ns, pulse);
                BER = sum(b ~= b_hat)/length(b);
                P_bs(i, j) = BER;
            end
        end
        hold off;
        plot(Nss, P_bs(1,:));
        [P_bmin, I] = min(abs(P_bs(:)));
        [i,j] = ind2sub(size(P_bs), I);
        fprintf("M=%f, C=%f, alpha=%f, Ns=%f, P_bs=%f \n", M, C, alphas(i), Nss(j), P_bmin);
        display(P_bs);
    end 
end

end