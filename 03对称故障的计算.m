%�������Ǽ��������·���������ڵ��ѹ����֧·�ĵ���
NF=input('�������·�����Ŀ:NF=');
n=input('����������ڵ���Ŀ:n=');
nl=input('������֧·��:nl=');
B=input('����������·�����γɵľ���:B=');
V0=input('�������ɸ��ڵ�ĳ���ѹ����ֵ�γɵ��о���:V0=');
D=input('�������ɶ�·�ţ���·���迹�γɵľ���:D=');
m=0; Z=zeros(n); V=zeros(n); I=zeros(nl);
for k1 = 1:nl
    p=B(k1,1); q=B(k1,2);
    if B(k1,6)= =0
        k=1./B(k1,5);
    else
        k=B(k1,5);
    end
    if p= =0
       if q>m           %׷�ӽӵ���֧
           Z(q,q)=B(k1,3);
           m=m+1;
       else
           for i = 1:m  %׷�ӽӵ���֧
               Z(i,m+1)=-Z(i,q);Z(m+1,i)=-Z(q,i);
           end
           Z(m+1,m+1)=Z(q,q)+B(k1,3);
           for i = 1:m
                for j = 1:m
                    Z(i,j)=Z(i,j)-Z(i,m+1)*Z(m+1,j)./Z(m+1,m+1);
                end
                Z(i,m+1)=0;
           end
           for i = 1:m+1
               Z(m+1,i)=0;
           end
       end 
    else
        if q>m          %׷�Ӳ��ӵ���֧
            for i = 1:m
                Z(i,q)=Z(i,p)*k; Z(q,i)=Z(p,i)*k;
            end
            Z(q,q)=k^2*Z(p,p)+k^2*B(k1,3);
            m=m+1;
        else
            for i = 1:m %׷�Ӳ��ӵ���֧
                Z(i,m+1)=k*Z(i,p)-Z(i,q);
                Z(m+1,i)=k*Z(p,i)-Z(q,i);
            end
            Z(m+1,m+1)=k^2*Z(p,p)+Z(q,q)-2*k*Z(p,q)+k^2*B(k1,3);
            for i = 1:m
                for j = 1:m
                    Z(i,j)=Z(i,j)-Z(i,m+1)*Z(m+1,j)./Z(m+1,m+1);
                end
                Z(i,m+1)=0;
            end
            for i = 1:m+1
                Z(m+1,i)=0;
            end
        end       
    end
end
for k = 1:NF    %�����·��ĵ�������ֵ
    I(D(k,1),D(k,1))= V0(D(k1,1),1)./(Z(D(k+1),D(k+1))+D(k,2));
    ft=num2str(D(k,1));
    ts1=('���·ʱ');
    ts2=('�����ı���ֵIf=');
    dn=strcat(ft,ts1,ts2);
    disp(dn);
    disp(I(D(k,1),D(k,1)));
    for i = 1:n
        V(i,i)= V0(i,1)-I(D(k,1),D(k,1))*Z(i,D(k,1));   %����ڵ�ĵ�ѹ����ֵ
    end
end