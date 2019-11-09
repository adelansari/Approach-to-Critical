%
%     Subcritical Multiplication and “Approach to Critical”
%     Prepared by:
%     Adel Ali Ansari
%

      clear all,  close all,  nfig = 0;  
%%
%   define UMLRR-specific kinetics data and other parameters for the simulations
      [Be,B,Gt,lam,td,S,kappa,nu] = kinetics_data();
      tol  = 1e-5;  options = odeset('RelTol',tol); % error tolerance for ODE solver
      ftime = 1000;            % final simulation time (seconds)
       
%%
%   ***********************************
%   *  Step Change Case:  rho = +5 $  *
%   ***********************************
      tt = [0 5 5.1 20 20.1 40 40.1 60 60.1 80 80.1 120 120.1 140 140.1 160 160.1 200];  
      rhot = [0 0 5 5 7.5 7.5 8.75 8.75 9.375 9.375 9.6875 9.6875 9.8 9.8 9.9 9.9 10 10]*Be;  % specific applied rho(t)
      
      %    steady-state sub-critical with source
      rho0 = -10*Be;
      Q = S; 
      %
      
      Po = 2.567e-3;                 % initial power level (W)
      Co = B*Po./(lam*Gt);    % initial precursor conc
      xo = [Po Co]';          % initial condition for state vector
      ftx = @(t,x) pkeqns_nofdbk(t,x,rho0,Q,Be,Gt,B,lam,kappa,nu,tt,rhot);
      [t,x] = ode15s(ftx,[0 ftime],xo,options);  
      P = x(:,1);             % extract P(t) in W from full solution
      TotalRho = (rhot+rho0); % rho(t) in Dk/k
      PtPo = P / Po ;
%
      nfig = nfig+1;   figure(nfig)
      plot(t,P,'r-','LineWidth',2),grid %   Plotting external power in Watts
      title('P(t) vs Time')
      ylabel('Power Level (W)'),
      xlabel('Time (sec)')
      
      nfig = nfig+1;   figure(nfig)
      plot(tt,rhot,'b-','LineWidth',2),grid  %  Plotting external reactivity in dollars
      title('PKSim\_Test: Reactor Response due to Step Change in \rho')
      ylabel('External \rho in Dk/k'),
      xlabel('Time (sec)')
      
      nfig = nfig+1;   figure(nfig)      
      plot(tt,TotalRho,'b-','LineWidth',2),grid %   Plotting total reactivity in dollars
      title('\delta \rho external')
      ylabel('Total \rho in Dk/k'),
      xlabel('Time (sec)')

      
      nfig = nfig+1;   figure(nfig)
      plot(t,PtPo,'r-','LineWidth',2),grid     %   Plotting P(t)/Po vs. time
      title('P(t)/Po vs Time')
      ylabel('P(t)/Po'),
      xlabel('Time (sec)')
      
% End of Program
