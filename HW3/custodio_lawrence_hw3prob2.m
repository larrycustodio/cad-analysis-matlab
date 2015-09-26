clear;clc;
%Part A
%Defining the variables:
rho = 8960; drho = 10; %density + uncertainty
D = 2e-6; dD = 0.01e-6; %diameter + uncertainty
L = 3e-4; dL = 0.03e-4; %length + uncertainty
E = 128.8e9; dE = 0; %Modulus + uncertainty
% Function + Partial derivativesnd 
f = (0.56/L^2)*sqrt((E*D^2)/(16*rho));
frho = -(7*D^2*E)/(400*L^2*rho^2*((D^2*E)/(16*rho))^(1/2)); %df/drho
fD = (7*D*E)/(200*L^2*rho*((D^2*E)/(16*rho))^(1/2)); %df/dD
fL = -(28*((D^2*E)/(16*rho))^(1/2))/(25*L^3); %df/dL
fE = (7*D^2)/(400*L^2*rho*((D^2*E)/(16*rho))^(1/2)); %df/dE
disp('Nominal value:');
disp(f);
%Worst Case Error
fwce = abs(frho)*drho + abs(fD)*dD + abs(fL)*dL + abs(fE)*dE;
disp('Worst Case Error:')
disp(fwce)
%Statistical Error
fstat = sqrt(frho^2*drho^2 + fD^2*dD^2 + fL^2*dL^2 + fE^2*dE^2);
disp('Statistical Error:')
disp(fstat)

%Part B:
%Uniform Distribution + Plotting
n = 1e4 ; %r sample-size
figure;
%Independent Variable Distribution: diameter
r2 = rand(n,1);
ud = sqrt(r2*((D+dD)^2-(D-dD)^2));
subplot(222)    
hist(ud,50);
xlabel('[m]')
title('Diameter')
%Independent Variable Distribution: length
r3 = rand(n,1);
ul = 2*dL*r3+(L-dL);
subplot(223)
hist(ul,50);
title('Length')
xlabel('[m]')
%Independent Variable Distribution: density
r4 = rand(n,1);
urho = 2*drho*r4+(rho-drho);
subplot(224)
hist(urho,50);
title('Density')
xlabel('[kg/m^3]')
%Dependent Variable Distribution: frequency
ufreq = (0.56*ul.^-2).*sqrt((E*ud.^2)./(16*urho));
subplot(221) 
hist(ufreq,50);
title('Frequency')
xlabel('[Hz]')

%Normal distribution
figure;
%Diameter
r2n = sqrt(2)*erfinv(2*r2-1); %Normally distributed random number array
nD = D + (dD/3)*r2n; %Normal dist. formula
subplot(222)
hist(nD,50);
title('Diameter')
xlabel('[m]')
%Length
r3n = sqrt(2)*erfinv(2*r3-1); %Normally distributed random number array
nL = L + (dL/3)*r3n; %Normal dist. formula
subplot(223)
hist(nL,50);
title('Length')
xlabel('[m]')
%Density
r4n = sqrt(2)*erfinv(2*r4-1); %Normally distributed random number array
nrho = rho + (drho/3)*r4n; %Normal dist. formula
subplot(224)
hist(nrho,50);
title('Density')
xlabel('[kg/m^3]')
%Dependent variable: Frequency
nfreq = (0.56*nL.^-2).*sqrt((E*nD.^2)./(16*nrho));
subplot(221)
hist(nfreq,50);
title('Frequency')
xlabel('[Hz]')