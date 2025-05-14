clc
clear
hold on
axis equal

%Pole
uk = 28.190616490*pi/180; 
vk = 84.238229546*pi/180;
s0 = 1.52370116564608;
R = 1;

%Load points: Nepal
N = load ("nepal.txt");
u = N(:,1) * pi/180;
v = N(:,2) * pi/180;

%Convert to oblique aspect
[s, d] = uv_sd(u, v, uk, vk);

%Project Nepal
[xn, yn] = stereo(R, s, d, s0)
plot(xn, yn, 'b');

%Compute graticule
umin = 25*pi/180;
umax = 32*pi/180;
vmin = 72*pi/180;
vmax = 90*pi/180;
Du = 1*pi/180;
Dv = 1*pi/180;
du = 0.1*pi/180;
dv = 0.1*pi/180;

proj = @stereo

[XM, YM, XP, YP] = graticule(umin, umax, vmin, vmax, u, Dv, du, dv, R, uk, vk, s0, proj);
plot(XM', YM', 'k');    
plot(XP', YP', 'k');

%Mesh grid
[ug, vg] = meshgrid(umin:du:umax, vmin:dv:vmax);

%Convert to oblique aspect
[sg, dg] = uv_sd(ug, vg, uk, vk);

%Project meshgrid
[xg, yg] = stereo(R, sg, dg, s0);
%plot(xg, yg, 'o');

%Local linear scale
psig = pi/2 - sg;
psi0 = pi/2 - s0;
m = cos(psi0/2)^2./(cos(psig/2).^2);

%Distortion
mju = m-1;

%Distortions per km
mju_km = mju*1000;

%Contour lines
dz = 0.1;
[C, h] = contour(xg, yg, mju_km,[-20:dz:100], 'LineColor', 'r');
clabel(C, h,'Color', 'red');


