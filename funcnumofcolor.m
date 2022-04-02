function [k,C,d,I,b]=funcnumofcolor(PBeta,K,N,S,pppp)
I=zeros(K,N);
b=zeros(K,N);

for j=1:K
    ii=1;
    for i=1:N
         if PBeta(j,i)>=pppp(j)  
             b(j,i)=1; 
             I(j,ii)=i;
             ii=ii+1;
         end
    end
end

%% calculate number of color
d=functioninterference(I,K);

G=d;
n=size(G,1);           %number of nodes
k=1;
C=zeros(1,n);         
Z=1:n;                 
while sum(find(C==0))  %if the nodes are assigned with color
    tcol=find(C==0);         %not assigned nodes
    m=sum(G(tcol,:),2);      %calculate weight
    minm=max(m);             %find the min weight
    k1=min(find(m==minm));   % find the min weight node
    c=G(tcol(k1),:);         
    c(1,tcol(k1))=1;
    C(tcol(k1))=k;
    Sn= find(c~=0);
    flag=1;
    time=1;
    while flag
        tc=setdiff(Z,Sn);
        if isempty(tc)  || time>round(K/S)
            flag=0;
            k=k+1;
        else
            c=G(tc(1),:);
            c(1,tc(1))=1;

            C(tc(1))=k;
            time=time+1;
            Sn1= find(c~=0);
            Sn=union(Sn,Sn1);
        end
    end
    trow=find(C==k-1);
    G(:,trow)=1;
end
k=k-1;
end