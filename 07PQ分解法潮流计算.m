%����������PQ�ֽⷨ���г�������
n=input('������ڵ���:n=');
nl=input('������֧·��:nl=');
isb=input('������ƽ��ĸ�߽ڵ��:isb=');
pr=input('����������:pr=');
B1=input('��������֧·�����γɵľ���:B1=');
B2=input('�������ɽڵ�����γɵľ���:B2=');
X=input('�������ɽڵ�ż���Ե��迹�γɵľ���:X=');
na=input('������PQ�ڵ���:na=');
Y=zeros(n); YI=zeros(n); e=zeros(1,n); V=zeros(1,n); O=zeros(1,n);
for i = 1:n
    if X(i,1) ~ =0
        p=X(i,1);
        Y(p,p)=1./X(i,2);
    end
end
for i = 1:nl
    if B1(i,6)=0
        p=B1(i,1); q=B1(i,2);
    else
        p=B1(i,2); q=B1(i,1);
    end
    Y(p,q)=Y(p,q)-1./(B1(i,3)*B1(i,5));
    YI(p,q)=YI(p,q)-1./B1(i,3);
    Y(q,p)=Y(p,q);
    YI(q,p)=YI(p,q);
    Y(q,q)=Y(q,q)+1./(B1(i,3)*B1(i,5)^2)+B1(i,4)./2;
    YI(q,q)=YI(q,q)+1./B1(i,3);
    Y(p,p)=Y(p,p)+1./B1(i,3)+B1(i,4)./2;
    YI(p,p)=YI(p,p)+1./B1(i,3);
end             %���ɾ���
G=real(Y); B=imag(YI);BI=imag(Y);
for i = 1:n
    S(i)=B2(i,1)-B2(i,2);
    BI(i,i)=BI(i,i)+B2(i,5);
end
P=real(S); Q=imag(S);
for i = 1:n
    e(i)=real(B2(i,3));
    f(i)=imag(B2(i,3));
    V(i)=B2(i,4);
end
for i = 1:n
    if B2(i,6) = =2
        V(i)=sqrt(e(i)^2+f(i)^2);
        O(i)=atan(f(i)./e(i));
    end
end
for i = 2:n
    if i = = n
        B(i,i)=1./B(i,i);
    else
        IC1=i+1;
        for j1 = IC1:n
            B(i,j1)=B(i,j1)./B(i,i);
        end
        B(i,i)=1./B(i,i);
        for k = i+1:n
            for j = i+1:n
                B(k,j1)=B(k,j1)-B(k,i)*B(i,j1);
            end
        end
    end
end
p=0; q=0;
for i = 1:n
    if B2(i,6) = = 2
        p=p+1; k=0;
        for j1 = 1:n
            if B2(j1,6) = = 2
                k=k+1;
                A(p,k)=BI(i,j1);
            end
        end
    end
end
for i = 1:na
    if i = = na
        A(i,i)=1./A(i,i);
    else
        k=i+1;
        for j1 = k:na
            A(i,j1)=A(i,j1)./A(i,i);
        end
        A(i,i)=1./A(i,i);
        for k = i+1:na
            for j1 = i+1:na
                A(k,j1)=A(k,j1)-A(k,i)*A(i,j1)�?
            end
        end
    end
