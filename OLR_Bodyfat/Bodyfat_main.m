clear;
clc;

T_Horizon = 500;                                 % time horizon
Num_Nodes = 7;                                   % number of nodes
sigma = [0, 1, 2, 5];                            % different noise
Alg_Index = [1, 2];                              % choose algorithm (1:DPSDA-C; 2:DPSDA-PS)

%% Load data
[LabelVector, InstanceMatrix] = libsvmread('bodyfat_scale.txt');
[numSample, col] = size(InstanceMatrix);
[f_opt, feature_Rand, label_Rand] = data_process(T_Horizon, LabelVector, InstanceMatrix,numSample, col);

%% return the regret of DPSDA-C
% [C_Reg_e1, C_barReg_e1, all_C_Reg_e1, all_C_barReg_e1]...
%     = Bodyfat_call(Num_Nodes, T_Horizon, sigma(1), Alg_Index(1),...
%     f_opt, feature_Rand, label_Rand, col); % non-private
% save('result_C1.mat', 'C_Reg_e1', 'C_barReg_e1', 'all_C_Reg_e1', 'all_C_barReg_e1');
% 
% [C_Reg_e2, C_barReg_e2, all_C_Reg_e2, all_C_barReg_e2]...
%     = Bodyfat_call(Num_Nodes, T_Horizon, sigma(2), Alg_Index(1),...
%     f_opt, feature_Rand, label_Rand, col); % epsilon = 1
% save('result_C2.mat', 'C_Reg_e2', 'C_barReg_e2', 'all_C_Reg_e2', 'all_C_barReg_e2');
% 
% [C_Reg_e3, C_barReg_e3, all_C_Reg_e3, all_C_barReg_e3]...
%     = Bodyfat_call(Num_Nodes, T_Horizon, sigma(3), Alg_Index(1),...
%     f_opt, feature_Rand, label_Rand, col); % epsilon = 0.5
% save('result_C3.mat', 'C_Reg_e3', 'C_barReg_e3', 'all_C_Reg_e3', 'all_C_barReg_e3');
% 
% [C_Reg_e4, C_barReg_e4, all_C_Reg_e4, all_C_barReg_e4]...
%     = Bodyfat_call(Num_Nodes, T_Horizon, sigma(4), Alg_Index(1),...
%     f_opt, feature_Rand, label_Rand, col); % epsilon = 0.2
% save('result_C4.mat', 'C_Reg_e4', 'C_barReg_e4', 'all_C_Reg_e4', 'all_C_barReg_e4');

load result_C1.mat
load result_C2.mat
load result_C3.mat
load result_C4.mat

%% return the regret of DPSDA-PS
% [PS_Reg_e1, PS_barReg_e1, all_PS_Reg_e1, all_PS_barReg_e1]...
%     = Bodyfat_call(Num_Nodes, T_Horizon, sigma(1), Alg_Index(2),...
%     f_opt, feature_Rand, label_Rand, col); % non-private
% save('result_PS1.mat', 'PS_Reg_e1', 'PS_barReg_e1', 'all_PS_Reg_e1', 'all_PS_barReg_e1');
% 
% [PS_Reg_e2, PS_barReg_e2, all_PS_Reg_e2, all_PS_barReg_e2]...
%     = Bodyfat_call(Num_Nodes, T_Horizon, sigma(2), Alg_Index(2),...
%     f_opt, feature_Rand, label_Rand, col); % epsilon = 1
% save('result_PS2.mat', 'PS_Reg_e2', 'PS_barReg_e2', 'all_PS_Reg_e2', 'all_PS_barReg_e2');
% 
% [PS_Reg_e3, PS_barReg_e3, all_PS_Reg_e3, all_PS_barReg_e3]...
%     = Bodyfat_call(Num_Nodes, T_Horizon, sigma(3), Alg_Index(2),...
%     f_opt, feature_Rand, label_Rand, col); % epsilon = 0.5
% save('result_PS3.mat', 'PS_Reg_e3', 'PS_barReg_e3', 'all_PS_Reg_e3', 'all_PS_barReg_e3');
% 
% [PS_Reg_e4, PS_barReg_e4, all_PS_Reg_e4, all_PS_barReg_e4]...
%     = Bodyfat_call(Num_Nodes, T_Horizon, sigma(4), Alg_Index(2),...
%     f_opt, feature_Rand, label_Rand, col); % epsilon = 0.2
% save('result_PS4.mat', 'PS_Reg_e4', 'PS_barReg_e4', 'all_PS_Reg_e4', 'all_PS_barReg_e4');

