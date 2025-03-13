clc
clear

%Pole
uk = 50
vk = 15

ukr = uk*(pi/180)
vkr = vk*(pi/180)

%1st quadrant
u1 = 40
v1 = 10

u1r = u1*(pi/180)
v1r = v1*(pi/180)

[s1r, d1r] = uv_sd(u1r, v1r, ukr, vkr)
s1 = s1r*(180/pi)
d1 = d1r*(180/pi)

[s1rb, d1rb] = uv_sd_bad(u1r, v1r, ukr, vkr)
s1b = s1rb*(180/pi)
d1b = d1rb*(180/pi)


%2nd quadrant
u2 = 60
v2 = 10

u2r = u2*(pi/180)
v2r = v2*(pi/180)

[s2r, d2r] = uv_sd(u2r, v2r, ukr, vkr)
s2 = s2r*(180/pi)
d2 = d2r*(180/pi)

[s2rb, d2rb] = uv_sd_bad(u2r, v2r, ukr, vkr)
s2b = s2rb*(180/pi)
d2b = d2rb*(180/pi)


%3rd quadrant
u3 = 60
v3 = 20

u3r = u3*(pi/180)
v3r = v3*(pi/180)

[s3r, d3r] = uv_sd(u3r, v3r, ukr, vkr)
s3 = s3r*(180/pi)
d3 = d3r*(180/pi)+360

[s3rb, d3rb] = uv_sd_bad(u3r, v3r, ukr, vkr)
s3b = s3rb*(180/pi)
d3b = d3rb*(180/pi)

%4th quadrant
u4 = 40
v4 = 20

u4r = u4*(pi/180)
v4r = v4*(pi/180)

[s4r, d4r] = uv_sd(u4r, v4r, ukr, vkr)
s4 = s4r*(180/pi)
d4 = d4r*(180/pi)+360

[s4rb, d4rb] = uv_sd_bad(u4r, v4r, ukr, vkr)
s4b = s4rb*(180/pi)
d4b = d4rb*(180/pi)



