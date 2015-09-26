%CAM Design
clc; clear; close all;

L =20; %Given length of rise +fall
w = 600; %rotational speed

%Harmonic Rise
t1 = (0:120)*pi/180; %Range of Harmonic Rise (rad)
b1 = t1(end)-t1(1); %Beta value
y1 = (L/2)*(1-cos((pi*t1)/b1)); %Displacement
y1dt = (0.5*pi*L*w*b1)*sin((pi*t1)/b1);%Velocity 
y1dt2 = (L/2)*((pi*w/b1)^2)*cos(pi*t1/b1); %Acceleration

%Dwell
t2 = (120:180)*pi/180; %Range of Dwell (rad)
y2 = 20*ones(1,length(t2)); %Horizontal line describing dwell
y2dt = zeros(1,length(t2)); %Zero velocity for dwell
y2dt2 = zeros(1,length(t2));

%345 Poly Fall
t3 = (0:90)*pi/180; %Range of fall (rad)
b3 = t3(end)-t3(1); %Beta for poly 345 fall
y3 = L-L*(10*(t3/b3).^3 - 15*(t3/b3).^4 + 6*(t3/b3).^5); %Displacement
y3dt = L-L*((30*w/b3^3)*t3.^2 - (60*w/b3^4)*t3.^3  + (30*w/b3^5)*t3.^4 ); %Velocity
y3dt2 = L-L*((60*w^2/b3^3)*t3 - (180*w^2/b3^4)*t3.^2  + (120*w^2/b3^5)*t3.^3); %Acceleration

%Dwell
t4 = (270:360)*pi/180;
y4 = zeros(1,length(t4));
y4dt = zeros(1,length(t4)); %Zero velocity for dwell
y4dt2 = zeros(1,length(t4));

%Graphing:
%Respective ranges for angles are converted in degrees:
tt = 0:120; %Harmonic Rise
tt2 = 120:180; %Dwell
tt3 = 180:270; %345 Poly Fall
tt4 = 270:360; %Dwell
t = [tt tt2 tt3 tt4]; %Angles
disp = [y1 y2 y3 y4]; %Displacement values
vel = [y1dt y2dt y3dt y4dt]; %Velocity
acc = [y1dt2 y2dt2 y3dt2 y4dt2]; %Acceleration
subplot(311)
plot(t,disp)
title('Displacement Profile ')
ylabel('Displacement[mm]')
xlim([0 360]);
ylim([0 30]);
subplot(312)
plot(t,vel)
title('Velocity Profile')
ylabel('Velocity [mm/s]')
xlim([0 360]);
subplot(313)
plot(t,acc)
title('Acceleration Profile')
xlabel('Cam angle [\theta]')
ylabel('Acceleration[mm/s^2]')
xlim([0 360]);

%Part B: Pressure angle
phi = atan((vel./w)./(35+disp)); %Pressure angle formula
phid = phi*180/pi; %Pressure angle values to degrees
figure
plot(t,phid)
title('CAM Pressure angle')
xlabel('CAM Angle [\theta]')
ylabel('Pressure Angle \phi[deg]')

%Table values for every 30 deg:
x = [t(1) t(31) t(61) t(91) t(121) t(152) t(182) t(213) t(243) t(273) t(304) t(334) t(364)]; % Selected angle values
pa = [phid(1) phid(31) phid(61) phid(91) phid(121) phid(152) phid(182) phid(213) phid(243) phid(273) phid(304) phid(334) phid(364)]; %Pressure angle values
table=[x;pa]