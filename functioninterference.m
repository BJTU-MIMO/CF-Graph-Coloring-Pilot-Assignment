function d=functioninterference(I,K)
for j=1:K
    for jj=1:K
        if j~=jj
            if norm(intersect(I(j,:),I(jj,:)))~=0   %whether they have the same AP
                d(j,jj)=1; 
            else
                d(j,jj)=0;
            end
        end
    end
end
end
