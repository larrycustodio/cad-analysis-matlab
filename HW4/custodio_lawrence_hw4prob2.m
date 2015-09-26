%Lawrence Custodio
%HW 4 Problem 2
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
plot(xp,yp,'k--');
hold on
%Cam contour (red + line width 3)
%Cam contact point rel. to pitch curve: xcp, ycp
xcp = Rr*sin(theta-phi); 
ycp = Rr*cos(theta-phi);
%Cam contour defined as difference of pitch curve and contact point:
xc = xp -xcp;
yc = yp -ycp;
plot(xc,yc,'r','linewidth',3);
%Base circle (blue)
xbase = rbase.*cos(theta);
ybase = rbase.*sin(theta);
plot(xbase,ybase,'b')
%Plot labelling
axis equal
title ('Fig.1: Cam Design')
xlabel('x [mm]')
ylabel('y [mm]')
legend('Pitch curve','Cam Contour','Base Circle');

%Part B:
alpha = (0:30:330)*pi/180; %Degrees of rotation;
%Matrix describing base circle + cam contour coordinates
base = [xbase';ybase';ones(1,length(xbase))]; %base circle
cont = [xc';yc';ones(1,length(xc))]; %cam contour

%rotation transformation matrices:
%First figure: 0-150 degrees
figure
for j=1:1:6
    ccw = [cos(alpha(j)) -sin(alpha(j)) 0; sin(alpha(j)) cos(alpha(j)) 0; 0 0 1]; % Transformation Matrix
    baset = ccw*base; %Transformed matrix, base circle
    camt = ccw*cont; %Transformed matrix, cam contour
    %Plotting + Labels
    subplot(2,3,j)
    plot(baset(1,:),baset(2,:))
    hold on
    plot(camt(1,:),camt(2,:),'r','linewidth',3)
    xlabel('x [mm]')
    ylabel('y [mm]')
    grid on
    axis equal
    title(['\theta= ' num2str(alpha(j)*(180/pi))])
end

%Second figure: 180-330 degrees
figure
for m=7:1:12
    ccw = [cos(alpha(m)) -sin(alpha(m)) 0; sin(alpha(m)) cos(alpha(m)) 0; 0 0 1];
    baset = ccw*base;
    camt = ccw*cont;
    subplot(2,3,(m-6))
    plot(baset(1,:),baset(2,:))
    hold on
    plot(camt(1,:),camt(2,:),'r','linewidth',3)
    xlabel('x [mm]')
    ylabel('y [mm]')
    grid on
    axis equal
    title(['\theta= ' num2str(alpha(m)*(180/pi))])
end