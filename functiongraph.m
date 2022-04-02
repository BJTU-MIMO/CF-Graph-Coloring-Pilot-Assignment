function [CC,num,flag_break]=functiongraph(K,N,BETAA,S)

theta=0.94*ones(1,K);   
beta=BETAA';
for i=1:K
        PBeta(i,:)=beta(i,:);
end
[pppp,~]=functionAPSelection(PBeta,K,N,theta);
[kk,CC,~,~,~]=funcnumofcolor(PBeta,K,N,S,pppp);   %initial number of color(pilot)
G=theta;
num=0;
gmin=0.2;
gmax=0.999;

flag_break=0;
flag=1;
num_1=1;
while flag    %bisection
    if kk>S
        gg=gmin;
        gmax=G(1);
    end
    if kk<S
        gg=gmax;
        gmin=G(1);
    end
    if kk==S
        gg=gmax;
        gmin=G(1);
        if (gmax-gmin)<0.0001 
            break;
        end
    end

    G=(gg+G(1))/2*ones(1,K);
    num=num+1;
    [pppp,~]=functionAPSelection(PBeta,K,N,G);
    [kk,CC,d,I,b]=funcnumofcolor(PBeta,K,N,S,pppp);

    time=toc;
    if time>50
        flag_break=1;
        break;
    else
        flag_break=0;
    end

num_1=num_1+1;

end
end

