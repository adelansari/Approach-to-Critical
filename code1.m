%
%     Subcritical Multiplication and “Approach to Critical” 
%     Prepared by:
%     Adel Ali Ansari

clear all,  close all,  nfig = 0;  

%%

rho0S = -10;             %   initial reactivity in $
rhoS = 0;                %   final reactivity in $
rhop = 0.5;              %   positive reactivity addition in $
delrho = rhoS - rho0S;   %   reactivity difference in $
Beta = 0.0078;           %   effective delayed neutron fraction

rhoS(1) = rho0S;
rho(1) = rhoS*Beta;
k(1) = 1/(1-rho(1));
% Mr(1)= rhoS/(rhoS+Beta);
Mr(1)= 1/(1-k(1));
InverseMR(1) = 1/Mr(1);

for i= 2:((delrho/rhop)+1)
    rhoS(i) = rhoS(i-1)+rhop;
    rho(i) = rhoS(i)*Beta;
    k(i) = 1/(1-rho(i));
    % Mr(i) = rhoS(i)/(rhoS(i)+Beta);
    Mr(i) = 1/(1-k(i));
    InverseMR(i) = 1/Mr(i);
end


%   Mr vs rho($)
nfig = nfig+1;   figure(nfig)
plot(rhoS,Mr),grid;
title('Mr Vs \rho($)'),ylabel('Subcritical multiplication factor Mr')
xlabel('Reactivity \rho ($)');

%   1/Mr vs rho

nfig = nfig+1;   figure(nfig)
plot(rhoS,InverseMR),grid;
title('1/Mr Vs \rho ($)')
ylabel('Inverse Subcritical multiplication factor 1/Mr')
xlabel('Reactivity \rho ($)')


%   Mr vs k
nfig = nfig+1;   figure(nfig)
plot(k,Mr),grid;
title('Mr Vs k'),ylabel('Subcritical Multiplication factor Mr')
xlabel('Multiplication factor k');
      
%   1/Mr vs k
nfig = nfig+1;   figure(nfig)
plot(k,InverseMR),grid;
title('1/Mr Vs k')
ylabel('Inverse Subcritical multiplication factor 1/Mr')
xlabel('Multiplication factor k')

