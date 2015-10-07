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

function C=CostFunction(sol)

    model = sol.Model;
    par = sol.Par;
    
    w_ocost = par.w_ocost;
    tls = model.all_tl;
    tks = model.all_t;
    
    ntl=numel(tls);
    ntk=numel(tks);
    C=0;
  
    % Iterate tasks:
    for it=1:ntk
        t_ocost=0;
        
        for iit=1:ntk
            if tks{it}.e > tks{iit}.s & tks{it}.tlid==tks{iit}.tlid
                if tks{it}.s <tks{iit}.e
                    t_ocost=t_ocost+w_ocost;
                end
            end
            if it~=iit
                C=C+t_ocost;
            end
        end
        
        
        % **** COST OF OUT OF BOUNDS
        % if tks{it}.e >
        
        
    end

    % model.all_cost=[];
end