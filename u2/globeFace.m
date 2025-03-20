function [] = globeFace(umin, umax, vmin, vmax, Du, Dv, du, dv,...
                                    R, uk, vk, s0, proj, file, ub, vb)
%Create graticule
[XM, YM, XP, YP] = graticule(umin, umax, vmin, vmax, Du, Dv, du, dv,...
                                    R, uk, vk, s0, proj);
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

%Draw boundary (cutting lines)
[XB,YB] = boundary(R, uk, vk, s0, proj, ub, vb);
plot(XB, YB, 'r');