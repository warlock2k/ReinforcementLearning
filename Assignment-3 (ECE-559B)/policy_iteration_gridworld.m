% Achyuth Nandikotkur
% V00975928
% Question #4

clear;
clc;

accuracyfactor = 0.1;
gamma = 0.9;

states = string(0:24);
statesWithPolicies = cell(5,5);
statevalues = zeros(1,24);

for i=1:numel(statesWithPolicies)
    if(i == 2)
        statesWithPolicies{i} = {'A', '←→↑↓', 0, [0.25, 0.25, 0.25, 0.25], 1};
    elseif(i == 4)
        statesWithPolicies{i} = {'B', '←→↑↓', 0, [0.25, 0.25, 0.25, 0.25], 1};
    elseif(i == 19)
        statesWithPolicies{i} = {'Bd', '←→↑↓', 0, [0.25, 0.25, 0.25, 0.25], 1};
    elseif(i == 22)
        statesWithPolicies{i} = {'Ad', '←→↑↓', 0, [0.25, 0.25, 0.25, 0.25], 1};
    else
        statesWithPolicies{i} = {states(i), '←→↑↓', 0, [0.25, 0.25, 0.25, 0.25], 1};
    end
end

outerloop = 1;
innerloop = 1;

policyIndex = 1;
while outerloop
    printPolicy(statesWithPolicies, policyIndex, 0)
    tempvariable = statesWithPolicies;
    
    valueIterIndex = 1;
    while innerloop
        delta = 0;
        tempstore = statesWithPolicies;
        for i=1:25
            lastStateValue = tempstore{i}{3};
            if(tempstore{i}{5} == 1)
                % top side
                if(any(strcmp({'A'}, statesWithPolicies{i}{1})))
                    % right
                    tempstore{i}{3} = statesWithPolicies{i}{4}(2) * (10 + gamma * statesWithPolicies{22}{3}) + statesWithPolicies{i}{4}(1) * (10 + gamma * statesWithPolicies{22}{3})+statesWithPolicies{i}{4}(3) * (10 + gamma * statesWithPolicies{22}{3})+statesWithPolicies{i}{4}(4) * (10 + gamma * statesWithPolicies{22}{3});
                elseif(any(strcmp({'B'}, statesWithPolicies{i}{1})))
                    % right
                    tempstore{i}{3} = statesWithPolicies{i}{4}(2) * (5 + gamma * statesWithPolicies{19}{3})+statesWithPolicies{i}{4}(1) * (5 + gamma * statesWithPolicies{19}{3})+statesWithPolicies{i}{4}(3) * (5 + gamma * statesWithPolicies{19}{3}) + statesWithPolicies{i}{4}(4) * (5 + gamma * statesWithPolicies{19}{3});
                elseif(any(strcmp({'2'}, statesWithPolicies{i}{1})))
                    % right
                    tempstore{i}{3} = statesWithPolicies{i}{4}(2) * (0 + gamma * statesWithPolicies{i+1}{3})+statesWithPolicies{i}{4}(1) * (0 + gamma * statesWithPolicies{i-1}{3})+ statesWithPolicies{i}{4}(3) * (-1 + gamma * statesWithPolicies{i}{3}) + statesWithPolicies{i}{4}(4) * (0 + gamma * statesWithPolicies{i+5}{3});
                % right side
                elseif(any(strcmp({'9', '14', '19'}, statesWithPolicies{i}{1})))
                    % right
                    tempstore{i}{3} = statesWithPolicies{i}{4}(2) * (-1 + gamma * statesWithPolicies{i}{3})+statesWithPolicies{i}{4}(1) * (0 + gamma * statesWithPolicies{i-1}{3})+statesWithPolicies{i}{4}(3) * (0 + gamma * statesWithPolicies{i-5}{3})+statesWithPolicies{i}{4}(4) * (0 + gamma * statesWithPolicies{i+5}{3});
                % bottom side
                elseif(any(strcmp({'Ad', '22', '23'}, statesWithPolicies{i}{1})))
                    % right
                    tempstore{i}{3} = statesWithPolicies{i}{4}(2) * (0 + gamma * statesWithPolicies{i+1}{3})+statesWithPolicies{i}{4}(1) * (0 + gamma * statesWithPolicies{i-1}{3})+statesWithPolicies{i}{4}(3) * (0 + gamma * statesWithPolicies{i-5}{3})+statesWithPolicies{i}{4}(4) * (-1 + gamma * statesWithPolicies{i}{3});
                % left side
                elseif(any(strcmp({'5', '10', '15'}, statesWithPolicies{i}{1})))
                    % right
                    tempstore{i}{3} = statesWithPolicies{i}{4}(2) * (0 + gamma * statesWithPolicies{i+1}{3}) +statesWithPolicies{i}{4}(1) * (-1 + gamma * statesWithPolicies{i}{3}) + statesWithPolicies{i}{4}(3) * (0 + gamma * statesWithPolicies{i-5}{3})+statesWithPolicies{i}{4}(4) * (0 + gamma * statesWithPolicies{i+5}{3});
                % corners
                elseif('0' == statesWithPolicies{i}{1})
                    % right
                    tempstore{i}{3} = statesWithPolicies{i}{4}(2) * (0 + gamma * statesWithPolicies{i+1}{3}) + statesWithPolicies{i}{4}(1) * (-1 + gamma * statesWithPolicies{i}{3}) + statesWithPolicies{i}{4}(3) * (-1 + gamma * statesWithPolicies{i}{3}) + statesWithPolicies{i}{4}(4) * (0 + gamma * statesWithPolicies{i+5}{3});
                elseif('4' == statesWithPolicies{i}{1})
                    % right
                    tempstore{i}{3} = statesWithPolicies{i}{4}(2) * (-1 + gamma * statesWithPolicies{i}{3})+statesWithPolicies{i}{4}(1) * (0 + gamma * statesWithPolicies{i-1}{3})+statesWithPolicies{i}{4}(3) * (-1 + gamma * statesWithPolicies{i}{3})+statesWithPolicies{i}{4}(4) * (0 + gamma * statesWithPolicies{i+5}{3});
                elseif('24' == statesWithPolicies{i}{1})
                    % right
                    tempstore{i}{3} = statesWithPolicies{i}{4}(2) * (-1 + gamma * statesWithPolicies{i}{3})+statesWithPolicies{i}{4}(1) * (0 + gamma * statesWithPolicies{i-1}{3})+statesWithPolicies{i}{4}(3) * (0 + gamma * statesWithPolicies{i-5}{3})+statesWithPolicies{i}{4}(4) * (-1 + gamma * statesWithPolicies{i}{3});
                elseif('20' == statesWithPolicies{i}{1})
                    % right
                    tempstore{i}{3} = statesWithPolicies{i}{4}(2) * (0 + gamma * statesWithPolicies{i+1}{3})+statesWithPolicies{i}{4}(1) * (-1 + gamma * statesWithPolicies{i}{3})+statesWithPolicies{i}{4}(3) * (0 + gamma * statesWithPolicies{i-5}{3})+statesWithPolicies{i}{4}(4) * (-1 + gamma * statesWithPolicies{i}{3});
                % All other cases
                else
                    % right
                    tempstore{i}{3} = (statesWithPolicies{i}{4}(2) * (gamma * statesWithPolicies{i+1}{3})) + (statesWithPolicies{i}{4}(1) * (gamma * statesWithPolicies{i-1}{3})) + (statesWithPolicies{i}{4}(3) * (gamma * statesWithPolicies{i-5}{3})) + (statesWithPolicies{i}{4}(4) * (gamma * statesWithPolicies{i+5}{3}));
                end
                
                delta = max(delta, abs(lastStateValue - tempstore{i}{3}));
            end
        end
        
        statesWithPolicies = tempstore;
        if(delta < accuracyfactor)
            innerloop = 0;
        end
        valueIterIndex = valueIterIndex + 1;
    end
    printValuesOfStates(statesWithPolicies);
    
    % Perform greedy improvement on all states
    statesWithPolicies = calculateGreedyPolicyForAState(statesWithPolicies);
    
    exit = 1;
    for k = 1:25
        statesWithPolicies{k}{5} = 1;
        if(tempvariable{k}{2} ~= statesWithPolicies{k}{2})
            exit = 0;
        end
    end
    
    innerloop = 1;
    policyIndex = policyIndex + 1;
    
    if(exit)
        break;
    end
