%Lawrence Custodio MAE 150 HW 6 Problem 3
clc;clear all;close all;
%Given dimensions:
L = 11.8e-3;    %Length    
L1 = 0.2*L;     %length, unflanged
L1u = L1/10;    %unit length, unflanged
L2 = L-L1;      %length, flanged
L2u = L2/10;    %unit length, flanged
B = 3.5e-3;     %Base width
b = 1e-3;       %Tip width
t = 80e-6;      %beam thickness
P = 20e-3;      %load P @ x=L
E = 200e9;      %Modulus
h = .8e-3;      %flange height
%Formulating array w containing width for each respective node:
%Nodes at unflanged region:
for node = 1:11 
    x(node) = (node-1)*(L1u);
end
%Nodes at flanged region:
for node = 12:21 
    x(node) = x(11)+ (node-11)*(L2u);
end
%Equation for width on node x:
width = ((b-B)*(x))/L + B;

%Area moment of inertia, J of nodes at centroid
%Unflanged:
for i = 1:11
    J(i) = (width(i)*t^3)/12; 
end
%Flanged:
for i = 12:21
    A(i-11) = ((width(i)-t)*t) + h*t; %Area of cross section
    ybar(i-11) = (1/A(i-11))*((width(i)-t)*t*.5*t + t*h*.5*h);%Centroidal axis;
    Jc(i-11) = (((width(i)-t)*t^3)/3) + ((t*h^3)/3); %Area moment
    J(i) = Jc(i-11) - (((ybar(i-11))^2) * A(i-11)); %Area moment at centroidal axis
end

%Area moment at elements == average(prior+after)
for step = 1:20 %20 elements total
    Jmean(step) = (J(step)+J(step+1))/2;
end

%FEA for nodal forces + displacements
%unflanged region
Kg = zeros(42,42); %Global stiffness matrix: size =21 nodes * 2DOF
for step = 1:20
    %individual stiffness matrix kmx
    %L will vary for unflanged-flanged
    if (step<=11)
        LL = L1u;
    else
        LL = L2u;
    end
    kmx = ((E*Jmean(step))/LL^3) * [12 6*LL -12 6*LL; 
        6*LL 4*LL^2 -6*LL 2*LL^2; -12 -6*LL 12 -6*LL; 
        6*LL 2*LL^2 -6*LL 4*LL^2];
    Kt = zeros(42,42); %Auxiliary Matrix
    Kt(2*step-1:2*step+2,2*step-1:2*step+2) = kmx;
    Kg = Kg+Kt;
end
%Forces
Fall = zeros(42,1); %Force vector
Fall(41) = -P;
F = Fall(3:42); %Reduced; Apply BCs: F1->F=0 and F2->M=0
%Net displacement, disp = reduced Kg\F
disp = zeros(42,1);
disp (3:42) = Kg(3:42,3:42)\F;
FR = Kg*disp;%Reaction forces
%Deflection, w and rotation, theta
%Odd components denote deflection; evens = rotation
for def=1:21
    odd = 2*def-1;
    even = 2*def;
    w(def) = disp(odd);
    theta(def) = disp(even);
end
%Bending moments: L*theta
for n=1:21
bend(n) = x(n)*theta(n);
end

%Plotting
%Bending moment
plot(x,bend,'.-')
title('Bending moment vs. Length')
xlabel('Length[m]')
ylabel('Bending moment [Nm]')
%Area moment of inertia
figure
plot(x,J,'.-')
title('Area Moment of Inertia vs. Length')
xlabel('Length [m]')
ylabel('Area moment [m^4]')
%Deflection
figure
plot(x,w,'.-')
title('Deflection vs. Length')
xlabel('Length [m]')
ylabel('Deflection [m]')
%Rotation Angle
figure
plot(x,theta,'.-')
title('Rotation Angle vs. Length')
xlabel('Length [m]')
ylabel('Rotation Angle[rad]')
