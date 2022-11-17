function [Reg, bar_Reg, all_Reg, all_bar_Reg] = Synthetic_call(Num_Nodes, T_Horizon, sigma, Alg_Index,...
    b_out, pro_a, col, f_opt)
%SYNTHETIC_CALL using to compute regrets of algorithms
% Reg: the pseudo-regret (3)
% bar_Reg: the pseudo-regret (19)
% all_Reg: the pseudo-regret (3) over 10 Monte Carlo tests
% all_bar_Reg: the pseudo-regret (19) over 10 Monte Carlo tests

% bounded constraint set (lb: lower bound; ub: upper bound)
lb = -5;
ub = 5;

%% compute regret
Monte_Carlo_tests = 10;
Reg     = zeros(1, T_Horizon);
bar_Reg = zeros(1, T_Horizon);
all_Reg = zeros(Monte_Carlo_tests, T_Horizon);
all_bar_Reg = zeros(Monte_Carlo_tests, T_Horizon); 

if Alg_Index == 1  % compute the regrets of DPSDA-C  
    for ave = 1:Monte_Carlo_tests

       % generate the network
       A     = Undirected_graph_generator(Num_Nodes, T_Horizon);
       Reg_F     = zeros(1, T_Horizon);
       bar_Reg_F = zeros(1, T_Horizon);
       for t = 1:T_Horizon
          [Reg_F(t), bar_Reg_F(t)] = DPSDA_C(col, Num_Nodes, t, pro_a(:,1:t),...
              b_out(1:t), f_opt(t), A(:,:,1:t), sigma, lb, ub); 
       end
       all_Reg(ave,:) = Reg_F;
       all_bar_Reg(ave,:) = bar_Reg_F;
       Reg = Reg + Reg_F;
       bar_Reg = bar_Reg + bar_Reg_F;
    end
    Reg     = Reg / Monte_Carlo_tests;
    bar_Reg = bar_Reg / Monte_Carlo_tests; 
end

if Alg_Index == 2  % compute the regrets of DPSDA-PS  
    for ave = 1:Monte_Carlo_tests

       % generate the network
       A     = Directed_graph_generator(Num_Nodes, T_Horizon);
       Reg_F     = zeros(1, T_Horizon);
       bar_Reg_F = zeros(1, T_Horizon);
       for t = 1:T_Horizon
          [Reg_F(t), bar_Reg_F(t)] = DPSDA_PS(col, Num_Nodes, t, pro_a(:,1:t),...
              b_out(1:t), f_opt(t), A(:,:,1:t), sigma, lb, ub); 
       end
       all_Reg(ave,:) = Reg_F;
       all_bar_Reg(ave,:) = bar_Reg_F;
       Reg = Reg + Reg_F;
       bar_Reg = bar_Reg + bar_Reg_F;
    end
    Reg     = Reg / Monte_Carlo_tests;
    bar_Reg = bar_Reg / Monte_Carlo_tests; 
end

end

