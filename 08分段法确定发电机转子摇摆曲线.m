%���������÷ֶη�ȷ�������ת��ҡ������
S0=input('�������ʼ����:S0=');
V0=input('���������޴�ϵͳĸ�ߵ�ѹ:V0=');
B=input('������ϵͳ��ֵ�翹����:B=');
Tj=input('���������ʱ�䳣��:Tj=');
N=input('������ʱ����:N=');
Ni=input('�������ĸ�ʱ�η�������:Ni=');
dt=input('������ÿ�μ����ʱ��:dt=');
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
    if C(K-1,1) = = 1       %���Ϸ���֮ǰ
        Peq(K-1)=P(K-1)*sin(Q(K-1)*pi./180);
        Dp(K-1)=real(S0)-Peq(K-1);
        if K = =            %��һʱ��
            DQ(K)=K1*DP(K-1)./2;
        else
            DQ(K)=DQ(K-1)+K1*DP(K-1)./2;
        end
        Q(K)=Q(K-1)+DQ(K); 
    elseif
        C(K-1,1) = = 0  %�г�����ʱ
        P1(K-1)=P(K-2);
        P2(K-1)=P(K-1);
        Peq=(K-1)=P1(K-1)*sin(Q(K-1));
        DP(K-1)=real(S0)-Peq(K-1);
        DP2(K-1)=real(S0)-P2(K-1)*sin(Q(K-1));
        DQ(K)=DQ(K-1)+K1*(DP(K-1)+DP2(K-1))./2;
        Q(K)=Q(K-1)+DQ(K);        
    end
end
disp('�������������:');
disp('�����ƽ�⹦��:DP=');
disp(DP);
disp('�����������:DQ=');
disp(DQ);
disp('�������:Q=');
disp(Q);
disp('�����Ź���:Peq=');
disp(Peq);
disp('��������ת��ҡ��������ͼFigure No.1��ʾ:');
t=0:dt:dt*N;
plot(t,q,t,dtjx); xlabel('ʱ�䣨�룩');ylabel('���ǣ�������');title('�����ҡ������');