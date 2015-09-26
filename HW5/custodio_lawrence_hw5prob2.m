clc;clear;close all;
%Lawrence Custodio
%Homework 5 Problem 2
%Given parameters: 
n=3; %Number of Nodes
N=2*n; %Global Matrix size
E=210e9;  %E-modulus
A=pi*(5e-2/2)^2; %Area at d=5cm
L = [1 1 sqrt(2)]; %Lengths of respective element
kcons = (A*E)*(L.^-1); %Material property
%Angles for respective elements:
beta = [0 90 45];
s = sind(beta);
c = cosd(beta);
Kg = zeros(N,N); %Preallocate global stiffness matrix
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
high = [2 3 3]; %j-node
i = low(m);
j = high(m);
%Auxiliary matrix: contribution of individual stiffness matrices to Kg 
Kt = zeros(N,N); 
Kt([2*i-1 2*i 2*j-1 2*j],[2*i-1 2*i 2*j-1 2*j]) = Ke(1:4,1:4);
Kg = Kg+Kt;
end
%forces
P = 25e3; %Applied force
Fall = [0 0 0 0 -P 0]'; %Force vector
F = Fall([1 5 6]); %Reduced force vector
%displacements
noKg = Kg([1 5 6],[1 5 6]); %reduced global stiffness matrix
d = noKg\F;
dall = zeros(N,1); %expanded displacement vector to calculate reaction forces
dall([1 5 6]) = d;
dmag= d*200; %Scaled displacement for visibility
RF = (Kg*dall)-Fall; %reaction forces
%Define truss structure
A = [1,1];
B = [2,1];
C = [2,2];
x = [A(1) B(1) C(1) A(1)];
y = [A(2) B(2) C(2) A(2)];
plot(x,y,'linewidth',2)
hold on
%Displacement vectors:
dA = [A(1)+dmag(1),A(2)];
dB = [B(1),B(2)];
dC = [C(1)+dmag(2),C(2)+dmag(3)];
xd = [dA(1) dB(1) dC(1) dA(1)];
yd = [dA(2) dB(2) dC(2) dA(2)];
plot(xd,yd,'r--','linewidth',2)
axis ([0.5 2.5 0.5 2.5])
grid on
title('HW 5 Problem 2: Truss Structure')
legend('Original','Deformed (scaled by a factor of 200')