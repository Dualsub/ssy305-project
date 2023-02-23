load filter.mat

stem(pulse);
saveas(gca, '../../figures/transmitted_pulse.eps', 'epsc');

clf;
stem(conj(fliplr(pulse)));
saveas(gca, '../../figures/filter_pulse.eps', 'epsc');

