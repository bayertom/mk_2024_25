clc
clear
format long g

%Input points
phi1_wgs = 50
la1_wgs = 15
phi2_wgs = 60
la2_wgs = 20

%Convert to radians
phi1_wgs_rad = phi1_wgs/180*pi
la1_wgs_rad = la1_wgs/180*pi
phi2_wgs_rad = phi2_wgs/180*pi
la2_wgs_rad = la2_wgs/180*pi

[x1_jtsk, y1_jtsk] = besstojtsk(phi1_wgs_rad,la1_wgs_rad)
[x2_jtsk, y2_jtsk] = wgstojtsk(phi2_wgs_rad,la2_wgs_rad)

function [x_jtsk,y_jtsk] = wgstojtsk(phi_wgs,la_wgs)

%Parameters of WGS
a_wgs = 6378137.0;
b_wgs = 6356752.314245;

%N
e2_wgs = (a_wgs^2 - b_wgs^2) / a_wgs^2;
W_wgs = sqrt(1-e2_wgs*sin(phi_wgs)^2);
N_wgs = a_wgs/W_wgs;

%X, Y, Z
X_wgs = N_wgs * cos(phi_wgs) * cos(la_wgs);
Y_wgs = N_wgs * cos(phi_wgs) * sin(la_wgs);
Z_wgs = N_wgs * (1-e2_wgs) * sin(phi_wgs);

%Shifts, rotations, scale
om_x = 4.9984/3600*pi/180;
om_y = 1.5867/3600*pi/180;
om_z = 5.2611/3600*pi/180;

m = 1-3.5623e-6;

dx = -570.8285;
dy = -85.6769;
dz = -462.8420;

%3D Helmert transformation: (X,Y,Z)_wgs -> (X,Y,Z)_bess
R = [1 om_z -om_y; -om_z 1 om_x; om_y -om_x 1];
XYZ_wgs = [X_wgs; Y_wgs; Z_wgs];
XYZ_shift = [dx; dy; dz];

XYZ_bes = m * R * XYZ_wgs + XYZ_shift;

X_bes = XYZ_bes(1);
Y_bes = XYZ_bes(2);
Z_bes = XYZ_bes(3);

%Parameters of Bessel
a_bes = 6377397.155;
b_bes = 6356078.963;
e2_bes = (a_bes^2 - b_bes^2) / a_bes^2;
 
%(X,Y,Z)_bess -> (phi, la)_bess
phi_bes = atan(Z_bes/((1-e2_bes)*sqrt(X_bes^2+Y_bes^2)));
la_bes = atan2(Y_bes, X_bes);

%Reduction to Ferro
la_fer = la_bes + (17 + (2/3))*pi/180;

%Constant values, Gaussian conformal projection
phi0 =  49.5 * pi/180;
alpha = sqrt(1 + e2_bes * (cos(phi0))^4 / (1 - e2_bes));
u0 = asin(sin(phi0)/alpha);
kn = (tan(phi0/2+pi/4))^alpha*((1-sqrt(e2_bes)*sin(phi0))/((1+sqrt(e2_bes)*sin(phi0))))^(alpha*sqrt(e2_bes)/2);
kd = (tan(u0/2+pi/4));
k = kn/kd;
R = (a_bes*sqrt(1-e2_bes))/(1-e2_bes*(sin(phi0))^2);

%Gaussian conformal projection
arg = 1/k * (tan(phi_bes/2 + pi/4) * ((1-sqrt(e2_bes)*sin(phi_bes))...
                                    /(1+sqrt(e2_bes)*sin(phi_bes)))^(sqrt(e2_bes)/2))^alpha
u = 2*(atan(arg) - pi/4);
v = alpha*la_fer;

%Transformation to oblique aspect
uk = (59+42/60+42.6969/3600) * pi/180; 
vk = (42+31/60+31.41725/3600) * pi/180;
[s, d] = uv_sd(u, v, uk, vk);

%LCC
s0 = 78.5 *pi/180;
Ro0 = 0.9999 * R*1/tan(s0);
c = sin(s0);

Ro = Ro0 * (tan(s0/2 + pi/4)/tan(s/2 + pi/4))^c;
eps = c*d;

%Transformation to Cartesian coordinates
x_jtsk = Ro*cos(eps);
y_jtsk = Ro*sin(eps);

