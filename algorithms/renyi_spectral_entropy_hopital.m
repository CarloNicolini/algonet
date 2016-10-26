function s = renyi_spectral_entropy2(A,beta,q)

% Method to stupidly compute renyi spectal entropy with bisection method
qsup = q+q/10;
qinf = q-q/10;

while  true
    s_sup = 1.0/(1-qsup)*log2(trace(quantum_density(A,beta)^qsup));
    s_inf = 1.0/(1-qinf)*log2(trace(quantum_density(A,beta)^qinf));
    if isinf(s_sup) || isinf(s_inf)
        break;
    end
    s = (s_sup + s_inf)/2;
    qsup = qsup - q/100;
    qinf = qinf + q/100;
	if abs(qsup - qinf) < 1E-3
        break;
    end
end
