%����������֧·׷�ӷ��γɽڵ��迹����
n=input('������ڵ���=');
nl=input('������֧·��nl=');
B=input('��������֧·�����γɵľ���B=');
m=0;Z=zeros(n);
for k1=1:nl
    p=B(k1,1);q=B(k2,2);
    if B(k1,6)= =0
        l=1./B(k1,5);
    else
    l=B(k1,5); 
    end
    if p= =0
        if q>m              %׷�ӽӵ���֧
            Z(q,q)=B(k1,3);m=m+1;
        else
            for k = 1:m     %׷�ӽӵ���֧
                Z(k,m+1)=-Z(k,q);Z(m+1,k)=-Z(q,k);
            end
            Z(m+1,m+1)=Z(q,q)+B(k1,3);
            for l1 = 1:m
                for k = 1:m
                    Z(l1,k)=Z(l1,k)-Z(l1,m+1)*Z(m+1,k)./Z(m+1,m+1);
                end
                Z(l1,m+1)=0;
            end
            for k = 1:m+1
                Z(m+1,k)=0;
            end
        end       
    else 
        if q>m          %׷�Ӳ��ӵ���֧
            for k = 1:m
                Z(k,q)=Z(k,p)*l;Z(p,k)*l;
            end
            Z(q,q)=l^2*Z(p,p)+l^2*B(k1,3);
            m=m+1;
        else
            for k = 1:m %׷�Ӳ��ӵ���֧
                Z(k,m+1)=l*Z(k,p)-Z(k,q);
                Z(m+1,k)=l*Z(p,k)-Z(q,k);
            end
            Z(m+1,m+1)=l^2*Z(p,p)+Z(q,q)-2*l*Z(p,q)+l^2*B(k1,3);
            for l1 = 1:m
                for k = 1:m
                    Z(l1,k)=Z(l1,k)-Z(l1,m+1)*Z(m+1,k)./Z(m+1,m+1);
                end
                Z(l1,m+1)=0;
            end
            for k = 1:m+1
                Z(m+1,k)=0;
            end
        end
    end
end
disp('�迹����Z=');
disp(Z)