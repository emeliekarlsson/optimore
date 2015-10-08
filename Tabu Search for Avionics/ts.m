% Runs main script
%% Setup
clc;
clear;
% close all;
tic

% Problem Definition
% 1.
% Create Scheduling Model
res = [];
par = GetParameters();
model = CreateModel(par);      
% Create Empty Individual Structure
% Create Empty Individual Structure
sampsol.Model=[];
sampsol.Cost=[];
sampsol.Par=[];
sampsol.ActionIndex=0;
bestsol = sampsol;
% Create Initial Solution
sol=bestsol;
sol.Par=par;
% Initialization
ms=model.all_t;
for itl=1:model.ntl
    ntktl = length(model.all_tl{itl}.tasks);
    start = round((randperm(ntktl)+1)/ntktl*par.tl_len-par.meanlen);
    for itk=1:ntktl
        ms{itk}.s=start(itk);
        ms{itk}.e=ms{itk}.s+ms{itk}.len;
    end
end
% Update model:
model.all_t=ms;
sol.Model=model;

% 2.
CostFunction=@(sol) CostFunction(sol);    % Cost Function
ActionList=CreatePermActionList(sol.Model.ntk);    % Action List
nAction=numel(ActionList);              % Number of Actions

% 3. Tabu Search Parameters
MaxIt=par.max_it; % Maximum Number of Iterations
TL=round(0.5*nAction); % Tabu Length
sol.Cost=CostFunction(sol);
% Initialize Best Solution Ever Found
BestSol=sol;
% Array to Hold Best Costs
BestCost=zeros(MaxIt,1);
% Initialize Action Tabu Counters
TC=zeros(nAction,1);
toc

% Tabu Search Main Loop
clc
tic
fprintf('Initialised tabu search:\n--------------------------\nTotal cost:\nit: 1: ');
res = zeros(MaxIt,2);
iii=1;
for it=1:MaxIt
    
    bestnewsol.Cost=inf;
    %fprintf('Iteraton %i: ',it)
    % Apply Actions
    for i=1:nAction
        if TC(i)==0
            newsol=sol;            
            newsol.Par=sol.Par; % *** SLOW
            newsol.Model=DoAction(sol.Model,ActionList{i});
            newsol.Cost=CostFunction(newsol); 
            newsol.ActionIndex=i;

            if newsol.Cost<=bestnewsol.Cost
                bestnewsol=newsol;
            end
        end
    end
    
    % Update Current Solution
    sol=bestnewsol;
    % Update Tabu List
    for i=1:nAction
        if i==bestnewsol.ActionIndex
            inx=
            
            TC(i)=TL;               % Add To Tabu List
        else
            TC(i)=max(TC(i)-1,0);   % Reduce Tabu Counter
        end
    end
    % Update Best Solution Ever Found
    if sol.Cost<=BestSol.Cost
        
        if sol.Cost<BestSol.Cost
            fprintf('%i ',sol.Cost);
            iii=iii+1;
        end
        BestSol=sol;
    end
    % Save Best Cost Ever Found
    BestCost(it)=BestSol.Cost; 
   % Plot Best Solution
    figure(1);
    %PlotSolution(BestSol, model);
    
    % If Global Minimum is Reached
    if BestCost(it)==0
        fprintf('Global optima.\n')
        break;
    end
    

    if mod(iii,15)==0
        fprintf('\nit: %i: ',it);
    end
    
    res(it,:)=[it,newsol.Cost];
end

BestCost=BestCost(1:it);

fprintf('\n');
plot(res(:,2))
toc;

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
