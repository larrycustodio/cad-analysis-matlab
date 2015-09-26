clc;clear all;close all;
%Lawrence Custodio
%Homework 5 Problem 2
%Given parameters: 
n=3; %Number of Elements
N=2*n; %Global Matrix size
E=180e9;  %E-modulus
A=pi*(20e-3/2)^2; %Area at d=5cm
L = [sqrt(2) 1 1]; %Lengths of respective element
kcons = (A*E)*(L.^-1); %Material property
%Angles for respective elements:
beta = [45 0 90];
s = sind(beta);
c = cosd(beta);
Kg = zeros(6,6); %Preallocate global stiffness matrix
%Calculation of stiffness matrix:
for m = 1:length(L)
%General stiffness matrix Ke:
kmx=[(c(m))^2 c(m)*s(m) -(c(m))^2 -c(m)*s(m);
    c(m)*s(m) (s(m))^2 -c(m)*s(m) -(s(m))^2;
    -(c(m))^2 -c(m)*s(m) (c(m))^2 c(m)*s(m);
    -c(m)*s(m) -(s(m))^2 c(m)*s(m) (s(m))^2];
Ke=kcons(m)*kmx;
%Individual stiffness matrices:
if m ==1 %For element 1
    kind1 = Ke;
elseif m ==2 %For element 2
    kind2 = Ke;
elseif m ==3 %For element 3
    kind3 = Ke;
end
%Allocate nodes to elements:
low = [1 2 1]; %i-node
high = [3 3 2]; %j-node
i = low(m);
j = high(m);
%Auxiliary matrix: contribution of individual stiffness matrices to Kg 
Kt = zeros(N,N); 
Kt([2*i-1 2*i 2*j-1 2*j],[2*i-1 2*i 2*j-1 2*j]) = Ke(1:4,1:4);
Kg = Kg+Kt;
end
%forces
P = 50e3; %Applied force
F = [0 0 0 0 0 -P]';
%displacements
d = inv(Kg)*F;
%Plotting
%Define truss structure
A = [1,1];
B = [1,2];
C = [2,2];
x = [A(1) B(1) C(1) A(1)];
y = [A(2) B(2) C(2) A(2)];
plot(x,y)
axis ([0.5 2.5 0.5 2.5])
title('HW 5 Problem 2: Truss "Warm up"')
hold on
%Displacement vectors:
dA = [A(1)+d(1),A(2)+d(2)];
dB = [B(1)+d(3),B(2)+d(4)];
dC = [C(1)+d(5),C(2)+d(6)];
xd = [dA(1) dB(1) dC(1)];
yd = [dA(2) dB(2) dC(2)];
plot(xd,yd,'r')