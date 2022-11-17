function M = Undirected_graph_generator(Num_Nodes, T_Horizon)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates a time-vary (directed) graph.
% 
% M:               row-stochastic time-varying weight matrix
% Num_Nodes:       Number of agents over the graph;
% T_Horizon:       Timer horizon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% generate 4-strongly connected directed time-varying graph %%%%
%%%% generate undirected time-varying graph %%%%
M1=[1,    0,    0,    0,    0,    0,     0;
    0,    1,    0,    0,    0,    0,     0;
    0,    0,   1/5,  1/5,  1/5,  1/5,   1/5;
    0     0,   1/3,  1/3,   0,   1/3,    0;
    0,    0,   1/4,   0,   1/4,  1/4,   1/4;
    0,    0,   1/4,  1/4,  1/4,  1/4,    0;
    0,    0,   1/3,   0,   1/3,   0,    1/3];

M2=[1/2, 1/2,    0,    0,    0,    0,     0;
    1/3, 1/3,   1/3,   0,    0,    0,     0;
    0,   1/2,   1/2,   0,    0,    0,     0;
    0     0,     0,    1,    0,    0,     0;
    0,    0,     0,    0,    1,    0,     0;
    0,    0,     0,    0,    0,    1,     0;
    0,    0,     0,    0,    0,    0,     1];

M3=[1/2,   0,    1/2,    0,    0,    0,     0;
     0,   1/2,   1/2,    0,    0,    0,     0;
    1/3,  1/3,   1/3,    0,    0,    0,     0;
     0     0,     0,    1/4,  1/4,  1/4,   1/4;
     0,    0,     0,    1/4,  1/4,  1/4,   1/4;
     0,    0,     0,    1/3,  1/3,  1/3,    0;
     0,    0,     0,    1/3,  1/3,   0,    1/3];

M4=[1/2, 1/2,    0,    0,    0,    0,    0;
    1/2, 1/2,    0,    0,    0,    0,    0;
    0,    0,     1,    0,    0,    0,    0;
    0     0,     0,    1,    0,    0,    0;
    0,    0,     0,    0,    1,    0,    0;
    0,    0,     0,    0,    0,    1,    0;
    0,    0,     0,    0,    0,    0,    1];

M = zeros(Num_Nodes,Num_Nodes,T_Horizon);
for t = 1:T_Horizon
   if mod(t,4)==1
       M(:,:,t) = M1;
   else
       if mod(t,4)==2
           M(:,:,t) = M2;
       else
           if mod(t,4)==3
               M(:,:,t) = M3;
           else
               M(:,:,t) = M4;
           end
       end
   end
end
        
fprintf('The network is generated.\n');
