clc;clear;close all;
%Lawrence Custodio
%HW 7 Problem 2
%Given Parameters:
l1 = 1; l2 = 1; l3 = 1.1; l4 = 0.9; l5 = 1;
t1 = 0.05; t2 = 0.08;
the = 60:.4:100; ta = 99.6:-.4:60;
theta2 = [the ta];
%Part A - Find theta3=f(theta2) and theta4=f(theta2)
L1 = l1/l4; L2 = l1/l2; L3 = (l2^2-l3^2+l4^2+l1^2)/(2*l2*l4); %dimensionless params
for j = 1:length(theta2)
    error = .1; %set error valu
    eps = 1;
    theta4(1) = 40; %Set initial guess
    %Freudenstein condition/equation to find theta4(j)
    k = 1; %theta4 indexing for Freudenstein
    while eps>error
        theta4(k+1) = acosd((L2^-1)*(L1*cosd(theta2(j))-L3+cosd(theta2(j)-theta4(k))));
        eps = abs(theta4(k+1)-theta4(k));
    k = k+1;
    end;
    theta4(j)=theta4(k);
    %Finding theta3(j)
    theta3(j) = acosd((-l2*cosd(theta2(j))+l4*cosd(theta4(j))+l1)/l3);
end
plot(theta2(101:end),theta4(101:end),'r')
hold on
plot(theta2(101:end),theta3(101:end))
title('Freudenstein Approach: \theta_3/\theta_4 vs \theta_2,')
legend('\theta_4','\theta_3')
xlabel('\theta_2 [\circ]')
ylabel('\theta [\circ]')
%Part B - Plot trajectory of A and B, see handout
%Trajectory @ Pt.A:
for A=1:length(theta2)
    h = t2;
    hn = l5;
    xA(A) = l2.*cosd(theta2(A)) + h.*cosd(theta3(A)) - hn.*sind(theta3(A));
    yA(A) = l2.*sind(theta2(A)) + h.*sind(theta3(A)) + hn.*cosd(theta3(A));
end
%Trajectory @ Pt.B:
for B=1:length(theta2)
    h = .5*l3;
    hn = t1;
    xB(B) = l2.*cosd(theta2(B)) + h.*cosd(theta3(B)) - hn.*sind(theta3(B));
    yB(B) = l2.*sind(theta2(B)) + h.*sind(theta3(B)) + hn.*cosd(theta3(B));
end
figure
plot(yA,xA,'r')
hold on
plot(yB,xB)
set(gca,'Xdir','reverse');
title('Trajectory of Points A and B')
legend('Point A','Point B')
xlabel('Y [m]')
ylabel('X [m]')
%Part C - Angular velocities
om2=5/pi;
for i=1:length(theta2)
    om3(i)= om2*(l2/l3)*sind(theta2(i)-theta4(i))/sind(theta3(i)+theta4(i));
    om4(i)= om2*(l2/l4)*sind(theta3(i)+theta2(i))/sind(theta3(i)+theta4(i));
end
figure
plot(theta2(101:end),om3(101:end),'r')
hold on
plot(theta2(101:end),om4(101:end))
title('Angular velocity of \theta_3 and \theta_4')
legend('\omega_3','\omega_4')
xlabel('\theta_2 [\circ]')
ylabel('\omega [Rad/s]')
