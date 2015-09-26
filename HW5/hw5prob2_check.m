%Lawrence Custodio
%Homework 5 Problem 2
%Given parameters: E-modulus, lengths, area
clc;clear all;close all;
E=210e9;
L1=1;
L2=L1;
L3=sqrt(2);
A=pi*(5e-2/2)^2;
k1 = (A*E)/L1;
k2 = (A*E)/L2;
k3 = (A*E)/L3;
%Individual stiffness matrices:
kmx = @(b) [(cosd(b)).^2 sind(b)*cosd(b) -(cosd(b)).^2 -sind(b)*cosd(b);
        sind(b)*cosd(b) (sind(b)).^2 -sind(b)*cosd(b) -(sind(b)).^2;
        -(cosd(b)).^2 -sind(b)*cosd(b) (cosd(b)).^2 sind(b)*cosd(b);
        -sind(b)*cosd(b) -(sind(b)).^2 sind(b)*cosd(b) (sind(b)).^2];
ksol1=k1*kmx(0); %element 1 stiffness matrix
ksol2=k2*kmx(90); %element 2 stiffness matrix
ksol3=k3*kmx(45); %element 3 stiffness matrix
%Overall stiffness matrix
kall = zeros(6,6);
%Add stiffness matrix 1:
kall(1:4,1:4) = ksol1;
%Add stiffness matrix 2:
kall(3:6,3:6) = kall(3:6,3:6)+ksol2;
%Add stiffness matrix 3:
kall(1:2,1:2) = kall(1:2,1:2)+ksol3(1:2,1:2);
kall(1:2,5:6) = kall(1:2,5:6)+ksol3(1:2,3:4);
kall(5:6,1:2) = kall(5:6,1:2)+ksol3(3:4,1:2);
kall(5:6,5:6) = kall(5:6,5:6)+ksol3(3:4,3:4);
%Solve for displacementss
%Display matrices in Command Window:
fprintf('k1 =');
disp(ksol1);
fprintf('k2 =');
disp(ksol2);
fprintf('k3 =');
disp(ksol3);
fprintf('Global stiffness Matrix K');
disp(kall);
