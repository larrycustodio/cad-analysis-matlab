%HW 4 Problem 2 EC
clc; clear; close all;
load('phi.mat');
load('Y.mat');
%Given Parameters:
y = Y(:,1).*1000; %displacement [mm]
theta = (0:360)'*(pi/180); %cam angle [rad]
rbase = 35; %Radius of base circle [mm]
Rr = 10; %Radius of follower [mm]
Ro = rbase+Rr; %Radius of prime circle [mm]
%Part A:
%Pitch curve (black + dashed line)
xp = (Ro+y).*sin(theta);
yp = (Ro+y).*cos(theta);
pitch = [xp';yp';ones(1,length(xp))];
%Cam contour (red + line width 3)
xcp = Rr*sin(theta-phi); 
ycp = Rr*cos(theta-phi);
xc = xp -xcp;
yc = yp -ycp;
cont = [xc';yc';ones(1,length(xc))]; %cam contour matrix
%Base circle (blue)
xbase = rbase.*cos(theta);
ybase = rbase.*sin(theta);
%Define intervals of rotation per frame: 10 degrees
deg = [0:10:360]*pi/180; %[rad]
%Animation loop: pitch curve and cam contour rotation
for i=1:length(deg)
ccw = [cos(deg(i)) -sin(deg(i)) 0; sin(deg(i)) cos(deg(i)) 0; 0 0 1];
cp = ccw*pitch;
cc = ccw*cont;
plot(xbase,ybase,'b')
axis([-80 80 -80 80])
hold on
plot(cp(1,:),cp(2,:),'k--') %pitch curve
plot(cc(1,:),cc(2,:),'r','linewidth',3) %cam contour
title ('Extra Credit')
xlabel('x[mm]')
ylabel('y[mm]')
ec(i)=getframe; %Record frame for animation
set(gca,'NextPlot','replaceChildren'); %clear current frame for succeeding frame
end
reps = 1;
movie(ec,reps) %preview in matlab
movie2avi(ec, 'custodio_lawrence_hw4_extracredit.avi') %save to avi file