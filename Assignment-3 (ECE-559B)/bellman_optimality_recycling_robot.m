% Achyuth Nandikotkur
% V00975928
% Question #1 (Bonus) [By solving bellmann optimality equations]

clear;
clc;

syms vlow vhigh

gamma = 0.8;
rwait = 1;
rsearch = 5;
beta = 0.25;
alpha = 0.25;

results = {{}, {}};

% Unroll bellman optimality equations and check for the actions that give rise
% to highest values of v*(low) and v*(high)

% wait when low
eqn1 = vlow == (rwait + (gamma* vlow));

% search when low
eqn2 = vlow == beta * (rsearch + (gamma * vlow)) + (1 - beta) * (-3 + (gamma * vhigh));

% recharge when low
eqn3 = vlow == (gamma * vhigh);

% wait when high
eqn4 = vhigh == (rwait + (gamma * vhigh));

% search when high
eqn5 = vhigh == alpha * (rsearch + (gamma * vhigh)) + (1 - alpha) * (rsearch + (gamma * vlow));

% wait when low & wait when high
S = solve([eqn1,eqn4]);
disp('Under policy p(low, wait) = 1 & p(high, wait) = 1')
disp(['Value of waiting when low is ', num2str(double(S.vlow))]);
disp(['Value of waiting when high is ', num2str(double(S.vhigh))]);

fprintf('\n')
% search when low & search when high
S = solve([eqn1,eqn5]);
disp('Under policy p(low, wait) = 1 & p(high, search) = 1')
disp(['Value of waiting when low is ', num2str(double(S.vlow))]);
disp(['Value of searching when high is ', num2str(double(S.vhigh))]);

fprintf('\n')
% wait when low & wait when high
S = solve([eqn2,eqn4]);
disp('Under policy p(low, search) = 1 & p(high, wait) = 1')
disp(['Value of searching when low is ', num2str(double(S.vlow))]);
disp(['Value of waiting when high is ', num2str(double(S.vhigh))]);

fprintf('\n')
% search when low & search when high
S = solve([eqn2,eqn5]);
disp('Under policy p(low, search) = 1 & p(high, search) = 1')
disp(['Value of searching when low is ', num2str(double(S.vlow))]);
disp(['Value of searching when high is ', num2str(double(S.vhigh))]);

fprintf('\n')
% recharge when low & wait when high
S = solve([eqn3,eqn4]);
disp('Under policy p(low, recharge) = 1 & p(high, wait) = 1')
disp(['Value of recharging when low is ', num2str(double(S.vlow))]);
disp(['Value of waiting when high is ', num2str(double(S.vhigh))]);

fprintf('\n')
% recharging when low & search when high
S = solve([eqn3,eqn5]);
disp('Under policy p(low, recharge) = 1 & p(high, search) = 1')
disp(['Value of recharging when low is ', num2str(double(S.vlow))]);
disp(['Value of searching when high is ', num2str(double(S.vhigh))]);
fprintf('\n');

disp('Recharging when low yields the highest value for v*(low) and searching when high yields the highest value for v*(high)');
fprintf('\n');
disp('*********** Optimal Policy ***************')
disp('Hence the optimal policy is p(low, recharge) = 1; p(high, search) = 1')
fprintf('\n');
formatSpec = 'Value of recharging when low is %f';
fprintf(formatSpec,double(S.vlow));
fprintf('\n');
formatSpec = 'Value of searching when high is %f';
fprintf(formatSpec,double(S.vhigh));
fprintf('\n');
disp('*********** Optimal Policy ***************')