clc
clear
hold on
axis equal

%Set Python interpreter
pyenv(Version="C:\Program Files\Python312\python.exe");

%Projection properties
proj_name = 'sinu'
R = 6380000;

%Analyzed territory
umin = -80*pi/180;
umax = 80*pi/180;
vmin = -180*pi/180;
vmax = 180*pi/180;
Du = 10*pi/180;
Dv = 10*pi/180;
du = 0.1 * Du;
dv = 0.1 * Dv;

%Mesh grid
[ug, vg] = meshgrid(umin:du:umax, vmin:dv:vmax);

%Test: project + extract arrays from tuple and convert to matrix
vals = py.mk.project(proj_name, R, ug, vg)
x = double(vals{1});
y = double(vals{2});
a = double(vals{3});
b = double(vals{4});


%Airy Criterium 
h2a = ((a - 1).^2 + (b-1).^2)/2

%Airy complex criterium
h2c = (abs(a-1)+abs(b-1))/2+a/b-1





