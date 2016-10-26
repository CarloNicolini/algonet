clear all;
N=200;
nedges=1000;
A = randomGraph(N,[],nedges);
TOLBETA=1E-16;
% estimate beta such that it's the smallest such that S>0
S=[];
invbetas=logspace(-5,5,100);
for invbeta=invbetas
    beta=1.0/invbeta;
    S = [S, quantum_entropy(A,beta)/log2(N)];
end
% Find the betastar
betastar = 1.0/max(invbetas(find(diff(S)>TOLBETA)));
%betastar=1;

% Do some plotting
subplot(2,2,1);
hold on;
semilogx(invbetas,S,'.-','MarkerFace','k'); title('$S(\beta)$','Interpreter','LaTex'); xlabel('1/beta'); ylabel('$S/\log2(N)$','Interpreter','LaTex');
subplot(2,2,2);
hold off;
hold on;
plot(invbetas(1:end-1),diff(S)); title('$\Delta S(\beta)$','Interpreter','LaTex'); xlabel('$1/\beta$','Interpreter','LaTex'); ylabel('$\Delta S/\log2(N)$','Interpreter','LaTex');
hold off;

rho=quantum_density(A,betastar);

RES.edges=[];
RES.rep=[];
RES.kl = [];
for edges=1:(N*(N-1)/2)
   for repetition=1:20
        kl = quantum_kl(rho,quantum_density(randomGraph(N,[],edges),betastar));
        RES.edges = [RES.edges; edges];
        RES.rep = [RES.rep; repetition];
        if ~isinf(kl) && ~isnan(kl)
            RES.kl = [RES.kl; real(kl)];
        end
   end
end


T=struct2table(RES);
Tm=varfun(@mean,T,'InputVariables',{'kl'},'GroupingVariables',{'edges'});
subplot(2,2,3);
hold on;
plot(Tm.edges,Tm.mean_kl,'.','MarkerFace','k'); grid on; xlabel('num edges','Interpreter','LaTex'); ylabel('KL Div','Interpreter','LaTex');
line([nedges,nedges],[0 3]);
hold off;
% Return the corresponding estimated plink
edgestar = Tm.edges(min(Tm.mean_kl(~isinf(Tm.mean_kl)))==Tm.mean_kl);

% The network loglikelihood is
sigmastar = quantum_density(randomGraph(N,edgestar),betastar);
trace(rho*logm(sigmastar))

[nedges, edgestar]