%����������С���ŷ��ж�ϵͳ�ľ�̬�ȶ�
S0=input('�������ʼ����:S0=');
V0=input('���������޴�ϵͳĸ�ߵ�ѹ:V0=');
Xd=input('������ϵͳֱ���ֵ�翹:Xd=');
w0=input('������ͬ������ٶ�:w0=');
Tj=input('���������ʱ�䳣��:Tj=');
zn=input('�������ۺ�����ϵ��:D=');
Eq=sqrt((V0+imag(S0)*Xd./V0)^2(+real(S0)*Xd./V0)^2);
dtj0=atan(real(S0)*Xd./(V0*(V0+imag(S0)*Xd./V0)));
Psl=Eq*V0./Xd;
C=w0;
D=-1./Tj*Eq*cos(dtj0)*V0./Xd;
E=w0*zn./(2*Tj);
Kp=(Psl-real(S0))./real(S0);
root1=-E+sqrt(E^2+C*D);
root2=-E-sqrt(E^2+C*D);
disp('��ϵͳ�ľ�̬�ȶ�����:Psl=');
disp(Psl);
disp('��ϵͳ�ľ�̬����ϵ��Ϊ:Kp=');
disp(KP);
disp('��ϵͳ����΢�ַ��̵�������Ϊ:');
disp(root); diap(root2);
if zn >= 0
    if(root1 = = conj(root2)) | ((real(root1)<0) & (real(root2)<0));
        disp('��ϵͳ���ȶ��ġ�');
    else
        disp('��ϵͳ�ǲ��ȶ��ġ�');
    end
elseif zn<0
    disp('��ϵͳ�ǲ��ȶ��ġ�');
end