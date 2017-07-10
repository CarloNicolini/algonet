function rho = quantum_density(A,beta)
	L = graph_laplacian(A);
	EXPBETAL = expm(-beta.*L);
	rho = EXPBETAL./trace(EXPBETAL);