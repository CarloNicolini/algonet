function S = entropy_dedomenico(A,beta)

rho = quantum_density(A,beta);
% Compute entropy S of density matrix rho in log base two (bits)
% LambdaS = eig(rho);
% Srho = -sum(diag(lambdaS).*log2(lambdaS));

% Compute partition function (eq 4)
Z = sum(exp(-LambdaL.*beta));

% Compute entropy of graph (eq 7)
S = log2(Z) + beta*trace(L*rho);
