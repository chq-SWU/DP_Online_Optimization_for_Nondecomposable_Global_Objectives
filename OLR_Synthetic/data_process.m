function [f_opt] = data_process(T_Horizon, b_out, pro_a, col)
%% optimal value 
f_opt = zeros(T_Horizon, 1);
pro1  = zeros(col,col);
pro2  = zeros(col, 1);
pro3  = 0;

for t = 1:T_Horizon
    pro1 = pro1 + pro_a(:,t) * pro_a(:,t)';
    pro2 = pro2 + b_out(1,t) * pro_a(:,t);
    pro3 = pro3 + b_out(1,t)^2;

    x_opt = pinv(pro1) * pro2;
    f_opt(t) = (1/2) * x_opt' * pro1 * x_opt - pro2' * x_opt + (1/2) * pro3;
end
end

