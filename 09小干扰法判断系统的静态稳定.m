%本程序是用小干扰法判断系统的静态稳定
S0=input('请输入初始功率:S0=');
V0=input('请输入无限大系统母线电压:V0=');
Xd=input('请输入系统直轴等值电抗:Xd=');
w0=input('请输入同步电角速度:w0=');
Tj=input('请输入惯性时间常数:Tj=');
zn=input('请输入综合阻尼系数:D=');
Eq=sqrt((V0+imag(S0)*Xd./V0)^2(+real(S0)*Xd./V0)^2);
dtj0=atan(real(S0)*Xd./(V0*(V0+imag(S0)*Xd./V0)));
Psl=Eq*V0./Xd;
C=w0;
D=-1./Tj*Eq*cos(dtj0)*V0./Xd;
E=w0*zn./(2*Tj);
Kp=(Psl-real(S0))./real(S0);
root1=-E+sqrt(E^2+C*D);
root2=-E-sqrt(E^2+C*D);
disp('该系统的静态稳定极限:Psl=');
disp(Psl);
disp('该系统的静态储备系数为:Kp=');
disp(KP);
disp('该系统线性微分方程的特征根为:');
disp(root); diap(root2);
if zn >= 0
    if(root1 = = conj(root2)) | ((real(root1)<0) & (real(root2)<0));
        disp('该系统是稳定的。');
    else
        disp('该系统是不稳定的。');
    end
elseif zn<0
    disp('该系统是不稳定的。');
end