load result_PS1.mat
load result_PS2.mat
load result_PS3.mat
load result_PS4.mat

%% graph part
marker = T_Horizon/5:T_Horizon/5:T_Horizon;
Iter = 1:T_Horizon;
font_size = 16;

figure(1) % plot the regret (3) of DPSDA-C
hC1 = semilogy(Iter, C_Reg_e1,'k-s','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hC2 = semilogy(Iter, C_Reg_e2,'g->','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hC3 = semilogy(Iter, C_Reg_e3,'r-o','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hC4 = semilogy(Iter, C_Reg_e4,'b-d','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on

title('DPSDA-C', 'FontSize', font_size)
legend([hC1, hC2, hC3, hC4], 'Non-private', '$\epsilon=1$',...
    '$\epsilon=0.5$', '$\epsilon=0.2$', 'FontSize', font_size, 'Interpreter','latex');
grid on;
xlabel('Time horizon $T$', 'FontSize', font_size, 'Interpreter', 'latex');
ylabel('$\bar{\mathcal{R}}\left( \mathbf{x}\left( t \right) ,T \right) /T$',...
    'FontSize', font_size, 'Interpreter', 'latex');
set(gca, 'FontSize', font_size);

figure(2) % plot the regret (19) of DPSDA-C
hCbar1 = semilogy(Iter, C_barReg_e1,'k-s','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hCbar2 = semilogy(Iter, C_barReg_e2,'g->','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hCbar3 = semilogy(Iter, C_barReg_e3,'r-o','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hCbar4 = semilogy(Iter, C_barReg_e4,'b-d','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on

title('DPSDA-C', 'FontSize', font_size)
legend([hCbar1, hCbar2, hCbar3, hCbar4], 'Non-private', '$\epsilon=1$',...
    '$\epsilon=0.5$', '$\epsilon=0.2$', 'FontSize', font_size, 'Interpreter','latex');
grid on;
xlabel('Time horizon $T$', 'FontSize', font_size, 'Interpreter', 'latex');
ylabel('$\bar{\mathcal{R}}\left( \mathbf{\tilde{x}}\left( t \right) ,T \right) /T$',...
    'FontSize', font_size, 'Interpreter', 'latex');
set(gca, 'FontSize', font_size);

figure(3) % plot the regret (3) of DPSDA-PS
hPS1 = semilogy(Iter, PS_Reg_e1,'k-s','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hPS2 = semilogy(Iter, PS_Reg_e2,'g->','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hPS3 = semilogy(Iter, PS_Reg_e3,'r-o','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hPS4 = semilogy(Iter, PS_Reg_e4,'b-d','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on

title('DPSDA-PS', 'FontSize', font_size)
legend([hPS1, hPS2, hPS3, hPS4], 'Non-private', '$\epsilon=1$',...
    '$\epsilon=0.5$', '$\epsilon=0.2$', 'FontSize', font_size, 'Interpreter','latex');
grid on;
xlabel('Time horizon $T$', 'FontSize', font_size, 'Interpreter', 'latex');
ylabel('$\bar{\mathcal{R}}\left( \mathbf{x}\left( t \right) ,T \right) /T$',...
    'FontSize', font_size, 'Interpreter', 'latex');
set(gca, 'FontSize', font_size);

figure(4) % plot the regret (19) of DPSDA-PS
hPSbar1 = semilogy(Iter, PS_barReg_e1,'k-s','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hPSbar2 = semilogy(Iter, PS_barReg_e2,'g->','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hPSbar3 = semilogy(Iter, PS_barReg_e3,'r-o','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on
hPSbar4 = semilogy(Iter, PS_barReg_e4,'b-d','LineWidth', 1.2, 'MarkerIndices', marker, 'MarkerSize', 6);
hold on

title('DPSDA-PS', 'FontSize', font_size)
legend([hPSbar1, hPSbar2, hPSbar3, hPSbar4], 'Non-private', '$\epsilon=1$',...
    '$\epsilon=0.5$', '$\epsilon=0.2$', 'FontSize', font_size, 'Interpreter','latex');
grid on;
xlabel('Time horizon $T$', 'FontSize', font_size, 'Interpreter', 'latex');
ylabel('$\bar{\mathcal{R}}\left( \mathbf{\tilde{x}}\left( t \right) ,T \right) /T$',...
    'FontSize', font_size, 'Interpreter', 'latex');
set(gca, 'FontSize', font_size);

