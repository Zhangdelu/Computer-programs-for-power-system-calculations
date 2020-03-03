%本程序是用计算曲线计算三相短路电流
NF=input('请输入短路点的数目:NF=');
n=input('请输入节点数:n=');
nl=input('请输入支路数:nl=');
Sb=input('请输入基准功率:Sb=');
D=input('请输入由短路号，短路点阻抗形成的矩阵:D=');
vb=input('请输入由各节点电压组成的行矩阵:vb=');
V0=input('请输入由各节点的初电压组成的列矩阵:V0=');
B=input('请输入支路参数矩阵:B=');
N=input('请输入要调用本程序的次数:N=');
m=0; Z=zeros(n); sq3=sqrt(3); s=zeros(N,1);
for k1 = 1:n1
    p=B(k1,1); q=B(k1,2);
    if B(k1,6) = = 0
        k=1./B(k1,5);
    else
        k=B(k1,5);
    end
    if p = = 0
        if q>m      %追加接地树支
            Z(q,q)=B(k1,3);
            m=m+1;  
        else
            for i1 = 1:m
                Z(i1,m+1)=-Z(i1,q); Z(m+1,i1)=-Z(q,i1);
            end
            Z(m+1,m+1)=Z(q,q)+B(k1,3);
            for i1 = 1:m
                for j = 1:m
                    Z(i1,j)=Z(i1,j)-Z(i1,m+1)*Z(m+1,j)./Z(m+1,m+1);
                end
                Z(i1,m+1)=0;
            end
            for i1 = 1:m+1
                Z(m+1,i1)=0;                
            end
        end
    else
        if q>m      %追加不接地树支
            for i1 = 1:m
                Z(i1,q)=Z(i1,p)*k; Z(q,i1)=Z(p,i1)*k;
            end
            Z(q,q)=k^2*Z(p,p)+k^2*B(k1,3);
            m=m+1;
        else
            for i1 = 1:m
                Z(i1,m+1)=k*Z(i1,p)-Z(i1,q);
                Z(m+1,i1)=k*Z(p,i1)-Z(q,i1);
            end
            Z(m+1,m+1)=k^2*Z(p,p)+Z(q,q)-2*k*Z(p,q)+k*B(k1,3);
            for i1 = 1:m
                for j = 1:m
                    Z(i1,j)=Z(i1,j)-Z(i1,m+1)*Z(m+1,j)./Z(m+1,m+1);
                end
                Z(i1,m+1)=0;
            end
            for i1 = 1:m+1
                Z(m+1,i1)=0;
            end
        end
    end
end
Vb=zeros(1,n); V=zeros(1,n); Vd=zeros(1,n);
Ib=zeros(1,nl);
for r = 1:NF
    Idb=V0(D(r,1),1)./(Z(D(r,1),D(r,1))+D(r,2));    %求短路点电流的标幺值
    ts1=('以下是短路点');
    ft=num2str(D(r,1));
    ts2=('各时刻的结果');
    dn=strcat(ts1,ft,t2);
    disp(dn);
    for k = 1:n
        Vb(k)=V0(k,1)-Idb*Z(k,D(r,1));              %求各节点的电压标幺值
    end
    for i1 = 1:n1
        p=B(i1,1); q=B(i1,2);
        if p ~ = 0&B(i1,8)= =0
            if B(i1,6) = =0
                k=B(i1,5);
                V(i1)=Vb(p)-Vb(q)./k;
            else
                k=1./B(i1,5);
                V(i1)=k*Vb(p)-Vb(q);
            end
        else
            V(i1)=1-Vb(q);
        end
        Ib(i1)=V(i1)./B(il,3);                      %求各支路的电流标幺值
    end
    disp('0 s时短路点的电流为')
    disp(Idb);
    disp('0 s时各节点的电压标幺值为');
    disp(Vb);
    disp('0 s时各支路的电流标幺值为');
    disp(Ib);
    for a = 1:N
        Is=zeros(1,n1); Isy=zeros(1,n1); Idzs=0;
        s(a)=input('请输入短路几秒后（若要终止本程序请输入-1）s=');
        if s(a) = = -1
            disp('本程序已被终止，谢谢使用！');
            break
        end
        for k = 1:nl
            if B(k,1) = = 0 & B(k,8) = = 1;
                Sn(k)=B(k,7);
                cf=Idb./Ib(k);
                Z1(k)=cf*Z(D(r,1),D(r,1));
                X(k)=abs(imag(Z1(k)));
                Xjs1(k)=X(k)*Sn(k)./Sb;
                if s>4 | Xjs1(k)>3.45 | B(k,9) = = 0
                    Is(k)=1./Xjs1(k);
                    if B(k,9) = = 0
                        Isy(k)=Is(k)*Sb./(sq3*vb(D(r,1)));
                        ts1=('无穷大电源');
                        ft=num2str(k);
                        ts2=('对短路点的计算电抗Xjs1,对应的电流标幺值，有名值分别为');
                        dn=strcat(ts1,ft,ts2);
                        disp(dn);
                        disp(Xjs1(k)); disp(Is(k)); disp(Isy(k));
                    else
                        Isy(k)=Is(k)*Sn(k)./(sq3*vb(D(r,1)));
                        ts1=('等值电源');
                        ft=num2str(k);
                        ts2=('对短路点的计算电抗Xjs1，对应的电流标幺值，有名值分别为');
                        dn=strcat(tsl,ft,ts2);
                        disp(dn);
                        disp(Xjs1(k)); disp(Is(k)); disp(Isy(k));
                    end
                else
                    Xjs=Xjs1(k);
                    ts1=('等值电源')锛?
                    ft=num2str(k);
                    ts2=('对短路点的计算电抗Xjs1为');
                    dn=strcat(ts1,ft,ts2);
                    disp(dn);
                    disp(Xjs);
                    Is(k)=input('查与计算电抗Vjs对应的电流标幺值I=');
                    Isy(k)=Is(k)*Sn(k)./(sq3*vb(D(r,1)));
                    disp('对应的电流标幺值、有名值（单位:KA）分别为');
                    disp(Is(k)); disp(Isy(k));
                end
                Idzs=Idzs+Isy(k);
            end
        end
        Id(a)=Idzs;
        sj=numstr(s(a));
        ts=('秒对应的短路点总电流为（单位:KA）');
        jg=strcat(sj,ts);
        disp(jg);
    end
    plot(s,Id); xlable('时间(秒)'); ylable('短路电流大小的标幺值'); title('短路电流曲线');
end