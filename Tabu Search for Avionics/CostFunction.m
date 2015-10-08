% Evaluate the target/cost function for solution
function C=CostFunction(sol)
%%
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
        %fprintf('%d\n',it)
        t_ocost=0;
        for iit=1:ntk
            %tks
            %fprintf('%i ',it)
            %fprintf('%i\n',iit)
            if tks{it}.e > tks{iit}.s & tks{it}.tlid==tks{iit}.tlid
                if tks{it}.s <tks{iit}.e & it~=iit
                    t_ocost=t_ocost+w_ocost;
                end
            end
        end
        C=C+t_ocost;
        % fprintf('%i\n',C);
    end
    %% model.all_cost=[];
end