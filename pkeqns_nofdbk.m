%
%   PKEQNS_NOFDBK.M  Point Kinetics Equations for arbitrary input  
%                      reactivity, rho(t), with no feedbacks
%
%   This function file is called by ode15s to solve the linear kinetics eqns.
%   (i.e. there are no feedbacks present in this simulation) for the case of an 
%   arbitrarily varying rho(t), and constant neutron source, Q.  The value of rho 
%   at any time t is linearly interpolated between the closest available time points.
%   Note that the equations have been normalized so that the neutron amplitude 
%   represents power in watts and the source Q is in neuts/sec. 
%   
%   rho0 represents the initial reactivity level which allows for the initial 
%   steady state system to be either subcritical or just critical (rho0 <= 0).
%
%   rhot and rho0 are input in absolute Dk/k units and the source Q is assumed to be 
%   constant and is given in neutrons/sec.  Always be careful with units!!!
%
%   rhot represents the externally applied reactivity (i.e. under operator control).  
%   The input vectors tt and rhot give the values of rho(t) at several time points 
%   and Matlab's interp1 function is used to linearly interpolate for any t.  
%   For example, if rhot has the same value at sequential time points, then the
%   reactivtiy is constant during that interval.  However, if rhot is different at 
%   two sequential time points, then reactivity varies linearly over the interval.
%   With this simple scheme, any rho(t) function can be approximated by a set of 
%   linearly varying line segments -- and, with small time intervals, reasonably good
%   estimates of any continuously varying reactivity function can be achieved.
%
%   The Be, Gt, B, lam, kappa, and nu inputs are the standard "kinetics parameters"
%   and these are obtained for any UMLRR simulations from the kinetics_data.m 
%   function.  These quantities must be available in the main program and passed to
%   this function.
%
%   Written by J. R. White, UMass-Lowell  (last update: March 2016)
%

      function xp = pkeqns_nofdbk(t,x,rho0,Q,Be,Gt,B,lam,kappa,nu,tt,rhot)
%
      rho = interp1(tt,rhot,t);   % get value of externally applied rho for current t
%
%   order of state vector ==>  x = [P C1 C2 C3 C4 C5 C6]'
      RHO = rho0+rho;      
      xp = zeros(length(x),1); 
      xp(1) = (1/Gt)*(RHO-Be)*x(1) + lam(1)*x(2) + lam(2)*x(3) + lam(3)*x(4)...
                                   + lam(4)*x(5) + lam(5)*x(6) + lam(6)*x(7)...
                                   + kappa/(Gt*nu)*Q;
      xp(2) = B(1)*x(1)/Gt - lam(1)*x(2);
      xp(3) = B(2)*x(1)/Gt - lam(2)*x(3);
      xp(4) = B(3)*x(1)/Gt - lam(3)*x(4);
      xp(5) = B(4)*x(1)/Gt - lam(4)*x(5);
      xp(6) = B(5)*x(1)/Gt - lam(5)*x(6);
      xp(7) = B(6)*x(1)/Gt - lam(6)*x(7);
%
%    end of function