function [s, d] = uv_sd_bad(u, v, uk, vk)
    %[u,v] -> [s,d]
    arg=sin(u)*sin(uk)+cos(u)*cos(uk)*cos(vk-v);
    s=asin(arg);
    arg2 = sin(vk-v)*cos(u)/cos(s);
    d = asin(arg2);
end