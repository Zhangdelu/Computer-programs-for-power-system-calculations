% 本程序是形成结点导纳矩阵
n=input('请输入节点数:n=');
nl=input('请输入支路数:nl=');
B=input('请输入由支路参数形成的矩阵:B=');
X=input('请输入由节点号及其对地阻抗形成的矩阵:X=');
Y=zeros(n); %zeros函数
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
disp('导纳矩阵Y=');
disp(Y)

%备注:zeros函数的常用用法
%zeros(m,n);  生成一个m*n的零矩阵
%zeros(m);    生成一个m*m的零矩阵
%zeros(m,n,k,...); 生成一个m*n*k*...的零矩阵
%zeros(size(A));   生成一个与矩阵A的维度一致的零矩阵
%git test txt
%% matlab中文编码格式是GB2312