end
ICT2=1; ICT1=0; kp=1; kq=1; DET=0; ICT3=1;
while ICT2 ~ = 0 | ICT3 ~ = 0
    ICT2=0; ICT3=0;
    for i = 1:n
        if i ~ = isb
            C(i)=0;
            for k = 1:n
                C(i)=C(i)+V(k)*(G(i,k)*cos(O(i)-O(k))+BI(i,k)*sin(O(i)-O(k)));
            end
            DP1(i)=P(i)-V(i)*C(i);
            DP(i)=DPI(i)./V(i);
            DET=abs(DP1(i));
            if DET>pr
                ICT2=ICT2+1;
            end
        end
    end
    Np(K)=ICT2;
    if ICT2 ~ = 0
        for i = 2:n
            DP(i)=B(i,i)*DP(i);
            if i ~ = n
                IC1=i+1;
                for k = IC1:n
                    DP(k)=DP(k)-B(k,i)*DP(i);
                end
            else
                for LZ = 3:i
                    L=i+3-LZ;
                    IC4=L-1;
                    for MZ = 2:IC4
                        I=IC4+2-MZ;
                        DP(I)=DP(I)-B(I,L)*DP(L);
                    end
                end
            end
        end
        for i = 2:n
            O(i)=O(i)-DP(i);
        end
        kq=1; L=0;
        for i = 1:n
            if B2(i,6)= =2
                C(i)=0; L=L+1;
                for k = 1:n
                    C(i)=C(i)+V(k)*(G(i,k)*sin(O(i)-O(k)))-BI(i,k)*cos(O(i)-O(k));
                end
                DQ1(i)=Q(i)-V(i)*C(i);
                DQ(L)=DQ1(i)./V(i)
                DET=abs(DQ1(i));
                if DET>pr
                    ICT3=ICT3+1;
                end
            end
        end
    else
        kp=0;
        if kq~ =0
            L=0;
            for i = 1:n
                if B2(i,6)= =2
                    C(i)=0; L=L+1;
                    for k = 1:n
                        C(i)=C(i)+V(k)*(G(i,k)*sin(O(i)-O(k))-BI(i,k)*cos(O(i)-O(k)));
                    end
                    DQ1(i)=Q(i)-V(i)*C(i);
                    DQ(L)=DQ1(i)./V(i);
                    DET=abs(DQ1(i));
                end
            end
        end
    end
    Nq(K)=ICT(3);
    if ICT3 ~ =0
        L=0;
        for i = 1:na
            DQ(i)=A(i,i)*DQ(i);
            if i= =na;
                for LZ = 2:i
                    L=i+2-LZ;
                    IC4=L-1;
                    for MZ = 1:IC4
                        I=IC4+1-MZ;
                        DQ(I)=DQ(I)-A(I,L)*DQ(L);
                    end
                end
            else
                IC1=i+1;
                for k = IC1:na
                    DQ(k)=DQ(k)-A(k,i)*DQ(i);
                end
            end
        end
        L=0;
        for i = 1:n
            if B2(i,6)= =2
                L=L+1;
                V(i)=V(i)-DQ(L);
            end
        end
        kp=1;
        K=K+1;
    else
        kq=0;
        if kp ~ =0
            K=K+1;
        end
    end
    for i = 1:n
        Dy(K-1,i)=V(i);
    end
end
disp('��������');
disp(K);
disp('ÿ��û�дﵽ����Ҫ����й����ʸ���Ϊ');
disp(Np);
disp('ÿ��û�дﵽ����Ҫ����޹����ʸ���Ϊ');
disp(Nq);
for k = 1:n
    E(k)=V(k)*cos(O(k))+V(k)*sin(O(k))*j;
    O(k)=O(k)*180./pi;
end
disp('���ڵ�ĵ�ѹ����ֵEΪ���ڵ�Ŵ�С�����ţ�:');
disp(E);
disp('���ڵ�ĵ�ѹ��СUΪ���ڵ�Ŵ�С�����ţ�:');
disp(U);
disp('���ڵ�ĵ�ѹ���OΪ���ڵ�Ŵ�С�����ţ�:');
disp(O);
for p = 1:n
    C(p)=0;
    for q = 1:n
        C(p)=C(p)+conj(Y(p,q)*conj(E(q)));
    end
    S(p)=E(p)*C(p);
end
disp('���ڵ�Ĺ���S���ڵ�Ŵ�С�����ţ�:');
disp(S);
for i = 1:nl
    if B1(i,6) = = 0
        p=B1(i,1); q=B1(i,2);
    else
        p=B1(i,2); q=B1(i,1);
    end
    Si(p,q)=E(p)*(conj(E(p))*conj(B1(i,4)./2)+(conj(E(p)*B1(i,5))-conj(E(q)))*conj(1./(B1(i,3)*B1(i,5))));
    disp(Si(p,q));
end
disp('����֧·��ĩ�˹���Sj��˳��ͬ������B1ʱһ����Ϊ:');
for i = 1:nl
    if B1(i,6) = = 0
        p=B1(i,1); q=B1(i,2);
    else
        p=B1(i,2); q=B1(i,1);
    end
    Sj(q,p)=E(q)*(conj(E(q))*conj(B1(i,4)./2)+(conj(E(q)*B1(i,5))-conj(E(q)))*conj(1./(B1(i,3)*B1(i,5))));
    disp(Sj(q,p));
end
disp('����֧·�Ĺ������DS��˳��ͬ������B1ʱһ����Ϊ:')
for i = 1:nl
    if B1(i,6) = = 0
        p=B1(i,1); q=B1(i,2);
    else
        p=B1(i,2); q=B1(i,1);
    end
    DS(i)=Si(p,q)+Sj(p,q);
    disp(DS(i));
end
for i = 1:K
    Cs(i)=i;
    for j = 1:n
        Dy(k,j)=Dy(k-1,j);
    end
end
disp('������ÿ�ε�������ڵ�ĵ�ѹֵ����ͼ��ʾ��');
plot(Cs,Dy),xlabel('��������'),ylabel('��ѹ')��title('��ѹ������������');