%Lawrence Custodio
%MATLAB function for Problem 3 Part B
function dy =custodio_lawrence_hw4_eqs2(t,y) %inputs for span and BCs
c=1; %constant, c=1
dy = zeros(2,1);
%The 2nd order ODE rewritten as first order ODEs
dy(1) = y(2);
dy(2) = sin(pi*t/3)*cos(pi*t/5)-(c*y(2))-3*y(1);