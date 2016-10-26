clear all;
N=50;
pobs=0.55;
A = randomGraph(N,pobs);

% estimate beta such that 
S=[];
invbetas=logspace(-3,4,1000);
for invbeta=invbetas
    beta=1.0/invbeta;
    S = [S, quantum_entropy(A,beta)/log2(N)];
end
semilogx(invbetas,S,'o-');
betastar = 1.0/min(invbetas(find(S>0.01))); % see dedomenico, page 7, first paragraph

rho=quantum_density(A,betastar);

RES.plink=[];
RES.rep=[];
RES.kl = [];
for plink=linspace(0.01,0.99,100)
   for repetition=1:200
        kl = quantum_kl(rho,quantum_density(randomGraph(N,plink),betastar));
        RES.plink = [RES.plink; plink];
        RES.rep = [RES.rep; repetition];
        RES.kl = [RES.kl; real(kl)];
   end
end


T=struct2table(RES);
Tm=varfun(@mean,T,'InputVariables',{'kl'},'GroupingVariables',{'plink'})
plot(Tm.plink,Tm.mean_kl,'-o')

% Return the corresponding estimated plink
plinkstar = Tm.plink(find(min(Tm.mean_kl)==Tm.mean_kl));

% The network loglikelihood is
sigmastar = quantum_density(randomGraph(N,plinkstar),betastar);
trace(rho*logm(sigmastar))