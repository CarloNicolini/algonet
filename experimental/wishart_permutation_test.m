function wishart_permutation_test(W, ci, df, nperms)
% W is the n x n (weighted) adjacency matrix
% ci is the membership (n nodes with integer labels)
% df is the number of degrees of freedom
% nperms is the number of random permutations

for c=sort(unique(ci))
    nodes_c = find(ci==c);
    W(nodes_c,nodes_c)
end
    

function log_expectation(V)


function cov_entropy(V,df)
detV = prod(eig(V)); % the determinant
p = size(V,1);



function y = trigamma(x)
    y = psi(1,x);
