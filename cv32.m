clc
clear
format long g

%Parameters of WGS
a_wgs = 6378137.0;
b_wgs = 6356752.314245;
phi_wgs = 0*pi/180;

%Local aproximation R=sqrt(M*N)
e2_wgs = (a_wgs^2 - b_wgs^2) / a_wgs^2;
e_wgs = sqrt(e2_wgs);
W_wgs = sqrt(1-e2_wgs*sin(phi_wgs)^2);

M_wgs = (a_wgs*(1 - e2_wgs))/W_wgs^3
N_wgs = a_wgs/W_wgs;

Rl = sqrt(M_wgs*N_wgs)

%Global, R=a
Rg1 = a_wgs;

%Global, R=b
Rg2 = b_wgs;

%Global,  R=(a+b+c)/3
Rg3 = (a_wgs+b_wgs+a_wgs)/3;

%Global, same volume
Rg4 = (a_wgs^2*b_wgs)^(1/3)

%Global, same area
Rg5 = b_wgs * (1 + (2/3)*e_wgs + (3/5)*e2_wgs + (4/7)*e_wgs^3 + (5/9)*e_wgs^4);


