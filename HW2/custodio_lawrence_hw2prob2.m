%Lawrence Custodio: Problem 2
clc;clear all;close all;
load('data.txt')
time = data(:,1);
pop = data(:,2);
M = length(data);
plot(time,pop)
hold on
%Linear Fit
nlinear = 1;
%A matrix: for A[i,j] = sigma[1,M](x.^(i+j-2); e.g.A(4,1) = sum(x.^3)
for rowA1=1:nlinear+1
    for columnA1=1:nlinear+1
    A1(rowA1,columnA1) = sum(time.^(rowA1+columnA1-2));
    end
end
%b-vector follows notation: sigma[1,M](y.*(x^(i+1))
for rowb1=1:nlinear+1
    x1 = time.^(rowb1-1);
    b1(rowb1,1)=sum((pop).*(x1));
end
%{a} = inv[A]*{b}
a1 =  A1\b1;
%Equation
y1 = a1(1) + a1(2).*time;
disp(['Linear: f(t)= ' num2str(a1(1)) ' + ' num2str(a1(2)) '*t']);
disp([a1]);
plot(time,y1,'y')
%Quadratic Fit
nquad = 2; 
%A matrix:
for rowA2=1:nquad+1
    for columnA2=1:nquad+1
    A2(rowA2,columnA2) = sum(time.^(rowA2+columnA2-2));
    end
end
%b vector:
for rowb2=1:nquad+1
    x2 = time.^(rowb2-1);
    b2(rowb2,1)=sum((pop).*(x2));
end
%Solving for constants:
a2 =  A2\b2;
y2 = a2(1) + a2(2).*time + a2(3).*(time.^2);
disp(['Quadratic: f(t)= ' num2str(a2(1)) ' + ' num2str(a2(2)) '*t + ' num2str(a2(3)) '*t^2']);
disp([a2]);
plot(time,y2,'r')
%Cubic Fit (follows same logic as quadratic, but n =3)
ncubic = 3;
for rowA3=1:ncubic+1
    for columnA3=1:ncubic+1
    A3(rowA3,columnA3) = sum(time.^(rowA3+columnA3-2));
    end
end
for rowb3=1:ncubic+1
    x3 = time.^(rowb3-1);
    b3(rowb3,1)=sum((pop).*(x3));
end
a3 =  A3\b3;
y3 = a3(1) + a3(2).*time + a3(3).*(time.^2) +a3(4).*(time.^3);
disp(['Cubic: f(t)= ' num2str(a3(1)) ' + ' num2str(a3(2)) '*t + ' num2str(a3(3)) '*t^2 + ' num2str(a3(4)) '*t^3']);
disp([a3]);
plot(time,y3,'g')
%Exponential Fit: y = Cexp^(k*t)
%Linearly modelled at lny = ln(C) + k*t
%A-matrix for exp. fit = linear fit A-matrix
Aexp = A1; 
%b-vector: note that sum(population)->sum(log(population))
bexp(1,1) = sum(log(pop));
bexp(2,1) = sum(log(pop).*time);
aexp = Aexp\bexp;
aexp(1) = 10; %Given that population @ t=0 is 10
k = aexp(2);
%Equation
yexp = aexp(1)*exp(k.*time);
disp(['Exponential: f(t)= ' num2str(aexp(1)) '*exp(' num2str(k) '*t)']);
disp([aexp]);
plot(time,yexp,'--k')
%Plotting
xlabel('Time (sec)')
ylabel('Bacteria Population (#)')
title('Bacterial Population Growth Rate vs. Time ')
legend('Experimental Data','Linear Fit','Quadratic Fit','Cubic Fit','Exponential Fit')
%Part D. Polyfit
LINE = polyfit(time,pop,nlinear) %Linear function (n=1)
QUAD = polyfit(time,pop,nquad) %Quadratic (n=2)
CUBE = polyfit(time,pop,ncubic) %Cubic (n=3)
EXP = polyfit(time,log(pop),1) %Exponential
%Part E. RMS Error
%Method: 
%(1)Define a variable = (y fitted - actual y value)
%(2) sqrt((sum(var))^2/length(y))
%Linear
d1=(pop-y1).^2;
RMSLinear = sqrt(sum(d1)/length(pop))
%Quadratic
d2=(pop-y2).^2;
RMSQuad = sqrt(sum(d2)/length(pop))
%Cubic
d3=(pop-y3).^2;
RMSCubic = sqrt(sum(d3)/length(pop))
%Exponential
dexp=(pop-yexp).^2;
RMSExp = sqrt(sum(dexp)/length(pop))