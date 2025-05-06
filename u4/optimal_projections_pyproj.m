clc
clear
hold on
axis equal

%Set Python interpreter
pyenv(Version="C:\Program Files\Python311\python.exe");

%Projection properties
proj_name = 'sinu'
R = 6380000;

%Test: project + extract arrays from tuple and convert to matrix
vals = py.mk.project(proj_name, R, u, v)
x = double(vals{1});
y = double(vals{2});
a = double(vals{3});
b = double(vals{4});
