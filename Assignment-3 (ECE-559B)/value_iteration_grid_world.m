% Achyuth Nandikotkur
% V00975928
% Question #5

clear;
clc;

accuracyfactor = 0.1;
gamma = 0.8;

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

innerloop = 1;
valueIterIndex = 1;

while innerloop
    tempstore = statesWithPolicies;
    delta = 0;
    for state=1:25
        lastStateValue = tempstore{state}{3};
        if(tempstore{state}{5} == 1)
            % left right up down
            intermediateValues = [0 0 0 0];

            % top side
            if(any(strcmp({'A'}, statesWithPolicies{state}{1})))
                % right
                intermediateValues(2) = (10 + gamma * statesWithPolicies{22}{3});

                % left
                intermediateValues(1) = (10 + gamma * statesWithPolicies{22}{3});

                % up
                intermediateValues(3) = (10 + gamma * statesWithPolicies{22}{3});

                % down
                intermediateValues(4) =  (10 + gamma * statesWithPolicies{22}{3});
            elseif(any(strcmp({'B'}, statesWithPolicies{state}{1})))
                % right
                intermediateValues(2) = (5 + gamma * statesWithPolicies{19}{3});

                % left
                intermediateValues(1) = (5 + gamma * statesWithPolicies{19}{3});

                % up
                intermediateValues(3) = (5 + gamma * statesWithPolicies{19}{3});

                % down
                intermediateValues(4) = (5 + gamma * statesWithPolicies{19}{3});
            elseif(any(strcmp({'2'}, statesWithPolicies{state}{1})))
                % right
                intermediateValues(2) = (gamma * statesWithPolicies{state+1}{3});

                % left
                intermediateValues(1) = (gamma * statesWithPolicies{state-1}{3});

                % up
                intermediateValues(3) = (-1 + gamma * statesWithPolicies{state}{3});

                % down
                intermediateValues(4) = (gamma * statesWithPolicies{state+5}{3});
            % right side
            elseif(any(strcmp({'9', '14', '19'}, statesWithPolicies{state}{1})))
                % right
                intermediateValues(2) = (-1 + gamma * statesWithPolicies{state}{3});

                % left
                intermediateValues(1) = (gamma * statesWithPolicies{state-1}{3});

                % up
                intermediateValues(3) = (gamma * statesWithPolicies{state-5}{3});

                % down
                intermediateValues(4) = (gamma * statesWithPolicies{state+5}{3});
            % bottom side
            elseif(any(strcmp({'Ad', '22', '23'}, statesWithPolicies{state}{1})))
                % right
                intermediateValues(2) = (gamma * statesWithPolicies{state+1}{3});

                % left
                intermediateValues(1) = (gamma * statesWithPolicies{state-1}{3});

                % up
                intermediateValues(3) = (gamma * statesWithPolicies{state-5}{3});

                % down
                intermediateValues(4) = (-1 + gamma * statesWithPolicies{state}{3});
            % left side
            elseif(any(strcmp({'5', '10', '15'}, statesWithPolicies{state}{1})))
                % right
                intermediateValues(2) = (gamma * statesWithPolicies{state+1}{3});

                % left
                intermediateValues(1) = (-1 + gamma * statesWithPolicies{state}{3});

                % up
                intermediateValues(3) = (gamma * statesWithPolicies{state-5}{3});

                % down
                intermediateValues(4) = (gamma * statesWithPolicies{state+5}{3});
            % corners
            elseif('0' == statesWithPolicies{state}{1})
                % right
                intermediateValues(2) = (gamma * statesWithPolicies{state+1}{3});

                % left
                intermediateValues(1) = (-1 + gamma * statesWithPolicies{state}{3});

                % up
                intermediateValues(3) = (-1 + gamma * statesWithPolicies{state}{3});

                % down
                intermediateValues(4) = (gamma * statesWithPolicies{state+5}{3});
            elseif('4' == statesWithPolicies{state}{1})
                % right
                intermediateValues(2) = (-1 + gamma * statesWithPolicies{state}{3});

                % left
                intermediateValues(1) = (gamma * statesWithPolicies{state-1}{3});

                % up
                intermediateValues(3) = (-1 + gamma * statesWithPolicies{state}{3});

                % down
                intermediateValues(4) = (gamma * statesWithPolicies{state+5}{3});
            elseif('24' == statesWithPolicies{state}{1})
                % right
                intermediateValues(2) = (-1 + gamma * statesWithPolicies{state}{3});

                % left
                intermediateValues(1) = (gamma * statesWithPolicies{state-1}{3});

                % up
                intermediateValues(3) = (gamma * statesWithPolicies{state-5}{3});

                % down
                intermediateValues(4) = (-1 + gamma * statesWithPolicies{state}{3});
            elseif('20' == statesWithPolicies{state}{1})
                % right
                intermediateValues(2) = (gamma * statesWithPolicies{state+1}{3});

                % left
                intermediateValues(1) = (-1 + gamma * statesWithPolicies{state}{3});

                % up
                intermediateValues(3) = (gamma * statesWithPolicies{state-5}{3});

                % down
                intermediateValues(4) = (-1 + gamma * statesWithPolicies{state}{3});
            % All other cases
            else
                % right
                intermediateValues(2) = (gamma * statesWithPolicies{state+1}{3});

                % left
                intermediateValues(1) = (gamma * statesWithPolicies{state-1}{3});

                % up
                intermediateValues(3) = (gamma * statesWithPolicies{state-5}{3});

                % down
                intermediateValues(4) = (gamma * statesWithPolicies{state+5}{3});
            end

            maxval = max(intermediateValues);
            lia = ismember(intermediateValues, maxval);
            idx = find(lia);

            policy = '';
            equalityCheck = [0, 0, 0, 0];
            for i = 1:numel(idx)
                if(idx(i) == 1)
                    policy = policy + "←";
                end
                if(idx(i) == 2)
                    policy = policy + "→";
                end
                if(idx(i) == 3)
                    policy = policy + "↑";
                end
                if(idx(i) == 4)
                    policy = policy + "↓";
                end
            end
            
            tempstore{state}{2} = policy;
            tempstore{state}{3} = maxval;
            
            delta = max(delta, abs(lastStateValue - tempstore{state}{3}));
        end
    end

    statesWithPolicies = tempstore;
    if(delta < accuracyfactor)
        innerloop = 0;
    end
    valueIterIndex = valueIterIndex + 1;
    printPolicy(statesWithPolicies, valueIterIndex-1, 0)