%Local linear scale
m1 = c*Ro/(R*cos(s));

d_Ro = (Ro -Ro0)/100000
m2 = 0.9999 + 0.0012282*d_Ro^2 - 0.00000315*d_Ro^3 + 0.00000018*d_Ro^4;

%Convergence
c1 = 0.008257*y_jtsk/1000 + 2.373*(y_jtsk/x_jtsk)
ksi = asin(cos(uk)*sin(pi-d)/cos(u))
c2 = eps - ksi;

end

function [x_jtsk, y_jtsk] = besstojtsk(phi_bes, la_bes)
%Reduction to Ferro
la_fer = la_bes + (17 + (2/3))*pi/180;

%Parameters of Bessel
a_bes = 6377397.155;
b_bes = 6356078.963;
e2_bes = (a_bes^2 - b_bes^2) / a_bes^2;

%Constant values, Gaussian conformal projection
phi0 =  49.5 * pi/180;
alpha = sqrt(1 + e2_bes * (cos(phi0))^4 / (1 - e2_bes));
u0 = asin(sin(phi0)/alpha);
kn = (tan(phi0/2+pi/4))^alpha*((1-sqrt(e2_bes)*sin(phi0))/((1+sqrt(e2_bes)*sin(phi0))))^(alpha*sqrt(e2_bes)/2);
kd = (tan(u0/2+pi/4));
k = kn/kd;
R = (a_bes*sqrt(1-e2_bes))/(1-e2_bes*(sin(phi0))^2);

%Gaussian conformal projection
arg = 1/k * (tan(phi_bes/2 + pi/4) * ((1-sqrt(e2_bes)*sin(phi_bes))...
                                    /(1+sqrt(e2_bes)*sin(phi_bes)))^(sqrt(e2_bes)/2))^alpha
u = 2*(atan(arg) - pi/4);
v = alpha*la_fer;

%Transformation to oblique aspect
uk = (59+42/60+42.6969/3600) * pi/180; 
vk = (42+31/60+31.41725/3600) * pi/180;
[s, d] = uv_sd(u, v, uk, vk);

%LCC
s0 = 78.5 *pi/180;
Ro0 = 0.9999 * R*1/tan(s0);
c = sin(s0);

Ro = Ro0 * (tan(s0/2 + pi/4)/tan(s/2 + pi/4))^c;
eps = c*d;

%Transformation to Cartesian coordinates
x_jtsk = Ro*cos(eps);
y_jtsk = Ro*sin(eps);

%Local linear scale
m1 = c*Ro/(R*cos(s));

d_Ro = (Ro -Ro0)/100000
m2 = 0.9999 + 0.0012282*d_Ro^2 - 0.00000315*d_Ro^3 + 0.00000018*d_Ro^4;

%Convergence
c1 = 0.008257*y_jtsk/1000 + 2.373*(y_jtsk/x_jtsk)
ksi = asin(cos(uk)*sin(pi-d)/cos(u))
c2 = eps - ksi;
end



function [x_jtsk, y_jtsk] = spheretojtsk(u, v)
%Reduction to Ferro
v = v + (17 + (2/3))*pi/180;

%Transformation to oblique aspect
uk = (59+42/60+42.6969/3600) * pi/180; 
vk = (42+31/60+31.41725/3600) * pi/180;
[s, d] = uv_sd(u, v, uk, vk);

%LCC
s0 = 78.5 *pi/180;
Ro0 = 0.9999 * R*1/tan(s0);
c = sin(s0);

Ro = Ro0 * (tan(s0/2 + pi/4)/tan(s/2 + pi/4))^c;
eps = c*d;

%Transformation to Cartesian coordinates
x_jtsk = Ro*cos(eps);
y_jtsk = Ro*sin(eps);

%Local linear scale
m1 = c*Ro/(R*cos(s));

d_Ro = (Ro -Ro0)/100000
m2 = 0.9999 + 0.0012282*d_Ro^2 - 0.00000315*d_Ro^3 + 0.00000018*d_Ro^4;

%Convergence
c1 = 0.008257*y_jtsk/1000 + 2.373*(y_jtsk/x_jtsk)
ksi = asin(cos(uk)*sin(pi-d)/cos(u))
c2 = eps - ksi;
end
