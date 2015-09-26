%Lawrence Custodio
%HW 4 Problem 3 Part B
clc;clear;close all;
%Defining BCS: y(0) = 2; y'(0) = -2
y0 = zeros(2,1);
y0(1) = 2;
y0(2) = -2;
%domain
tspan = [0,40];
%Using ODE45 solver:
%at c=0:
[t1,y1] = ode45('custodio_lawrence_hw4_eqs',tspan,y0);
plot(t1,y1)
title('Solution of 2nd Order ODE @ c = 0')
legend('y','dy/dt')
xlabel('Time[s]')
ylabel('y')
%at c=0.2:
figure
[t2,y2] = ode45('custodio_lawrence_hw4_eqs1',tspan,y0);
plot(t2,y2)
title('Solution of 2nd Order ODE @ c = 0.5')
legend('y','dy/dt')
xlabel('Time[s]')
ylabel('y')
%at c=1:
figure
[t3,y3] = ode45('custodio_lawrence_hw4_eqs2',tspan,y0);
plot(t3,y3)
title('Solution of 2nd Order ODE @ c = 1.0')
legend('y','dy/dt')
xlabel('Time[s]')
ylabel('y')