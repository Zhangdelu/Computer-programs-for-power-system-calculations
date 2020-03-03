%本程序是用牛顿-拉夫逊法进行潮流计算
n=input('请输入节点数:n=');
nl=input('请输入支路数:nl=');
isb=input('请输入平衡母线节点号:isb=');
pr=input('请输入误差精度:pr=');
B1=input('请输入由支路参数形成的矩阵:B1=');
B2=input('请输入各节点参数形成的矩阵:B2=');
X=input('请输入由各节点号及其对地阻抗形成的矩阵:X=');
Y=zeros(n); e=zeros(1,n); f=zeros(1,n); V=zeros(1,n); O=zeros(1,n); S1=zeros(nl);
for i = 1:n
    if X(i,2) ~ = 0;
        p=X(i,1);
        Y(p,p)=1./X(i,2);
    end
end
for i = 1:nl
    if B1(i,6) = = 0
        p=B1(i,1); q=B1(i,2);
    else
        p=B1(i,2); q=B1(i,1);
    end
    Y(p,q)=Y(p,q)-1./(B1(i,3)*B1(i,5));
    Y(q,p)=Y(p,q);
    Y(q,q)=Y(q,q)+1./(B1(i,3)*B1(i,5)^2)+B1(i,4)./2;
end             %求导纳矩阵
G=real(Y); B=imag(Y);
for i = 1:n
    e(i)=real(B2(i,3));
    f(i)=imag(B2(i,3));
    V(i)=B2(i,4);
end
for i = 1:n
    S(i)=B2(i,1)-B2(i,2);
    B(i,i)=B(i,i)+B2(i,5);
end
P=real(S); Q=imag(S);
ICT1=0; IT2=1; N0=2*n; N=N0+1; a=0;
while IT2 ~ = 0
    IT2=0; a=a+1;
    for i = 1:n
        if i ~ = isb
            C(i)=0; D(i)=0;
            for j1 = 1:n
                C(i)=C(i)+G(i,j1)*e(j1)-B(i,j1)*f(j1);
                D(i)=D(1)+G(i,j1)*f(j1)+B(i,j1)*e(j1);
            end
            P1=C(i)*e(i)+f(i)*D(i);
            Q1=f(i)*C(i)-D(i)*e(i);         %求'P,Q'
            V2=e(i)^2+f(i)^2;
            if B2(i,6) ~ = 3
                DP=P(i)-P1;
                DQ=Q(i)-Q1;
                for j1 = 1:n
                    if j1 ~ =isb & j1 ~ =i
                        X1=-G(i,j1)*e(i)-B(i,j1)*f(i);
                        X2=B(i,j1)*e(i)-G(i,j1)*f(i);
                        X3=X2;
                        X4=-X1;
                        p=2*i-1; q=2*j1-1; J(p,q)=X3; J(p,N)=DQ; m=p+1;
                        J(m,q)=X1; J(m,N)=DP; q=q+1; J(p,q)=X4; J(m,q)=X2;
                    elseif j1 = =i & j1 ~ = isb
                        X1=-C(i)-G(i,i)*e(i)-B(i,i)*f(i);
                        X2=-D(i)+B(i,i)*e(i)-G(i,i)*f(i);
                        X3=D(i)+B(i,i)*e(i)-G(i,i)*f(i);
                        X4=-C(i)+G(i,i)*e(i)+B(i,i)*f(i);
                        p=2*i-1; q=2*j1-1; J(p,q)=X3; J(p,N)=DQ; m=p+1;
                        J(m,q)=X1; J(m,N)=DP; q=q+1; J(p,q)=X4; J(m,q)=X2;
                    end
                end
            else
                DP=P(i)-P1;
                DV=V(i)^2-V2;
                for j1 = 1:n
                    if j1 ~ =isb & j1 ~ =i
                        X1=-G(i,j1)*e(i)-B(i,j1)*f(i);
                        X2=B(i,j1)*e(i)-G(i,j1)*f(i);
                        X5=0;
                        X6=0;
                        p=2*i-1; q=2*j1-1; J(p,q)=X5; J(p,N)=DV; m=p+1;
                        J(m,q)=X1; J(m,N)=DP; q=q+1; J(p,q)=X6; J(m,q)=X2;
                    elseif j1 = =i & j1 ~ = isb
                        X1=-C(i)-G(i,i)*e(i)-B(i,i)*f(i);
                        X2=-D(i)+B(i,i)*e(i)-G(i,i)*f(i);
                        X5=-2*e(i);
                        X6=-2*f(i);
                        p=2*i-1; q=2*j1-1; J(p,q)=X5; J(p,N)=DV; m=p+1;
                        J(m,q)=X1; J(m,N)=DP; q=q+1; J(p,q)=X6; J(m,q)=X2;
                    end
                end
            end
        end
    end                 %求雅可比矩阵
    for k = 3:N0
        k1=k+1; N1=N;
        for k2 = k1:N1
            J(k,k2)=J(k,k2)./J(k,k);
        end
        J(k,k)=1;
        if k ~ =3
            k4=k-1;
            for k3 = 3:k4
                for k2 = k1:N1
                    J(k3,k2)=J(k3,k2)-J(k3,k)*J(k,k2);
                end
                J(k3,k)=0;
            end
            if k = = N0
                break;
            end
            for k3 = k1:N0
                for k2 = k1:N1
                    J(k3,k2)=J(k3,k2)-J(k3,k)*J(k,k2);
                end
                J(k3,k)=0;
            end
        else
            for k3 = k1:N0
                for k2 = k1:N1
                    J(k3,k2)=J(k3,k2)-J(k3,k)*J(k,k2);
                end
                J(k3,k)=0;
            end
        end
    end
    for k = 3:2:N0-1
        L=(k+1)./2;
        e(L)=e(L)-J(k,N);
        k1=k+1;
        f(L)=f(L)-J(k1,N);
    end
    for k = 3:N0
        DET=abs(J(k,N));
        if DET>=pr
            IT2=IT2+1;
        end
    end
    ICT2(a)=IT2;
    ICT1=ICT+1;
    for k = 1:n
        dy(k)=sqrt(e(k)^2+f(k)^2);
    end
    for i = 1:n
        Dy(ICT1,i)=dy(i);
    end
