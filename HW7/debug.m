clear
clc
close all
%data
l3=1.1;
l4=0.9;
l1=1;
lh=0.75;
lv=0.75;
l2=1;

t2=60:100;%x-axis input angle
k=0;%index
%Freudenstein iteration
for t=60:100,%input angle theta2 counter in degree
    k=k+1;
    i=1;%iteration
    theta2(k)=t*pi/180;%theta2 in radian
    delta=2*(0.1*pi/180);%initial accuracy
    theta4(1)=theta2(k);%initial guess of theta4=theta2
    while abs(delta)>(0.1*pi/180)
        Lo=l1/l4;%L1
        Lt=l1/l2;%L2
        Lth=((l2)^2-(l3)^2+(l4)^2+(l1)^2)/(2*l2*l4);%L3
        theta4(i+1)= acos(( Lo*cos(theta2(k))-Lth+cos(theta2(k)-theta4(i)) )/Lt);
        delta=theta4(i+1)-theta4(i);
        i=i+1;
        %disp(sprintf('%2d %0.8f %0.8f',i,theta4(i),delta));
    end
theta4f(k)=theta4(i);
t4(k)=theta4f(k)*180/pi;%convert theta4f back to degree
%Analytical method,Find theta3,given theta2 and theta4
theta3(k)=asin(((l4)*sin(theta4f(k))-(l2)*sin(theta2(k)))/(l3));%10.3
t3(k)=theta3(k)*180/pi;%convert theta3 back to degree



%Find xp,yp, given theta3,theta2
xp(k)=l2*cos(theta2(k))+lh*cos(theta3(k))-lv*sin(theta3(k));
yp(k)=l2*sin(theta2(k))+lh*sin(theta3(k))-lv*sin(theta3(k));
end
%Print result of theta3,theta4,xp,yp for each 30 degrees
%Plot the output angle theta4 vs. input angle theta2
figure(1)
plot(t2,t4,'r');
title('Output angle 4 vs. input angle 2');
xlabel('Input angle: Theta 2 [degree]');
ylabel('Output angle: Theta 4 [degree]');
legend('Input vs. Output',2);
xlim([0 360]);
grid on;
hold on;
