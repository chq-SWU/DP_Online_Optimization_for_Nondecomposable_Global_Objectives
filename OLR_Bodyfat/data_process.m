function [f_opt, feature_Rand, label_Rand] = data_process(T_Horizon, LabelVector, InstanceMatrix,numSample, col)
%% optimal value 
f_opt = zeros(T_Horizon, 1);
pro1  = zeros(col,col);
pro2  = zeros(col, 1);
pro3  = 0;
feature_Rand = zeros(T_Horizon, col);
label_Rand   = zeros(T_Horizon, 1);
for t = 1:T_Horizon
    t_fake = randi([1 numSample], 1);
    pro1 = pro1 + InstanceMatrix(t_fake,:)' * InstanceMatrix(t_fake,:);
    pro2 = pro2 + LabelVector(t_fake) * InstanceMatrix(t_fake,:)';
    pro3 = pro3 + LabelVector(t_fake)^2;
    feature_Rand(t,:) = InstanceMatrix(t_fake,:);
    label_Rand(t)     = LabelVector(t_fake);

    x_opt = pinv(pro1) * pro2;
    f_opt(t) = (1/2) * x_opt' * pro1 * x_opt - pro2' * x_opt + (1/2) * pro3;
end

end