end             %用高斯消去法解"w=-J*V"
disp('迭代次数');
disp(ICT1);
disp('没有达到精度要求的个数');
disp(ICT2);
for k = 1:n
    V(k)=sqrt(e(k)^2+f(k)^2);
    O(k)=atan(f(k)./e(k))*180./pi;
end
E=e+f*j;
disp('各节点的实际电压标幺值E为（节点号从小到大排列）:');
disp(E);
disp('各节点的电压大小V为（节点号从小到大排列:');
disp(V);
disp('各节点的电压相角O为（节点号从小到大排列）:');
disp(O);
for p = 1:n
    C(p)=0;
    for q = 1:n
        C(p)=C(p)+conj(Y(p,q))*conj(E(q));
    end
    S(p)=E(p)*C(p);
end
disp('各节点的功率S为（节点号从小到大排列）:');
disp(S);
disp('各条支路的首端功率Si为（顺序同您输入B1时一样）:');
for i = 1:nl
    if B1(i,6) = = 0
        p=B1(i,1); q=B1(i,2);
    else
        p=B1(i,2); q=B1(i,1);
    end
    Si(p,q)=E(p)*(conj(E(p))*conj(B1(i,4)./2))+(conj(E(p)*B1(i,5))-conj(E(q)))*conj(1./(B1(i,3)*B1(i,5)));
    disp(Si(p,q));
end
disp('各支路的末端功率Sj为（顺序同您输入B1时一样）:');
for i = 1:nl
    if B1(i,6) = = 0
        p=B1(i,1); q=B1(i,2);
    else
        p=B1(i,2); q=B1(i,1);
    end
    Sj(q,p)=E(q)*(conj(E(q))*conj(B1(i,4)./2)+(conj(E(q)./B1(i,5))-conj(E(p)))*conj(1./(B1(i,3)*B1(i,5))));
    disp(Sj(q,p));
end
disp('各支路的末端功率Sj为（顺序同您输入B1时一样）:');
for i = 1:nl
    if B1(i,6) = = 0
        p=B1(i,1); q=B1(i,2);
    else
        p=B1(i,2); q=B1(i,1);
    end
    DS(i)=Si(p,q)+Sj(q,p);
    disp(DS(i));
end
for i = 1:ICT1
    Cs(i)=i;
end
disp('以下是每次迭代后各节点的电压值（如图所示）');
plot(Cs,Dy),set(get(gca, 'XLabel'), 'String', '迭代次数'),set(get(gca, 'YLabel'), 'String', '电压'),
set(get(gca, 'Title'), 'String', '电压迭代次数曲线');