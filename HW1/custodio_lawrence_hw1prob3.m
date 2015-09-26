%Lawrence Custodio
%Problem 3
clc; clear all; close all
data = load('data.txt');
%Defining Data Points:
time = data(:,1); %time in [s]
voltage = data(:,2); %voltage in [V]
ldv = data(:,3); %velocity in [mm/s]
%Converted data units for plotting:
ms = time*1e3;
mV = voltage*1e3;
%Moving Average
past=500; %Average sample size
K=zeros(length(mV),1);
m=length(mV);
while m>=past
    K(m,1)=sum(mV((m-past+1):m,1))/past;
    m=m-1;
end
%integrated ldv signal
Fs = 1/(time(2)-time(1));
dispmm = detrend(cumsum(ldv))/ Fs; %displacement signal in [mm]
dispnm = dispmm*1e6; %disp. signal in [nm]
%Subplot(1)
subplot(2,2,1)
plot(ms,mV)
title('Voltage vs. Time');
xlabel('Time (ms)'); ylabel('Voltage (mV)');
axis tight
%Subplot(2)
subplot(2,2,2)
plot(ms,K)
title('Moving average of voltage vs. Time');
xlabel('Time (ms)'); ylabel('Voltage (mV)');
axis tight
%Subplot(3)
subplot(2,2,3)
plot(ms,ldv)
title('LDV velocity signal vs. Time')'
xlabel('Time (ms)'); ylabel('Velocity (mm/s)');
axis tight
%Subplot(4)
subplot(2,2,4)
plot(ms,dispnm)
title('Integrated LDV signal vs. Time');
xlabel('Time (ms)'); ylabel('Displacement (nm)');
axis tight
