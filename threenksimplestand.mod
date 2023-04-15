%%%%%%%%%%%%%%%
%% Variables %%
%%%%%%%%%%%%%%%
var pi yf y i gap;

varexo ea ecp ei;

%%%%%%%%%%%%%%%%
%% Parameters %%
%%%%%%%%%%%%%%%%

parameters beta si kappa theta eta sigma rho phipi rhov snu rhocp
           scp target sa rhoa;

beta = 0.98;
sigma = 1;
rho = 0.8;
theta = 0.75;
eta = 1;
kappa = ((1-theta)*(1-theta*beta))/theta*(sigma+eta);
phipi = 1.5;
rhov = 0;
snu = 0.03;
rhocp = 0.95;
scp = .13;
si = 0.01;
rhoa = 0.95;
sa = 0.007;
target = 0;

%%%%%%%%%%%
%% Model %%
%%%%%%%%%%%

model(linear);

% (1) Phillips Curve
pi = kappa*(y - yf) + beta*pi(+1) + scp*ecp;

% (2) DIS
y = y(+1) - (1/sigma)*(i - pi(+1));

% (3) Taylor Rule
i = rho*i(-1) + (1-rho)*phipi*pi + si*ei;

% (4) Flexible Output AR(1)
yf = rhoa*yf(-1) + (1+eta)/(sigma+eta)*ea;

% (5) Output Gap
gap = y - yf;

end;

%%%%%%%%%%%%%%%%%%%%
%% Initial Values %%
%%%%%%%%%%%%%%%%%%%%

initval;

pi = 0;
yf = 0;
i = 0;
y = 0;
gap = 0;

end;

steady;

%%%%%%%%%%%%%%%%%%%
%% Define shocks %%
%%%%%%%%%%%%%%%%%%%

shocks;
    var ea = 1;
    var ecp = 1;
    var ei = 1;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Stochastic simulation %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

stoch_simul(order = 1, ar = 1, irf=40);




