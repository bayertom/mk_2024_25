clc
clear

%Input parameters
umin = 60 *pi/180;
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

proj = @gnom;
u0 = 0;

%Create graticule
[XM, YM, XP, YP] = graticule(umin, umax, vmin, vmax, Du, Dv, du, dv,...
                                    R, uk, vk, u0, proj);
%Plot results
hold on;
plot(XM', YM', 'k');
plot(XP', YP', 'k');
axis equal

%Draw continent
s0 = 0;
file = 'v:\Bayer\mk_2024_25\u2\continents_points\eur.txt';
[XC,YC] = continent(R, uk, vk, s0, proj, file);
plot(XC, YC, 'b');

