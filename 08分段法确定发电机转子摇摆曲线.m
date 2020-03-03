%本程序是用分段法确定发电机转子摇摆曲线
S0=input('请输入初始功率:S0=');
V0=input('请输入无限大系统母线电压:V0=');
B=input('请输入系统等值电抗矩阵:B=');
Tj=input('请输入惯性时间常数:Tj=');
N=input('请输入时段数:N=');
Ni=input('请输入哪个时段发生故障:Ni=');
dt=input('请输入每段间隔的时间:dt=');
for i = 1:Ni
    C(i,1)=1; C(i,2)=B(1);
end
for i = Ni:N
    C(i,1)=0; C(i,2)=B(2);
end
E(0)=sqrt((V0+imag(S0)*B(1)./V0)^2+(real(S0)*B(1)./V0)^2);
dtj0=atan(real(S0)*B(1)./(V0*(V0+imag(S0)*B1./V0)));
Q(1)=dtj0*180./pi;
K1=360*50*dt^2./Tj;
P2m=E0*V0./B(2);
P3m=E0*V0./B(3);
dtk=pi-asin(real(S0)./P3m);
dtjx=acos((real(S0)*(dtk-dtj0)+P3m*cos(dtk)-P2m*cos(dtj0))./(P3m-P2m));
dtjx=dtjx*180./pi;
for K = 2:N+1
    P(K-1)=E0*V0./C(K-1,2);
    if C(K-1,1) = = 1       %故障发生之前
        Peq(K-1)=P(K-1)*sin(Q(K-1)*pi./180);
        Dp(K-1)=real(S0)-Peq(K-1);
        if K = =            %第一时段
            DQ(K)=K1*DP(K-1)./2;
        else
            DQ(K)=DQ(K-1)+K1*DP(K-1)./2;
        end
        Q(K)=Q(K-1)+DQ(K); 
    elseif
        C(K-1,1) = = 0  %切除故障时
        P1(K-1)=P(K-2);
        P2(K-1)=P(K-1);
        Peq=(K-1)=P1(K-1)*sin(Q(K-1));
        DP(K-1)=real(S0)-Peq(K-1);
        DP2(K-1)=real(S0)-P2(K-1)*sin(Q(K-1));
        DQ(K)=DQ(K-1)+K1*(DP(K-1)+DP2(K-1))./2;
        Q(K)=Q(K-1)+DQ(K);        
    end
end
disp('程序计算结果如下:');
disp('输出不平衡功率:DP=');
disp(DP);
disp('输出功角增量:DQ=');
disp(DQ);
disp('输出功角:Q=');
disp(Q);
disp('输出电磁功率:Peq=');
disp(Peq);
disp('输出发电机转子摇摆曲线如图Figure No.1所示:');
t=0:dt:dt*N;
plot(t,q,t,dtjx); xlabel('时间（秒）');ylabel('功角（度数）');title('发电机摇摆曲线');