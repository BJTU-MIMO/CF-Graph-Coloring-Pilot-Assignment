function [pppp,pp]=functionAPSelection(PBeta,K,N,theta)

PBeta=sort(PBeta,2,'descend');
pp=(sum(PBeta,2))';


pppp=zeros(1,K);
for j=1:K
    ppp=0;
    for i=1:N
        ppp=ppp+PBeta(j,i);
        if ppp>=theta(j)*pp(j)
            pppp(j)=PBeta(j,i);
            break
        end
    end
end