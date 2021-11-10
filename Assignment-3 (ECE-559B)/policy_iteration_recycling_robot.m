% Achyuth Nandikotkur
% V00975928
% Question #2

clear;
clc;

alpha = 0.25;
rsearch = 5;
rwait = 1;
gamma = 0.8;
beta = 0.25;

pihighsearch = 0.5;
pihighwait = 0.5;

pilow = {0 , 0, 0};
pilow{1} = 0.5;
pilow{2} = 0.25;
pilow{3} = 0.25;

policynew = {0, 0, 0, 0, 0};

policynew{1} = pihighsearch;
policynew{2} = pihighwait;
policynew{3} = pilow{1};
policynew{4} = pilow{2};
policynew{5} = pilow{3};


afactor = 0.001;

% initial values
% vstates(1,:) holds v(low) iteration values and vstates(1, :) holds
% v(high) iteration values
vstates = [0; 0];

low = 1;
high = 2;
index = 1;

loop = 1;
outerloop = 1;
policyIndex = 1;

isPolicyStable = 0;

accuracy1 = Inf;
accuracy2 = Inf;

while outerloop
    disp(['***************** Policy #', num2str(policyIndex), ' *****************'])
    disp(['p(high, search) = ', num2str(pihighsearch)]);
    disp(['p(high, wait) = ', num2str(pihighwait)]);
    disp(['p(low, search) = ', num2str(pilow{1})]);
    disp(['p(low, wait) = ', num2str(pilow{2})]);
    disp(['p(low, recharge) = ', num2str(pilow{3})]);
    fprintf('\n\n')
    while loop
        vlowwait = (rwait + (gamma* vstates(low, index)));
        vlowsearch = beta * (rsearch + (gamma * vstates(low, index))) + (1 - beta) * (-3 + (gamma * vstates(high, index)));
        vlowrecharge = (gamma * vstates(high, index));

        vhighwait = (rwait + (gamma * vstates(high, index)));
        vhighsearch = alpha * (rsearch + (gamma * vstates(high, index))) + (1 - alpha) * (rsearch + (gamma * vstates(low, index)));
        
        vlow = pilow{1} * vlowsearch + pilow{2} * vlowwait + pilow{3} * vlowrecharge;
        vhigh = pihighsearch * vhighsearch + pihighwait * vhighwait;

        vstates = [vstates [vlow; vhigh]];
        index = index + 1;

        if ((vstates(low, index) - vstates(low, index - 1)) <= afactor && (vstates(high, index) - vstates(high, index-1)) <= afactor)
            loop = 0;
        end
        
        disp(['value of v(low) is: ', num2str(vstates(low, index))]);
        disp(['value of v(high) is: ',num2str(vstates(high, index))]);
    end
    disp('*********************************************')

    %action value of searching when low
    qlowsearch = beta * (rsearch + (gamma * vstates(low, index))) + (1 - beta) * (-3 + (gamma * vstates(high, index)));

    %action value of waiting when low
    qlowwait = (rwait + (gamma* vstates(low, index)));

    %action value of recharging when low
    qlowrecharge = (gamma * vstates(high, index));

    %action value of searching when low
    qhighsearch = alpha * (rsearch + (gamma * vstates(high, index))) + (1 - alpha) * (rsearch + (gamma * vstates(low, index)));

    %action value of waiting when low
    qhighwait = (rwait + (gamma * vstates(high, index)));
    
    if(qhighsearch == qhighwait)
       pihighsearch = 0.5;
       pihighwait = 0.5;
    elseif(qhighsearch > qhighwait)
       pihighsearch = 1;
       pihighwait = 0;
    else
        pihighsearch = 0;
        pihighwait = 1;
    end

    A = [qlowsearch qlowwait qlowrecharge];
    maxval = max(A);
    lia = ismember(A,maxval);
    idx = find(lia);

    prob = 1;
    pilow = {0, 0, 0};
    for i = 1:numel(idx)
        pilow{idx} = (prob/numel(idx));
        if(size(idx) == 1)
            break;
        end
    end
    
    if((policynew{1} == pihighsearch && policynew{2} == pihighwait && policynew{3} == pilow{1} && policynew{4} == pilow{2} && policynew{5} == pilow{3}))
        break;
    else
        policynew{1} = pihighsearch;
        policynew{2} = pihighwait;
        policynew{3} = pilow{1};
        policynew{4} = pilow{2};
        policynew{5} = pilow{3};
    end
    fprintf('\n');
    disp('Performing greedy improvement...')
    disp('New policy calculated, evaluating new policy..')
    fprintf('\n');
    
    policyIndex = policyIndex + 1;
    loop = 1;
end

fprintf('\n\n')
disp(['***************** Optimal Policy *****************'])

vlowwait = (rwait + (gamma* vstates(low, index)));
vlowsearch = beta * (rsearch + (gamma * vstates(low, index))) + (1 - beta) * (-3 + (gamma * vstates(high, index)));
vlowrecharge = (gamma * vstates(high, index));

vhighwait = (rwait + (gamma * vstates(high, index)));
vhighsearch = alpha * (rsearch + (gamma * vstates(high, index))) + (1 - alpha) * (rsearch + (gamma * vstates(low, index)));

vlow = pilow{1} * vlowsearch + pilow{2} * vlowwait + pilow{3} * vlowrecharge;
vhigh = pihighsearch * vhighsearch + pihighwait * vhighwait;

vstates = [vstates [vlow; vhigh]];
index = index+1;
disp(['value of optimal v(low) is: ', num2str(vstates(low, index))]);
disp(['value of optimal v(high) is: ',num2str(vstates(high, index))]);
        
disp(['p(high, search) = ', num2str(pihighsearch)]);
disp(['p(high, wait) = ', num2str(pihighwait)]);
disp(['p(low, search) = ', num2str(pilow{1})]);
disp(['p(low, wait) = ', num2str(pilow{2})]);
disp(['p(low, recharge) = ', num2str(pilow{3})]);
disp(['***************** Optimal Policy *****************'])