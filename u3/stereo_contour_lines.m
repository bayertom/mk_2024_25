clc
clear

%Pole
uk = 28.190616490*pi/180; 
vk = 84.238229546*pi/180;

%Load points: Nepal
N = load ("nepal.txt");
u = N(:,1) * pi/180;
v = N(:,2) * pi/180;

%Convert to oblique aspect
[s, d] = uv_sd(u, v, uk, vk);

%Project Nepal

%Compute graticule



