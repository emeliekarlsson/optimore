%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA116
% Project Title: Implementation of Tabu Search for TSP
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all;

%% Problem Definition

% 1.
% Create Scheduling Model
par = GetParameters();
model = CreateModel(par);      
% Create Empty Individual Structure
bestsol.Model=[];
bestsol.Cost=[];
bestsol.Par=[];
% Create Initial Solution
sol=bestsol;
sol.Par=par;

% 2.
% 
CostFunction=@(sol) CostFunction(sol);    % Cost Function
ActionList=CreatePermActionList(model.ntk);    % Action List
nAction=numel(ActionList);              % Number of Actions

% 3. Tabu Search Parameters
%
MaxIt=50; % Maximum Number of Iterations

TL=round(0.5*nAction); % Tabu Length

% Initialization

% Create Empty Individual Structure
bestsol.Model=[];
bestsol.Cost=[];
bestsol.Par=[];

% Create Initial Solution
sol=bestsol;
sol.Par=par;

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

%%
sol.Cost=CostFunction(sol);

% Initialize Best Solution Ever Found
BestSol=sol;

% Array to Hold Best Costs
BestCost=zeros(MaxIt,1);

% Initialize Action Tabu Counters
TC=zeros(nAction,1);


%% Tabu Search Main Loop

for it=1:MaxIt
    
    bestnewsol.Cost=inf;
    
    % Apply Actions
    for i=1:nAction
        if TC(i)==0
            newsol.Position=DoAction(sol.Position,ActionList{i});
            newsol.Cost=CostFunction(newsol.Position);action
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
            TC(i)=TL;               % Add To Tabu List
        else
            TC(i)=max(TC(i)-1,0);   % Reduce Tabu Counter
        end
    end
    
    % Update Best Solution Ever Found
    if sol.Cost<=BestSol.Cost
        BestSol=sol;
    end
    
    % Save Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Plot Best Solution
    figure(1);
    PlotSolution(BestSol, model);
    pause(0.01);
    
    % If Global Minimum is Reached
    if BestCost(it)==0
        break;
    end
    
end

BestCost=BestCost(1:it);

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
