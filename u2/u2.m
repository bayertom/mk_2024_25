clc
clear

%Common parameters
file = 'v:\Bayer\mk_2024_25\u2\continents_points\eur.txt';
proj = @gnom;
s0 = 0;

%Face 1
%Input parameters

%Graticule
umin = 30 *pi/180;
umax = pi/2;
vmin = 0;
vmax = 2*pi;
Du = 10*pi/180;
Dv = Du;
du = pi/180;
dv = du;
R = 6371.1 * 1000;
uk = pi/2;
vk = 0;

%Boundary points
us=35.2644*pi/180;
uj=-us;
ub = [us, us , us, us];
vb =[0, pi/2, pi, 3/2*pi];

%Globe face
globeFace(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, s0, proj, file, ub, vb)