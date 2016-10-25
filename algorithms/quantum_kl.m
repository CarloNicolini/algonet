function kl = quantum_kl(rho1,rho2)
% Returns the Jensen-Shannon similarity between density matrices of two graphs
% mixing matrix
% kl = trace(rho1*(logm(rho1)-logm(rho2))); % SLOW METHOD
% Faster method is based on eigenvalue decomposition
lambda_rho1 = eig(rho1);
lambda_rho2 = eig(rho2);
kl = sum(lambda_rho1.*log(lambda_rho1./lambda_rho2));



