clear all;

ci=[1 1 1 1 1 2 2 2];
T=10;
N=length(ci);
Y=nan(T,N);

for c=unique(ci(:))'
   Y(:,ci==c) = repmat(randn(T,1),[1,sum(ci==c)]);
end