end

lastComputation(statesWithPolicies, gamma);

function lastComputation(statesWithPolicies, gamma)
    tempstore = statesWithPolicies;
    for state=1:25
        % left right up down
        intermediateValues = [0 0 0 0];

        % top side
        if(any(strcmp({'A'}, statesWithPolicies{state}{1})))
            % right
            intermediateValues(2) = (10 + gamma * statesWithPolicies{22}{3});

            % left
            intermediateValues(1) = (10 + gamma * statesWithPolicies{22}{3});

            % up
            intermediateValues(3) = (10 + gamma * statesWithPolicies{22}{3});

            % down
            intermediateValues(4) =  (10 + gamma * statesWithPolicies{22}{3});
        elseif(any(strcmp({'B'}, statesWithPolicies{state}{1})))
            % right
            intermediateValues(2) = (5 + gamma * statesWithPolicies{19}{3});

            % left
            intermediateValues(1) = (5 + gamma * statesWithPolicies{19}{3});

            % up
            intermediateValues(3) = (5 + gamma * statesWithPolicies{19}{3});

            % down
            intermediateValues(4) = (5 + gamma * statesWithPolicies{19}{3});
        elseif(any(strcmp({'2'}, statesWithPolicies{state}{1})))
            % right
            intermediateValues(2) = (gamma * statesWithPolicies{state+1}{3});

            % left
            intermediateValues(1) = (gamma * statesWithPolicies{state-1}{3});

            % up
            intermediateValues(3) = (-1 + gamma * statesWithPolicies{state}{3});

            % down
            intermediateValues(4) = (gamma * statesWithPolicies{state+5}{3});
        % right side
        elseif(any(strcmp({'9', '14', '19'}, statesWithPolicies{state}{1})))
            % right
            intermediateValues(2) = (-1 + gamma * statesWithPolicies{state}{3});

            % left
            intermediateValues(1) = (0 + gamma * statesWithPolicies{state-1}{3});

            % up
            intermediateValues(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            intermediateValues(4) = (0 + gamma * statesWithPolicies{state+5}{3});
        % bottom side
        elseif(any(strcmp({'Ad', '22', '23'}, statesWithPolicies{state}{1})))
            % right
            intermediateValues(2) = (0 + gamma * statesWithPolicies{state+1}{3});

            % left
            intermediateValues(1) = (0 + gamma * statesWithPolicies{state-1}{3});

            % up
            intermediateValues(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            intermediateValues(4) = (-1 + gamma * statesWithPolicies{state}{3});
        % left side
        elseif(any(strcmp({'5', '10', '15'}, statesWithPolicies{state}{1})))
            % right
            intermediateValues(2) = (0 + gamma * statesWithPolicies{state+1}{3});

            % left
            intermediateValues(1) = (-1 + gamma * statesWithPolicies{state}{3});

            % up
            intermediateValues(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            intermediateValues(4) = (0 + gamma * statesWithPolicies{state+5}{3});
        % corners
        elseif('0' == statesWithPolicies{state}{1})
            % right
            intermediateValues(2) = (0 + gamma * statesWithPolicies{state+1}{3});

            % left
            intermediateValues(1) = (-1 + gamma * statesWithPolicies{state}{3});

            % up
            intermediateValues(3) = (-1 + gamma * statesWithPolicies{state}{3});

            % down
            intermediateValues(4) = (0 + gamma * statesWithPolicies{state+5}{3});
        elseif('4' == statesWithPolicies{state}{1})
            % right
            intermediateValues(2) = (-1 + gamma * statesWithPolicies{state}{3});

            % left
            intermediateValues(1) = (0 + gamma * statesWithPolicies{state-1}{3});

            % up
            intermediateValues(3) = (-1 + gamma * statesWithPolicies{state}{3});

            % down
            intermediateValues(4) = (0 + gamma * statesWithPolicies{state+5}{3});
        elseif('24' == statesWithPolicies{state}{1})
            % right
            intermediateValues(2) = (-1 + gamma * statesWithPolicies{state}{3});

            % left
            intermediateValues(1) = (0 + gamma * statesWithPolicies{state-1}{3});

            % up
            intermediateValues(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            intermediateValues(4) = (-1 + gamma * statesWithPolicies{state}{3});
        elseif('20' == statesWithPolicies{state}{1})
            % right
            intermediateValues(2) = (0 + gamma * statesWithPolicies{state+1}{3});

            % left
            intermediateValues(1) = (-1 + gamma * statesWithPolicies{state}{3});

            % up
            intermediateValues(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            intermediateValues(4) = (-1 + gamma * statesWithPolicies{state}{3});
        % All other cases
        else
            % right
            intermediateValues(2) = (0 + gamma * statesWithPolicies{state+1}{3});

            % left
            intermediateValues(1) = (0 + gamma * statesWithPolicies{state-1}{3});

            % up
            intermediateValues(3) = (0 + gamma * statesWithPolicies{state-5}{3});

            % down
            intermediateValues(4) = (0 + gamma * statesWithPolicies{state+5}{3});
        end

        maxval = max(intermediateValues);
        lia = ismember(intermediateValues, maxval);
        idx = find(lia);

        policy = '';
        for i = 1:numel(idx)
            if(idx(i) == 1)
                policy = policy + "←";
            end
            if(idx(i) == 2)
                policy = policy + "→";
            end
            if(idx(i) == 3)
                policy = policy + "↑";
            end
            if(idx(i) == 4)
                policy = policy + "↓";
            end
        end
        tempstore{state}{2} = policy;
    end
    fprintf('\n\n')
    
    printPolicy(tempstore, 0, 1)
end

function printPolicy(statesWithPolicies, policyNumber, optimal)
    temporary = statesWithPolicies;
    for final = 1:25
        if(optimal == 0)
            temporary{final}(2) = [];
            temporary{final}(3) = [];
            temporary{final}(3) = [];
        else
            temporary{final}(4) = [];
            temporary{final}(4) = [];
        end
    end
    t = cell2table(transpose(temporary),'VariableNames',{'Column-1', 'Column-2', 'Column-3', 'Column-4', 'Column-5'});
    fig = uifigure;
    if(optimal == 0)
        fig.Name = ['Value Iteration: ',  num2str(policyNumber)];
    else
        fig.Name = 'Optimal Value & Policy';
    end
    fig.Position(3) = 1000;
    
    uitable(fig,'Data',t, 'ColumnWidth',{199, 199,  199, 199, 199}, 'Position',[10 10 1000 300]);
end
