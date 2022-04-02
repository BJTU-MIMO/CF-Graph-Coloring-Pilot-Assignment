clc;
clear all;
%% parameters
%Uplink number of terminals
M=100;                                  %number of access points
K=40;                                   % number of user equipments
tau_p=10;                               % number of pilots
tau_c=200;
B=20;                                   %Mhz
D=1;                                    %length of square area
%Consider a rectangular area with DxD km^2
%M distributed APs serves K terminals, they all randomly located in the area

prelogFactor =B*(1-tau_p/tau_c)*(1/2);
radius=0.35;

[U,S,V]=svd(randn(tau_p,tau_p)+randn(tau_p,tau_p)*1i); %U includes tau_p orthogonal sequences

power_f=0.1;                                           %downlink power: 200 mW
noise_p = 10^((-203.975+10*log10(20*10^6)+9)/10);      %noise power
Pu = power_f/noise_p;                                  %nomalized receive SNR
Pp=Pu;                                                 %pilot power

N=100;             %number of set up
realization=1000;  %number of realization
%%%%%%%%%%%% fractional
R_MR_gra_frac = zeros(N,K); %user interference
R_MR_ran_frac = zeros(N,K); %user interference
%%%%%%%%%%%% max min
R_MR_gra = zeros(N,K); %user interference
R_MR_ran = zeros(N,K); %user interference

n=1;
while n < N+1
    %% channel set up
    %Display simulation progress
    disp(['Setup ' num2str(n) ' out of ' num2str(N)]);
    
    %Generate channel matrix
    [BETAA,dist_user,UEpositions]=functionChannelScene(D,M,K);
    Pu_set=Pu * 1./(sum(BETAA));
    
    prelogFactor =B*(1-tau_p/tau_c)*(1/2);
    
    %% graph coloring based pilot assignment
    tic
    [CC,num,flag_break]=functiongraph(K,M,BETAA,tau_p);
    
    if flag_break==1
        continue;
    end
    
    Phii_cf_gra=zeros(tau_p,K);
    for i=1:K
        Phii_cf_gra(:,i) =U(:,CC(i));
    end
    Phii_cf=Phii_cf_gra;
    
    [R_cf_0,Gammaa]=functionCalSINR(Phii_cf,M,K,BETAA,tau_p,Pp,Pu);
    R_cf_min_gra=min(R_cf_0);
    toc
    R_MR_gra(n,:)=funccvx_opti(R_cf_min_gra,K,BETAA,Pu,Gammaa,Phii_cf);
    R_MR_gra(n,:)=prelogFactor*R_MR_gra(n,:);
    
    [R_cf_0,Gammaa]=frac_functionCalSINR(Phii_cf,M,K,BETAA,tau_p,Pp,Pu_set);
    R_MR_gra_frac(n,:) = R_cf_0;
    R_MR_gra_frac(n,:)=prelogFactor*R_MR_gra_frac(n,:);
    
    
    %% random pilot assignment
    
    Phii=zeros(tau_p,K);
    for k=1:K
        Point=randi([1,tau_p]);    %random
        Phii(:,k)=U(:,Point);
    end
    Phii_cf = Phii;
    
    [R_cf_ran_1,Gammaa]=functionCalSINR(Phii_cf,M,K,BETAA,tau_p,Pp,Pu);
    R_cf_min_ran=min(R_cf_ran_1);
    R_MR_ran(n,:)=funccvx_opti(R_cf_min_ran,K,BETAA,Pu,Gammaa,Phii_cf);
    R_MR_ran(n,:)=prelogFactor*R_MR_ran(n,:);
    [R_cf_0,Gammaa]=frac_functionCalSINR(Phii_cf,M,K,BETAA,tau_p,Pp,Pu_set);
    R_MR_ran_frac(n,:) = prelogFactor * R_cf_0;
    
    
    %%
    n=n+1;
end

%% plot figure CDF
Y1=linspace(0,1,N*K);
SE_CF_MR_ran=reshape(R_MR_ran,N*K,1);
SE_CF_MR_graph =reshape(R_MR_gra,N*K,1);

SE_CF_MR_ran_frac=reshape(R_MR_ran_frac,N*K,1);
SE_CF_MR_graph_frac =reshape(R_MR_gra_frac,N*K,1);

MR_ran = sort(SE_CF_MR_ran);
MR_graph= sort(SE_CF_MR_graph);

MR_ran_frac = sort(SE_CF_MR_ran_frac);
MR_graph_frac= sort(SE_CF_MR_graph_frac);

%% max min power control
figure

line1=plot(MR_ran,Y1(:),'k--','LineWidth',2.5);
hold on
line2=plot(MR_graph,Y1(:),'r-','LineWidth',1.5);

line=[line1,line2];
xlabel('Per-User Uplink SE (bits/s/Hz)')
ylabel('Cumulative Distribution')
legend(line,{'Random [1]','Graph'},'location','northwest');
grid on

%% fractional power control
figure
line3=plot(MR_ran_frac,Y1(:),'k-','LineWidth',3.5);
hold on
line4=plot(MR_graph_frac,Y1(:),'r-','LineWidth',2.5);
line=[line3,line4];
xlabel('Per-User Uplink SE (bits/s/Hz)')
ylabel('Cumulative Distribution')
legend(line,{'Random [1]','Graph'},'location','northwest');
grid on
