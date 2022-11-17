function r = rand_laplace(m,n,b)
mu=0;
x=rand(m,n);
r = mu-b*sign(x-0.5).*log(1-2*abs(x-0.5));
end