end

printPolicy(statesWithPolicies, policyIndex, 1)
printValuesOfStates(statesWithPolicies)

function printPolicy(statesWithPolicies, policyNumber, optimal)
    temporary = statesWithPolicies;
    for final = 1:25
        temporary{final}(4) = [];
        temporary{final}(4) = [];
    end
    t = cell2table(transpose(temporary),'VariableNames',{'Column-1', 'Column-2', 'Column-3', 'Column-4', 'Column-5'});
    fig = uifigure;
    if(optimal == 0)
        fig.Name = ['Policy: ',  num2str(policyNumber)];
    else
        fig.Name = 'Optimal Policy';
    end
    fig.Position(3) = 1000;
    
    uitable(fig,'Data',t, 'ColumnWidth',{199, 199,  199, 199, 199}, 'Position',[10 10 1000 300]);
end

function printValuesOfStates(statesWithPolicies)
    disp(['***************** Value of states *****************'])
    for v=1:numel(statesWithPolicies)
        formatSpec = 'Value at state: %s is %d \n';
        fprintf(formatSpec,statesWithPolicies{v}{1},statesWithPolicies{v}{3});
    end
    disp(['*************************************************'])
end

function stateinfo = calculateGreedyPolicyForAState(statesWithPolicies)
    gamma = 0.9;
    temporaryStore = statesWithPolicies;
    for state=1:25
        % left right up down
        policyDirection = [0 0 0 0];

        % top side
        if(any(strcmp({'A'}, statesWithPolicies{state}{1})))
            % right
            policyDirection(2) = (10 + gamma * statesWithPolicies{22}{3});

            % left
            policyDirection(1) = (10 + gamma * statesWithPolicies{22}{3});

            % up
            policyDirection(3) = (10 + gamma * statesWithPolicies{22}{3});

            % down
            policyDirection(4) =  (10 + gamma * statesWithPolicies{22}{3});
        elseif(any(strcmp({'B'}, statesWithPolicies{state}{1})))
            % right
            policyDirection(2) = (5 + gamma * statesWithPolicies{19}{3});

            % left
            policyDirection(1) = (5 + gamma * statesWithPolicies{19}{3});

            % up
            policyDirection(3) = (5 + gamma * statesWithPolicies{19}{3});

            % down
            policyDirection(4) = (5 + gamma * statesWithPolicies{19}{3});
        elseif(any(strcmp({'2'}, statesWithPolicies{state}{1})))
            % right
            policyDirection(2) = (gamma * statesWithPolicies{state+1}{3});

            % left
            policyDirection(1) = (gamma * statesWithPolicies{state-1}{3});

            % up
            policyDirection(3) = (-1 + gamma * statesWithPolicies{state}{3});

            % down
            policyDirection(4) = (gamma * statesWithPolicies{state+5}{3});
        % right side
        elseif(any(strcmp({'9', '14', '19'}, statesWithPolicies{state}{1})))
            % right
            policyDirection(2) = (-1 + gamma * statesWithPolicies{state}{3});

            % left
            policyDirection(1) = (0 + gamma * statesWithPolicies{state-1}{3});

            % up
            policyDirection(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            policyDirection(4) = (0 + gamma * statesWithPolicies{state+5}{3});
        % bottom side
        elseif(any(strcmp({'Ad', '22', '23'}, statesWithPolicies{state}{1})))
            % right
            policyDirection(2) = (0 + gamma * statesWithPolicies{state+1}{3});

            % left
            policyDirection(1) = (0 + gamma * statesWithPolicies{state-1}{3});

            % up
            policyDirection(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            policyDirection(4) = (-1 + gamma * statesWithPolicies{state}{3});
        % left side
        elseif(any(strcmp({'5', '10', '15'}, statesWithPolicies{state}{1})))
            % right
            policyDirection(2) = (0 + gamma * statesWithPolicies{state+1}{3});

            % left
            policyDirection(1) = (-1 + gamma * statesWithPolicies{state}{3});

            % up
            policyDirection(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            policyDirection(4) = (0 + gamma * statesWithPolicies{state+5}{3});
        % corners
        elseif('0' == statesWithPolicies{state}{1})
            % right
            policyDirection(2) = (0 + gamma * statesWithPolicies{state+1}{3});

            % left
            policyDirection(1) = (-1 + gamma * statesWithPolicies{state}{3});

            % up
            policyDirection(3) = (-1 + gamma * statesWithPolicies{state}{3});

            % down
            policyDirection(4) = (0 + gamma * statesWithPolicies{state+5}{3});
        elseif('4' == statesWithPolicies{state}{1})
            % right
            policyDirection(2) = (-1 + gamma * statesWithPolicies{state}{3});

            % left
            policyDirection(1) = (0 + gamma * statesWithPolicies{state-1}{3});

            % up
            policyDirection(3) = (-1 + gamma * statesWithPolicies{state}{3});

            % down
            policyDirection(4) = (0 + gamma * statesWithPolicies{state+5}{3});
        elseif('24' == statesWithPolicies{state}{1})
            % right
            policyDirection(2) = (-1 + gamma * statesWithPolicies{state}{3});

            % left
            policyDirection(1) = (0 + gamma * statesWithPolicies{state-1}{3});

            % up
            policyDirection(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            policyDirection(4) = (-1 + gamma * statesWithPolicies{state}{3});
        elseif('20' == statesWithPolicies{state}{1})
            % right
            policyDirection(2) = (0 + gamma * statesWithPolicies{state+1}{3});

            % left
            policyDirection(1) = (-1 + gamma * statesWithPolicies{state}{3});

            % up
            policyDirection(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            policyDirection(4) = (-1 + gamma * statesWithPolicies{state}{3});
        % All other cases
        else
            % right
            policyDirection(2) = (0 + gamma * statesWithPolicies{state+1}{3});

            % left
            policyDirection(1) = (0 + gamma * statesWithPolicies{state-1}{3});

            % up
            policyDirection(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            policyDirection(4) = (0 + gamma * statesWithPolicies{state+5}{3});
        end

        maxval = max(policyDirection);
        lia = ismember(policyDirection, maxval);
        idx = find(lia);

        prob = 1;
        temporaryStore{state}{4} = [0, 0, 0, 0];
        for i = 1:numel(idx)
            temporaryStore{state}{4}(idx(i)) = (prob/numel(idx));
            if(size(idx) == 1)
                break;
            end
        end

        policy = '';
        if(temporaryStore{state}{4}(1) ~= 0)
            policy = policy + "←";
        end
        if(temporaryStore{state}{4}(2)~= 0)
            policy = policy + "→";
        end
        if(temporaryStore{state}{4}(3)~= 0)
            policy = policy + "↑";
        end
        if(temporaryStore{state}{4}(4)~= 0)
            policy = policy + "↓";
        end
        temporaryStore{state}{2} = policy;
    end
    stateinfo = temporaryStore;
    
    % check if the policies are same as last time
end