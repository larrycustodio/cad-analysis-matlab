%Lawrence Custodio
%HW 1 Problem 4 - extraredit
clc; clear all; close all;
%Given coordinates:
A = [0;0];
B = [4*cos(54*pi/180);4*sin(54*pi/180)];
C = [0;9];
D = [4*cos(126*pi/180);4*sin(126*pi/180)];
x0=[A(1),B(1),C(1),D(1),A(1)];
y0=[A(2),B(2),C(2),D(2),A(2)];
%In Matrix Form:
init = [x0;y0;ones(1,length(x0))];

%Part1, Figure 1: Initial Shape
plot(x0,y0);hold on

%Parts 2-4: Defining each subsnowflake
theta = (72*pi)/180;
RC1 = [cos(theta) sin(theta) 0;
        -sin(theta) cos(theta) 0;
        0 0 1];
RC2 = [cos(2*theta) sin(2*theta) 0;
       -sin(2*theta) cos(2*theta) 0;
        0 0 1]; 
RC3 = [cos(3*theta) sin(3*theta) 0;
       -sin(3*theta) cos(3*theta) 0;
        0 0 1]; 
RC4 = [cos(4*theta) sin(4*theta) 0;
       -sin(4*theta) cos(4*theta) 0;
        0 0 1]; 
X1matrix = RC1*init;
X2matrix = RC2*init;
X3matrix = RC3*init;
X4matrix = RC4*init;

%X1
X1x = X1matrix(1,:);
X1y = X1matrix(2,:);
%X2
X2x = X2matrix(1,:);
X2y = X2matrix(2,:);
%X3
X3x = X3matrix(1,:);
X3y = X3matrix(2,:);
%X4
X4x = X4matrix(1,:);
X4y = X4matrix(2,:);

plot(X1x,X1y);
plot(X2x,X2y);
plot(X3x,X3y);
plot(X4x,X4y);

%Part 7: Scaling
scale = 0.7;
scx = [scale 0 0;
        0 scale 0;
        0 0 1];

s0 = scx*init;
s0x = s0(1,:);
s0y = s0(2,:);
plot(s0x,s0y);

s1 = scx*X1matrix;
s1x = s1(1,:);
s1y = s1(2,:);
plot(s1x,s1y);

s2 = scx*X2matrix;
s2x = s2(1,:);
s2y = s2(2,:);
plot(s2x,s2y);

s3 = scx*X3matrix;
s3x = s3(1,:);
s3y = s3(2,:);
plot(s3x,s3y);

s4 = scx*X4matrix;
s4x = s4(1,:);
s4y = s4(2,:);
plot(s4x,s4y);

title('BONUS - Complete Snowflake')
xlabel('x');ylabel('y');
axis equal