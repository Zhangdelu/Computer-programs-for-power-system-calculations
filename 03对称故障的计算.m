%本程序是计算三相短路电流、各节点电压、各支路的电流
NF=input('请输入短路点的数目:NF=');
n=input('请输入独立节点数目:n=');
nl=input('请输入支路数:nl=');
B=input('请输入由线路参数形成的矩阵:B=');
V0=input('请输入由各节点的初电压标幺值形成的列矩阵:V0=');
D=input('请输入由短路号，短路点阻抗形成的矩阵:D=');
m=0; Z=zeros(n); V=zeros(n); I=zeros(nl);
for k1 = 1:nl
    p=B(k1,1); q=B(k1,2);
    if B(k1,6)= =0
        k=1./B(k1,5);
    else
        k=B(k1,5);
    end
    if p= =0
       if q>m           %追加接地树支
           Z(q,q)=B(k1,3);
           m=m+1;
       else
           for i = 1:m  %追加接地连支
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
        if q>m          %追加不接地树支
            for i = 1:m
                Z(i,q)=Z(i,p)*k; Z(q,i)=Z(p,i)*k;
            end
            Z(q,q)=k^2*Z(p,p)+k^2*B(k1,3);
            m=m+1;
        else
            for i = 1:m %追加不接地连支
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
for k = 1:NF    %求各短路点的电流标幺值
    I(D(k,1),D(k,1))= V0(D(k1,1),1)./(Z(D(k+1),D(k+1))+D(k,2));
    ft=num2str(D(k,1));
    ts1=('点短路时');
    ts2=('电流的标幺值If=');
    dn=strcat(ft,ts1,ts2);
    disp(dn);
    disp(I(D(k,1),D(k,1)));
    for i = 1:n
        V(i,i)= V0(i,1)-I(D(k,1),D(k,1))*Z(i,D(k,1));   %求各节点的电压标幺值
    end
end