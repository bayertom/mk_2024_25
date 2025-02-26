clc
clear

%Function, quadratic equaation
a= 1; b = 2; c=1;
[x1, x2] = quad(a, b, c)

%Function, factorial
n = 10;
fn = factorial2(n)

%Function, transformation to oblique aspect
u = 50, v = 15, uk = 60, vk = 20;
ur = u*pi/180, vr = v*pi/180, ukr = uk*pi/180, vkr = vk*pi/180;
[sr,dr]=uv_sd(ur,vr,ukr,vkr);
s = sr*180/pi;
d = dr*180/pi;


function [x1, x2] = quad(a, b, c)
    %Quadratic equation
    D = b^2 - 4 * a *c;

    %2 roots
    if D > 0
        x1 = (-b + sqrt(D))/(2*a)
        x2 = (-b - sqrt(D))/(2*a)
    
    %1 root
    elseif D == 0
        x1 = (-b )/(2*a)
        x2 = x1
    
    %No solution in R
    else
        disp('No solution in r')
    end
end

function [fn] = factorial(n)
    %Factorial
    fn = 1
    while n > 1
        fn = fn * n
        n = n-1
    end
end

function [fn] = factorial2(n)
    %Factorial, for
    fn = 1
    for i = n:-1:2
        fn = fn * i
    end
end


function [s, d] = uv_sd(u, v, uk, vk)
    %[u,v] -> [s,d]
    arg=sin(u)*sin(uk)+cos(u)*cos(uk)*cos(vk-v);
    s=asin(arg);
    arg2 = sin(vk-v)*cos(u)/cos(s);
    d = asin(arg2);
end

