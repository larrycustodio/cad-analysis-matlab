clc;clear;close all;
%Lawrence Custodio
%Homework 5 Problem 3
%Parameters: 
n=7; % # Nodes
N=2*n; %Global Matrix size
E=200e9;  %E-modulus
A=10e-4; %Area at d=5cm
L = ones(1,11); %Element lengths
kcons = (A*E)*(L.^-1); %Material property
%Angles for respective elements:
beta = [0 0 60 180 180 60 120 60 120 60 120];
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
elseif m ==4 %For element 4
    kind4 = Ke;
elseif m ==5 %For element 5
    kind5 = Ke;
end
%Allocate nodes to elements:
low = [1 2 3 4 5 5 4 1 2 2 3]; %i-node
high = [2 3 4 5 6 7 7 6 6 5 5]; %j-node
i = low(m);
j = high(m);
%Auxiliary matrix: contribution of individual stiffness matrices to Kg 
Kt = zeros(N,N); 
Kt([2*i-1 2*i 2*j-1 2*j],[2*i-1 2*i 2*j-1 2*j]) = Ke(1:4,1:4);
Kg = Kg+Kt;
end
%Calculation of reaction forces + displacements 
P1 = 10000;
P2 = P1;
Fa = zeros(N,1);
Fa(2) = -P1;
Fa(13) = -P2; %Overall force vector
F = Fa;
F(5:7) = []; %Reduced force vector
noKg = Kg; 
noKg(5:7,:)=[];
noKg(:,5:7)=[];%Reduced global matrix
d = noKg\F;
dall = zeros(N,1);
dall(1:4)=d(1:4);
dall(5:7) = 0;
dall(8:14) = d(5:11);%expanded displacement vector
RF = (Kg*dall)-Fa; %reaction forces
dmag= dall*200; %Scaled displacement for visibility
%Defining truss structure: A = Node[1], B =Node[2],etc.
A = [0,0]; %Node 1
dA= A + [dmag(1) dmag(2)]; %displacement @ Node 1
B = [1,0]; %Node 2
dB = B + [dmag(3) dmag(4)];
C = [2,0]; %Node 3
dC = C + [dmag(5) dmag(6)];
D = C+[cosd(60),sind(60)]; %Node 4
dD = D + [dmag(7) dmag(8)]; %displacement @ Node 4
E = D-[1,0]; %Node 5
dE = E +[dmag(9) dmag(10)];
F = E-[1,0]; %Node 6
dF = F +[dmag(11) dmag(12)];
G = E+[cosd(60),sind(60)]; %Node 7
dG = G + [dmag(13) dmag(14)]; %displacement @ Node 7
%Original truss positions
%Elements 1-5:
x = [A(1) B(1) C(1) D(1) E(1) F(1)];
y = [A(2) B(2) C(2) D(2) E(2) F(2)];
plot(x,y,'linewidth',2);
hold on
%Elements 6 and 7:
x1 = [E(1) G(1) D(1)];
y1 = [E(2) G(2) D(2)];
plot(x1,y1,'linewidth',2);
%Elements 8-11:
x2 = [A(1) F(1) B(1) E(1) C(1)];
y2 = [A(2) F(2) B(2) E(2) C(2)];
plot(x2,y2,'linewidth',2);

%Displacements:
%Elements 1-5:
x = [dA(1) dB(1) dC(1) dD(1) dE(1) dF(1)];
y = [dA(2) dB(2) dC(2) dD(2) dE(2) dF(2)];
plot(x,y,'r','linewidth',2);
%Elements 6 and 7:
xd1 = [dE(1) dG(1) dD(1)];
yd1 = [dE(2) dG(2) dD(2)];
plot(xd1,yd1,'r','linewidth',2)
%Elements 8-11:
xd2 = [dA(1) dF(1) dB(1) dE(1) dC(1)];
yd2 = [dA(2) dF(2) dB(2) dE(2) dC(2)];
plot(xd2,yd2,'r','linewidth',2)
grid on
axis equal
title('Truss Structure Deformation Scale Factor =200')
