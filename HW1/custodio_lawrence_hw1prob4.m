%Lawrence Custodio
%HW 1 Problem 4
clc; clear all; close all;
%Given coordinates:
A = [0;0];
B = [2;2*sqrt(3)];
C = [0;9];
D = [-2;2*sqrt(3)];
x0=[A(1),B(1),C(1),D(1),A(1)];
y0=[A(2),B(2),C(2),D(2),A(2)];
%In Matrix Form:
init = [x0;y0;ones(1,length(x0))];

%Part1, Figure 1: Initial Shape
plot(x0,y0)
title('Figure 1 - Initial Shape');
xlabel('x');ylabel('y');

%For figure 2:
figure
plot(x0,y0);hold on
title('Figure 2 - Complete Snowflake');
xlabel('x');ylabel('y');
axis equal;

%Parts 2-4: Defining "Upper Half" - X1 and X2
theta = (60*pi)/180;
RCW = [cos(theta) sin(theta) 0;
        -sin(theta) cos(theta) 0;
        0 0 1]; %60deg CounterCW
RCCW = [cos(theta) -sin(theta) 0;
       sin(theta) cos(theta) 0;
        0 0 1]; %60deg CW
    
%X1 - CounterClockwise 60deg
X1matrix = RCCW*init;
X1x = X1matrix(1,:);
X1y = X1matrix(2,:);

%X2 - CW 60deg
X2matrix = RCW*init;
X2x = X2matrix(1,:);
X2y = X2matrix(2,:);

plot(X1x,X1y);
plot(X2x,X2y);

%Parts 5-6: Lower half, reflect on x-axis
refx = [1 0 0; 
        0 -1 0; 
        0 0 1];%x-axis reflect matrix
    
%Reflect the original figure
ref0 =  refx*init;
ref0x = ref0(1,:);
ref0y = ref0(2,:);

%Reflect X1
ref1 = refx*X1matrix;
ref1x = ref1(1,:);
ref1y = ref1(2,:);

%Reflect X2
ref2 = refx*X2matrix;
ref2x = ref2(1,:);
ref2y = ref2(2,:);

plot(ref0x,ref0y);
plot(ref1x,ref1y);
plot(ref2x,ref2y);

%Part 7: Scaling
scale = 0.7;
scx = [scale 0 0;
        0 scale 0;
        0 0 1];

%Original
s0 = scx*init;
s0x = s0(1,:);
s0y = s0(2,:);
plot(s0x,s0y);

%X1 and X2
s1 = scx*X1matrix;
s1x = s1(1,:);
s1y = s1(2,:);
plot(s1x,s1y);

s2 = scx*X2matrix;
s2x = s2(1,:);
s2y = s2(2,:);
plot(s2x,s2y);

%Reflections
s3 = scx*ref0;
s3x = s3(1,:);
s3y = s3(2,:);
plot(s3x,s3y)

s4 = scx*ref1;
s4x = s4(1,:);
s4y = s4(2,:);
plot(s4x,s4y)

s5 = scx*ref2;
s5x = s5(1,:);
s5y = s5(2,:);
plot(s5x,s5y)
