%
%   KINETICS_DATA.M    Function to set the kinetics data needed to do 
%                         point kinetics simulations for the UMLRR
%
%   The data given in this file are used for performing point kinetics simulations 
%   for the UMLRR.  These data were originally embedded within the various simulation 
%   codes, but this is not very efficient  --  so I decided to simply make a short
%   function file with the needed data...
%
%   There are two sets of data available for use (choice is set here!!!).
%     1. Historical kinetics parameters --- these have been in use since about 1991.
%        Beff and GenTime were obtained from ANL RERTR program as part of the HEU to
%        LEU conversion effort.  The precursor yields and decay constants were based
%        on ENDF/B-V data (from the Westinghouse I-bar study done in the late 1980s).
%     2. The NEW kinetics parameters were obtained from our "newrefbol" MCNP6 model 
%        using the kopts options.  This model includes full fuel in C3  & C5 instead
%        of partial elements.  In addition, it uses the Al RadBasket (ARB) in D5 and
%        the nee metal matrix composite (MMC) control blades.  This model was 
%        generated in summer 2015 as part of the studies being done to support the 
%        re-licensing effort.  Tis configuration is expected to be our "new reference 
%        core model".  
%
%   A quick test against some experiments run in Feb. 2013 and  Feb. 2014 (as part 
%   of the Reactor Expts. course) show that the NEW kinetics data do a relatively
%   poor job (horrible actually) compared to the historical data set.  Thus, until
%   I can figure out what is wrong here, stay with the historical set (i.e set #1).
%      ***  see comparions in kinetics_data_test.docx  ***      (JRWhite, 7/24/15)
%
%   File prepared by J. R. White, UMass-Lowell (last updated in July 2015)
%

      function [Be,B,Gt,lam,td,S,kappa,nu] = kinetics_data()
%
%   select set to use (fixed here by JRWhite on 7/24/15)
      set = 1;  % set = 1 gives historical data & set ~= 1 gives NEW data
      if set == 1;
%
%   historical kinetics data in use at the UMLRR since early 1990s
%
%   UMLRR-specific data
      Be = 0.0078;            % effective delayed neutron fraction
      Gt = 65e-6;             % mean prompt neutron generation time (s)
      S = 1.30e7;             % estimate of Am-Be source strength in UMLRR (neuts/sec)
%   generic kinetics data
      kappa = 200*1.602e-13;  % energy per fission (J)
      nu = 2.43;              % average neutrons per fission
      beta = [0.00026 0.00146 0.00129 0.00279 0.00088 0.00018]; % 6-g betas 
      lam = [0.0127 0.0317 0.1160 0.3111 1.4003 3.8708]; % 6-g decay constants (1/s)
      Ibar = Be/sum(beta);    % ratio of Beff/B
      B = Ibar*beta;          % 6-g delayed neutron fractions (normalized to Beff)
      td = sum(B./lam)/Be;    % mean lifetime of delayed neutrons (sec)
%
      else
%
%   NEW kinetics data generated from the newrefbol model defined in summer 2015 (see above)
%    (these values are similar to those generated for the M-2-5 core)
%
%   UMLRR-specific data
      Be = 0.00755;           % effective delayed neutron fraction
      Gt = 61.6e-6;           % mean prompt neutron generation time (s)
      S = 1.30e7;             % estimate of Am-Be source strength in UMLRR (neuts/sec)
%   generic kinetics data
      kappa = 200*1.602e-13;  % energy per fission (J)
      nu = 2.43;              % average neutrons per fission
      beta = [0.00026 0.00127 0.00119 0.00345 0.00103 0.00035]; % 6-g betas 
      lam = [0.0125 0.0318 0.1084 0.3173 1.353 8.655]; % 6-g decay constants (1/s)
      Ibar = Be/sum(beta);    % ratio of Beff/B
      B = Ibar*beta;          % 6-g delayed neutron fractions (normalized to Beff)
      td = sum(B./lam)/Be;    % mean lifetime of delayed neutrons (sec)
%
      end
%
%   end of routine
