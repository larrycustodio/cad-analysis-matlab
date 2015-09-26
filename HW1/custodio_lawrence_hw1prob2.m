%Lawrence Custodio - Problem 2
clc; clear all; close all;
%Defining the x vectors for the respective interval steps:
%dx = 4
four1 = -8:4:0; four2 = 0:4:8;
%dx = 2
two1 = -8:2:0; two2 = 0:2:8; 
%dx = 0.01
hun1 = -8:0.01:0; hun2 = 0:0.01:8; 
%Defining the function z in four different ways:
z1 = @(x) sqrt(12^2-(x+4).^2);
z1n = @(x) -sqrt(12^2-(x+4).^2);
z2 = @(x) sqrt(12^2-(abs(x)+4).^2);
z2n = @(x) -sqrt(12^2-(abs(x)+4).^2);

%Computing and plotting for z accordingly:
%For dx = 4:
figure
plot(four1,z2(four1),'Color','red','LineWidth',2); hold on
plot(four1,z2n(four1),'Color','red','LineWidth',2)
plot(four2,z1(four2),'Color','red','LineWidth',2)
plot(four2,z1n(four2),'Color','red','LineWidth',2)
%Plot properties
xlim([-15 15]); ylim([-15 15])
xlabel('x'); ylabel('z')
title('Problem 2(a) - Football with dx=4')
grid on
axis equal

%For dx = 2:
figure
plot(two1,z2(two1),'Color','red','LineWidth',2); hold on
plot(two1,z2n(two1),'Color','red','LineWidth',2)
plot(two2,z1(two2),'Color','red','LineWidth',2)
plot(two2,z1n(two2),'Color','red','LineWidth',2)
%Plot properties
xlim([-15 15]); ylim([-15 15])
xlabel('x'); ylabel('z')
title('Problem 2(b) - Football with dx=2')
grid on
axis equal

%For dx = 0.01;
figure
plot(hun1,z2(hun1),'Color','red','LineWidth',2); hold on
plot(hun1,z2n(hun1),'Color','red','LineWidth',2)
plot(hun2,z1(hun2),'Color','red','LineWidth',2)
plot(hun2,z1n(hun2),'Color','red','LineWidth',2)
%Plot properties
xlim([-15 15]); ylim([-15 15])
xlabel('x'); ylabel('z')
title('Problem 2(c) - Football with dx=0.01')
grid on
axis equal