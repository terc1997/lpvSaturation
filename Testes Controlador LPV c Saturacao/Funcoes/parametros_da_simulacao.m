% parâmetros da simulação
T = 5.2632;
load('larissa_tarsis_LPV_saturacao_perturbacao_degrau_unitario_2.mat')
perturbacao.time = t(1:158);
perturbacao.signals.values = Level1CM(1:158)'/100;
perturbacao.signals.dimensions = 1;