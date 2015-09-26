clc;clear;close all;
%Given parameters
%NOTE: units in degrees(beta and theta-interval) are converted to rad
beta = 90*pi/180; %radians
d= 15; %mm
theta=1:1:90;
trad=theta.*pi/180; %in radians
%Components of displacement equation:
i=(10/(beta^3))*(trad.^3);
ii=(15/(beta^4))*(trad.^4);
iii=(6/(beta^5))*(trad.^5);
%Displacement equation:
y = d*(i-ii+iii);

ome=1; %Given value for omega
%Components of velocity equation:
di=((30*ome)/(beta^3))*(trad.^2);
dii=((60*ome)/(beta^4))*(trad.^3);
diii=((30*ome)/(beta^5))*(trad.^4);
%Velocity equation:
dy = d*(di-dii+diii);

%Components of acceleration equation:
d2i=((60*ome^2)/(beta^3))*(trad);
d2ii=((180*ome^2)/(beta^4))*(trad.^2);
d2iii=((120*ome^2)/(beta^5))*(trad.^3);
%Acceleration equation:
d2y = d*(d2i-d2ii+d2iii);

%Plotting
plot(trad,y)
hold on
plot(trad,dy,'r--')
plot(trad,d2y,'g-.')
xlabel('Cam angle(rad)')
legend('Displacement','Velocity','Acceleration')