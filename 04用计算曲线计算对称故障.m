%���������ü������߼��������·����
NF=input('�������·�����Ŀ:NF=');
n=input('������ڵ���:n=');
nl=input('������֧·��:nl=');
Sb=input('�������׼����:Sb=');
D=input('�������ɶ�·�ţ���·���迹�γɵľ���:D=');
vb=input('�������ɸ��ڵ��ѹ��ɵ��о���:vb=');
V0=input('�������ɸ��ڵ�ĳ���ѹ��ɵ��о���:V0=');
B=input('������֧·��������:B=');
N=input('������Ҫ���ñ�����Ĵ���:N=');
m=0; Z=zeros(n); sq3=sqrt(3); s=zeros(N,1);
for k1 = 1:n1
    p=B(k1,1); q=B(k1,2);
    if B(k1,6) = = 0
        k=1./B(k1,5);
    else
        k=B(k1,5);
    end
    if p = = 0
        if q>m      %׷�ӽӵ���֧
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
        if q>m      %׷�Ӳ��ӵ���֧
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
    Idb=V0(D(r,1),1)./(Z(D(r,1),D(r,1))+D(r,2));    %���·������ı���ֵ
    ts1=('�����Ƕ�·��');
    ft=num2str(D(r,1));
    ts2=('��ʱ�̵Ľ��');
    dn=strcat(ts1,ft,t2);
    disp(dn);
    for k = 1:n
        Vb(k)=V0(k,1)-Idb*Z(k,D(r,1));              %����ڵ�ĵ�ѹ����ֵ
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
        Ib(i1)=V(i1)./B(il,3);                      %���֧·�ĵ�������ֵ
    end
    disp('0 sʱ��·��ĵ���Ϊ')
    disp(Idb);
    disp('0 sʱ���ڵ�ĵ�ѹ����ֵΪ');
    disp(Vb);
    disp('0 sʱ��֧·�ĵ�������ֵΪ');
    disp(Ib);
    for a = 1:N
        Is=zeros(1,n1); Isy=zeros(1,n1); Idzs=0;
        s(a)=input('�������·�������Ҫ��ֹ������������-1��s=');
        if s(a) = = -1
            disp('�������ѱ���ֹ��ллʹ�ã�');
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
                        ts1=('������Դ');
                        ft=num2str(k);
                        ts2=('�Զ�·��ļ���翹Xjs1,��Ӧ�ĵ�������ֵ������ֵ�ֱ�Ϊ');
                        dn=strcat(ts1,ft,ts2);
                        disp(dn);
                        disp(Xjs1(k)); disp(Is(k)); disp(Isy(k));
                    else
                        Isy(k)=Is(k)*Sn(k)./(sq3*vb(D(r,1)));
                        ts1=('��ֵ��Դ');
                        ft=num2str(k);
                        ts2=('�Զ�·��ļ���翹Xjs1����Ӧ�ĵ�������ֵ������ֵ�ֱ�Ϊ');
                        dn=strcat(tsl,ft,ts2);
                        disp(dn);
                        disp(Xjs1(k)); disp(Is(k)); disp(Isy(k));
                    end
                else
                    Xjs=Xjs1(k);
                    ts1=('��ֵ��Դ')�?
                    ft=num2str(k);
                    ts2=('�Զ�·��ļ���翹Xjs1Ϊ');
                    dn=strcat(ts1,ft,ts2);
                    disp(dn);
                    disp(Xjs);
                    Is(k)=input('�������翹Vjs��Ӧ�ĵ�������ֵI=');
                    Isy(k)=Is(k)*Sn(k)./(sq3*vb(D(r,1)));
                    disp('��Ӧ�ĵ�������ֵ������ֵ����λ:KA���ֱ�Ϊ');
                    disp(Is(k)); disp(Isy(k));
                end
                Idzs=Idzs+Isy(k);
            end
        end
        Id(a)=Idzs;
        sj=numstr(s(a));
        ts=('���Ӧ�Ķ�·���ܵ���Ϊ����λ:KA��');
        jg=strcat(sj,ts);
        disp(jg);
    end
    plot(s,Id); xlable('ʱ��(��)'); ylable('��·������С�ı���ֵ'); title('��·��������');
end