function [reg, bar_reg] = DPSDA_PS(col, Num_Nodes, iter, D_feature, D_label,...
    f_obj, A, sigma, lb, ub)
%DPSDA_PS: running DPSDA-PS algorithm

d = col/Num_Nodes;
%% algorithm initialization
rng(1,'twister');
x_dec = rand(col, 1);
z = zeros(col, Num_Nodes);
h = zeros(col, Num_Nodes);
w = ones(1, Num_Nodes);
y = zeros(col, Num_Nodes);

f_val = 0;
f_val = f_val + 0.5 * (D_feature(1,:)*x_dec-D_label(1))^2;

x_aux   = x_dec;
x_tilde = x_aux;

bar_f_val = 0;
bar_f_val = bar_f_val + 0.5 * (D_feature(1,:)*x_tilde-D_label(1))^2;

step = zeros(1, iter); % step-size
for t = 1:iter
   step(t) = 1/((t)^0.5); 
end

noise = zeros(d,1); % gradient perturbation
if sigma ~= 0
   noise =  0.01*randn(d,1);
end

%% algorithm update
for t = 2:iter
    A_t = A(:,:,t-1);
    
    % auxiliary variable update
    w = w * A_t';
    
    % dual variable update
    for i = 1:Num_Nodes
        h(:,i) = z(:,i) + rand_laplace(col, 1, sigma);  
    end  
    z = h * A_t';
    for i = 1:Num_Nodes
        subg = ( D_feature(t,:)*y(:,i) - D_label(t) ) * D_feature(t,:)';
        for k = 1:Num_Nodes
            z((k-1)*d+1:k*d,i) = z((k-1)*d+1:k*d,i) + Num_Nodes *...
                Kronecker_Delta(i,k) * ( subg((i-1)*d+1:i*d) + noise );            
        end            
    end
    
    % primal variable update
    for i = 1:Num_Nodes
        y(:,i) = max(lb,min(-z(:,i)/w(i)*step(t-1), ub));
    end
    
    for i = 1:Num_Nodes
        x_dec((i-1)*d+1:i*d) = y((i-1)*d+1:i*d,i);
    end 
    
    f_val = f_val + 0.5 * ( D_feature(t,:) * x_dec - D_label(t) )^2;
    
    x_aux   = x_aux + x_dec;
    x_tilde = 1/t * x_aux;
    bar_f_val = bar_f_val + 0.5 * (D_feature(t,:)*x_tilde-D_label(t))^2;    
    
end

% compute the regrets
reg_vec = f_val - f_obj;
reg = reg_vec/iter;

bar_reg_vec = bar_f_val - f_obj;
bar_reg = bar_reg_vec/iter;


end

