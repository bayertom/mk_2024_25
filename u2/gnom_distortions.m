clc
clear
format long g

%Define symbolic variables
syms R u v

%Projection equations
x = R*tan(pi/2-u)*cos(v);
y = R*tan(pi/2-u)*sin(v);

%Partial derivatives
fu = diff(x, u);
fv = diff(x, v);
gu = diff(y, u);
gv = diff(y, v);

%Simplify equations
fu = simplify(fu, 'Steps', 20);
gu = simplify(gu, 'Steps', 20);

%Local linear scales
mp2 = (fu^2+gu^2)/R^2;
mp2 = simplify(mp2);
mr2 = (fv^2 + gv^2) / (R^2 *cos(u)^2);
mr2 = simplify(mr2, 'Steps', 10);
p = 2*(fu*fv+gu*gv);

%Angle between meridian and parallel
omega = atan((gu*fv - gv *fu)/p/2);
omega = simplify(omega,"Steps", 30);

%Area scale
P = (gu*fv - fu*gv)/(R^2 * cos(u));
P = simplify (P, 'Steps', 20);

% Meridian convergence
sigma = atan(gu/fu);
sigma = simplify (sigma, 'Steps', 50);
c = pi/2 - sigma;

%Extreme azimuths
A = atan2(p, mp2-mr2);
A = simplify (A, 'Steps', 50);

%Numeric computations
un = 35.2644;
vn = 0;
Rn = 1 * 1000;

%Coordinates
xn = double(subs(x, {R, u, v}, {Rn, un, vn}))
yn = double(subs(y, {R, u, v}, {Rn, un, vn}))

%Local linear scales
mpn = sqrt(double(subs(mp2, {R, u, v}, {Rn, un, vn})))
mrn = sqrt(double(subs(mr2, {R, u, v}, {Rn, un, vn})))
pn = double(subs(p, {R, u, v}, {Rn, un, vn}))

%Angle between meridian and parallel
omegan = double(subs(omega, {R, u, v}, {Rn, un, vn}))

%Area scale
Pn = double(subs(P, {R, u, v}, {Rn, un, vn}));

%Meridian convergence
cn = double(subs(c, {R, u, v}, {Rn, un, vn}));

%Extreme azimuths
A1n = double(subs(A, {R, u, v}, {Rn, un, vn}));
