% ���������γɽ�㵼�ɾ���
n=input('������ڵ���:n=');
nl=input('������֧·��:nl=');
B=input('��������֧·�����γɵľ���:B=');
X=input('�������ɽڵ�ż���Ե��迹�γɵľ���:X=');
Y=zeros(n); %zeros����
for i=1:n
    if X(i,2)~ =0;
        p=X(i,1);
        Y(p,p)=1./X(i,2);
    end
end
for i=1:nl
    if B(i,6)= =0
        p=B(i,1);
        q=B(i,2);
    else
        p=B(i,2);
        q=B(i,1); 
    end
    Y(p,q)=Y(p,q)-1./B(i,3)*B(i,5);
    Y(q,p)=Y(p,q);
    Y(q,q)=Y(q,q)+1./(B(i,3)*B(i,5)^2)+B(i,4)./2;
    Y(p,p)=Y(p,p)+1./B(i,3)+B(i,4)./2;
end
disp('���ɾ���Y=');
disp(Y)

%��ע:zeros�����ĳ����÷�
%zeros(m,n);  ����һ��m*n�������
%zeros(m);    ����һ��m*m�������
%zeros(m,n,k,...); ����һ��m*n*k*...�������
%zeros(size(A));   ����һ�������A��ά��һ�µ������
%git test txt
%% matlab���ı����ʽ��GB2312