%�������ǶԼ򵥲��Գƹ��ϵļ���
NF=input('�������·�����Ŀ:NF=');
for i1 = 1:NF
    clear;
    n1=input('����������ڵ���:n1=');
    n2=input('�����븺��ڵ���:n2=');
    n0=input('����������ڵ���:n0=');
    nl1=input('����������֧·��:nl1=');
    nl2=input('�����븺��֧·��:nl2=');
    nl0=input('����������֧·��:nl0=');
    Lf=input('�������·����:Lf=');
    f=input('�������·�ڵ��:f=');
    If=input('�������ݺ���ϱ�־:If=');
    zf=input('������ӵ��迹:zf=');
    zg=input('������ӵ��迹:zg=');
    B1=input('����������֧·����:B1=');
    B2=input('�����븺��֧·����:B2=');
    B0=input('����������֧·����:B0=');
    A1=input('�����벻�Գ�ϵ��:A1=');
    Vcs=input('�������ɸ��ڵ�ĳ�ʼ��ѹ����ֵ�γɵ��о���:Vcs=');
    Z1=zeros(n1); Z2=zeros(n2); Z0=zeros(n0);
    Y1=zeros(n1); Y2=zeros(n2); Y0=zeros(n0);
    V1=zeros(n1,1); V2=zeros(n2,1); V0=zeros(n0,1);
    I1=zeros(nl1,1); I2=zeros(nl2,1); I0=zeros(nl0,1);
    for m1 = 1:3
        m=0;
        if m1= =1
            nl=nl1; B=B1; Z=Z1; n=n1;
        elseif m1= =2
            nl=nl2; B=B2; Z=Z2; n=n2;
        elseif m1= =3
            nl=nl0; B=B0; Z=Z0; n=n0;
        end
        m=0; Z=zeros(n); V=zeros(n); Z=zeros(nl);
        for k1 = 1:nl
            p=B(k1,1); q=B(k1,2);
            if B(k1,6) = = 0;
               k=1./B(k1,5);
            else
                k=B(k1,5); 
            end
            if p = = 0
                if q>m          %׷�ӽӵ���֧
                    Z(q,q)=B(k1,3);
                    m=m+1;
                else            %׷�ӽӵ���֧
                    for i = 1:m
                        Z(i,m+1)=-Z(i,q); Z(m+1,i)=-Z(q,i);
                    end
                    Z(m+1,m+1)=Z(q,q)+B(k1,3);
                    for i = 1:m
                        for j = 1:m
                            Z(i,j)=Z(i,j)-Z(i,m+1)*Z(m+1,j)./Z(m+1,m+1)
                        end
                        Z(i,m+1)=0;
                    end
                    for i = 1:m+1
                        Z(m+1,i)=0;
                    end
                end
            else
                if q>m%׷�Ӳ��ӵ���֧
                    for i = 1:m
                        Z(i,q)=Z(i,p)*k; Z(q,i)=Z(p,i)*k;
                    end
                    Z(q,q)=k^2*Z(p,p)+k^2*B(k1,3);
                    m=m+1;
                else
                    for i = 1:m%׷�Ӳ��ӵ���֧
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
        if m1 = = 1
            Z1=Z;
        elseif m1 = = 2
            Z2=Z;
        elseif m1 = = 3
            Z0=Z;
        end
    end
    if If = = 0
        Z1(f,f)=Z1(f,f);
        Z2(f,f)=Z2(f,f);
        Z0(f,f)=Z0(f,f);
    else
        Z1(f,f)=Z1(f,f)+Z1(1,1)-2*Z1(f,1);
        Z2(f,f)=Z2(f,f)+Z2(1,1)-2*Z2(f,1);
        Z0(f,f)=Z0(f,f)+Z0(1,1)-2*Z0(f,1);
    end
    if Lf = = 1          %������������·�ڵ�ĵ�������ֵ
        Z4=Z2(f,f)+Z0(f,f)+3*zf; k2=1; k0=1; 
        I1(f)=Vcs(f)./(Z1(f,f)+Z4); I2(f)=k2*I1(f); I0(f)=k0*I1(f); 
        a1=I1(f); a2=I2(f); a0=I0(f);
    elseif Lf = = 2
        Z4=Z2(f,f)+2*zf; k2=-1; k0=0;
        I1(f)=Vcs(f)./(Z1(f,f)+Z4); I2(f)=k2*I1(f); I0(f)=k0*I1(f);
        a1=I1(f); a2=I2(f); a0=I0(f);
    elseif Lf = = 3
        Z4=zf+(Z2(f,f)+zf)*(Z0(f,f)+zf+3*zg)./(Z2(f,f)+Z0(f,f)+2*zf+3*zg); 
        k2=-(Z0(f,f)+zf+3*zg)./(Z2(f,f)+Z0(f,f)+2*zf+3*zg);
        k0=-(Z2(f,f)+zf)./(Z2(f,f)+Z0(f,f)+2*zf+3*zg); 
        I1(f)=Vcs(f)./(Z1(f,f)+Z4); I2(f)=k2*I1(f); I0(f)=k0*I1(f);
        a1=I1(f); a2=I2(f); a0=I0(f);
    elseif Lf = = 4
        Z4=zf+(Z2(f,f)+zf)*(Z0(f,f)+zf)./(Z2(f,f)+Z0(f,f)+2*zf);
        k2=-(Z0(f,f)+zf)./(Z2(f,f)+Z0(f,f)+2*zf);
        k0=-(Z2(f,f)+zf)./(Z2(f,f)+Z0(f,f)+2*zf+3*zg);
        I1(f)=Vcs(f)./(Z1(f,f)+Z4); I2(f)=k2*I1(f0); I0(f)=k0*I1(f); 
        a1=I1(f); a2=I2(f); a0=I0(f);
    elseif Lf = = 5   
        Z4=Z2(f,f)+Z0(f,f)+3*zf; k2=1; k1=0;
        I1(f)=Vcs(f)./(Z1(f,f)+Z4); I2(f)=k2*I1(f); I0(f)=k0*I1(f);
        a1=I1(f); a2=I2(f); a0=I0(f);
    end
    disp('���ϵ㴦�������������ֵΪ:');
    disp(a1);
    disp('���ϵ㴦�ĸ����������ֵΪ:');
    disp(a2);
    disp('���ϵ㴦�������������ֵΪ:');
    disp(a0);
    for i = 1:n1
        V1(i)=Vcs(i)-I1(f*Z1(i,f));
    end
    for i = 1:n2
        V2(i)=-I2(f)*Z2(i,f);
    end
    for i = 1:n0
        V0(i)=-I0(f)*Z0(i,f);
    end
    disp('���ڵ�������������ֵΪ�����Ŵ�С�����ţ�:');
    disp(V1);
    disp('���ڵ�ĸ����������ֵΪ�����Ŵ�С�����ţ�:');
    disp(V2);
    disp('���ڵ�������������ֵΪ�����Ŵ�С�����ţ�:');
    disp(V0);
    for i = 1:3
        if i = = 1
            B=B1; V=V1; nl=nl1;
        elseif i = = 2
            B=B2; V=V2; nl=nl2;
        elseif i = = 3
            B=B0; V=V0; nl=nl0;
        end
        for j = 1:nl
            if B(j,6) = = 0
                k=B(j,5);
            else
               k=1./B(j,5); 
            end
            p=B(j,1); q=B(j,2);
            if p = = 0
                e=0; b=B(j,3);
                I(j)=(e-V(q)./k).b;
            else
                I(j)=(V(p)-V(q)./k)./B(j,3);
            end
        end
        if i = = 1
            I1=I;
        elseif i = = 2
            I2=I;
        elseif i = = 3
            I0=I;
        end
    end
    disp('��֧·�������������ֵΪ��˳��ͬ������Bʱһ����:');
    for i = 1:nl
        disp(I1(i));
    end
    disp('��֧·�ĸ����������ֵΪ��˳��ͬ������Bʱһ����:');
    for i = 1:nl
        disp(I2(i));
    end
    disp('��֧·�������������ֵΪ��˳��ͬ������Bʱһ����:');
    for i = 1:nl
        disp(I0(i));
    end
    for i = 1:3         %����ϵ�A,B,C���������ܵ����������ڵ�A,B,C���������ܵ�ѹ����֧·A,B,C���������ܵ���
        if i = = 1
            s0=a0; s1=a1; s2=a2;
        elseif i = = 2
            s0=V0; s1=V1; s2=V2;
        else
            s0=I0; s1=I1; s2=I2;
        end
        for j = 1:3
            CA=s0*A1(j,1)+s1*A1(j,2)+s2*A1(j,3);
            if j = = 1
                A=CA;
            elseif j = = 2
                B=CA;
            elseif j = = 3
                C=CA;
            end
        end
        if i = = 1
            Iadl=A; Ibdl=B; Icdl=C;
        elseif i = = 2
            Vajy=A; Vbjy=B; Vcjy=C;
        else
            Iazl=A; Ibzl=B; Iczl=C;
        end
    end
    disp('���ϵ㴦A�����IadlΪ:');
    disp(Iadl);
    disp('���ϵ㴦B�����IbdlΪ:');
    disp(Ibdl);
    disp('���ϵ㴦C�����IcdlΪ:');
    disp(Icdl);
    disp('���ڵ㴦A���ѹVajy�ֱ�Ϊ�����Ŵ�С�����ţ�:');
    disp(Vajy);
    disp('���ڵ㴦B���ѹVbjy�ֱ�Ϊ�����Ŵ�С�����ţ�:');
    disp(Vbjy);
    disp('���ڵ㴦C���ѹVcjy�ֱ�Ϊ�����Ŵ�С�����ţ�:');
    disp(Vcjy);
    disp('��֧·A�����Iazl�ֱ�Ϊ��˳��ͬ������Bʱһ����:');
    for i = 1:nl
        disp(Iazl(i));
    end
    disp('��֧·B�����Ibzl�ֱ�Ϊ��˳��ͬ������Bʱһ����:');
    for i = 1:nl
        disp(Ibzl(i));
    end
    disp('��֧·C�����Iczl�ֱ�Ϊ��˳��ͬ������Bʱһ����:');
    for i = 1:nl
        disp(Iczl(i));
    end
end