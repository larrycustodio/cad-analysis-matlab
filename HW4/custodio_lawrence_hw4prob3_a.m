%Lawrence Custodio
%HW 4 Problem 3 Part A 
clc;clear; close all;
tspan = [0 20]; %span of time interval
y0 = 2.5; %initial condition
%a. Plotting analytical solution
xx = 0:20;
ya = y0.*exp(0.05.*xx);
plot(xx,ya,'r')
hold on
%b. Explicit Euler
h = 4; %Step size
F =@(yi) 0.05*yi; %Function given
euler(1)=y0; %initial condition
t2span = 0:h:20;
for i=1:length(t2span)-1
    euler(i+1) = euler(i)+h*F(euler(i)); %Equation for explicit Euler
end
plot(t2span,euler,'g')
%c. Using ode23
[x,y_num] = ode23('custodio_lawrence_hw4_f1',tspan,y0);
plot(x,y_num,'b:')
title('Figure 1. Solution of ODEs')
xlabel('Time (years)')
ylabel('# of cars (millions)')
legend('Analytical','Explicit Euler, h = 4','ODE23')

%e. Step size of 0.5 years: plot analytical + forward euler in figure 2
h2 = 0.5; %Step size
t3span =0:h2:20; %Intervals
gg(1) = y0;
for k=1:(length(t3span)-1)
    gg(k+1) = gg(k)+h2*F(gg(k));
end
figure
plot(t3span,gg,'k--') %Plotting Explicit Euler at h=0.5
hold on
plot(t2span,euler,'-.') %Plotting Explicit Euler at h=4
plot(xx,ya,'r')%Plotting analytical sol'n
title('Figure 2. Solution of ODEs')
xlabel('Time (years)')
ylabel('# of cars (millions)')
legend('Explicit Euler, h = 0.5','Explicit Euler, h=4','Analytical')