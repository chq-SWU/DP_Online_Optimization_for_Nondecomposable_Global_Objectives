function A = Directed_graph_generator(Num_Nodes, T_Horizon)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates a time-vary (directed) graph.
% 
% A:               column-stochastic time-varying weight matrix
% Num_Nodes:       Number of agents over the graph;
% T_Horizon:       Timer horizon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% generate 4-strongly connected directed time-varying graph %%%%
A1=[1,    0,    0,    0,    0,    0,     0;
    0,    1,    0,    0,    0,    0,     0;
    0,    0,   1/3,  1/2,  1/3,   0,     0;
    0     0,    0,   1/2,   0,   1/2,    0;
    0,    0,    0,    0,   1/3,   0,    1/2;
    0,    0,   1/3,   0,   1/3,  1/2,    0;
    0,    0,   1/3,   0,    0,    0,    1/2];

A2=[1/2,  0,    0,     0,    0,    0,     0;
    1/2,  1,   1/2,    0,    0,    0,     0;
    0,    0,   1/2,    0,    0,    0,     0;
    0     0,     0,    1,    0,    0,     0;
    0,    0,     0,    0,    1,    0,     0;
    0,    0,     0,    0,    0,    1,     0;
    0,    0,     0,    0,    0,    0,     1];

A3=[1/2,   0,     0,    0,    0,    0,      0;
     0,   1/2,    0,    0,    0,    0,      0;
    1/2,  1/2,    1,    0,    0,    0,      0;
     0     0,     0,    1/3,  0,    1/2,    0;
     0,    0,     0,    1/3,  1/2,  0,     1/2;
     0,    0,     0,    0,    1/2,  1/2,    0;
     0,    0,     0,    1/3,  0,     0,    1/2];

A4=[1,   1/2,    0,    0,    0,    0,    0;
    0,   1/2,    0,    0,    0,    0,    0;
    0,    0,     1,    0,    0,    0,    0;
    0     0,     0,    1,    0,    0,    0;
    0,    0,     0,    0,    1,    0,    0;
    0,    0,     0,    0,    0,    1,    0;
    0,    0,     0,    0,    0,    0,    1];

A = zeros(Num_Nodes,Num_Nodes,T_Horizon);
for t = 1:T_Horizon
   if mod(t,4)==1
       A(:,:,t) = A1;
   else
       if mod(t,4)==2
           A(:,:,t) = A2;
       else
           if mod(t,4)==3
               A(:,:,t) = A3;
           else
               A(:,:,t) = A4;
           end
       end
   end
end
        
fprintf('The network is generated.\n');
