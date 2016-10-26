function S_rho = quantum_entropy(A,beta)
rho = quantum_density(A, beta);
lambda_rho = eig(rho);
lambda_rho_log_lambda = lambda_rho.*log2(lambda_rho);
%lambda_rho_log_lambda(isnan(lambda_rho_log_lambda))=0;
S_rho = -sum(real(lambda_rho_log_lambda));

