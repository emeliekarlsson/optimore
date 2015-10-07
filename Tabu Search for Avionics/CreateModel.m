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

function model=CreateModel(par)
    %%
    model.ntk=par.tks;
    model.ntl=par.tls;
    depmean = 0;  
    error = 0;
    try
        if par.tks == 0
            error = 1;
            fprintf('ERROR 1 occured\n')
        elseif (par.tls < 1)
            error = 1;
            fprintf('ERROR 2 occured\n')
        end
        
    catch ME
        fprintf('Error importing parameters to CrateModel\n');
        error = 1;
        rethrow(ME)
    end
    
    % Need better error handling
    if (error)
        fprintf('ERROR 3 occured\n')
    end
    
    %% decide complexity of data:
    switch par.cmp
    case 1
        % A - data
        depmean = 0;
    case 2
        % B - data
        
        print('no B-data');
        % depmean = 3;        
    case 3
        % C - data
        
        print('no C-data');
        depmean = 30;
    end
    
    
    %%
    alltls = struct([]);
    alltasks = struct([]);
    
    % Create timelines:
    for idtls=1:par.tls
        alltls{idtls} = CreateTimelines(idtls, par.tl_len);
    end
    
    % Loop over all tasks:
    for tid=1:par.tks
        % 3. find what tl to use:
        mintl = struct('minid',0,'minval',0);
        
        for itl = 1:par.tls
            % find the shortest tl
            tl = alltls{itl};
            
            if mintl.minid == 0
                mintl.minid = itl;
                mintl.minval = tl.te;
            elseif tl.te < mintl.minval
                mintl.minid = itl;
                mintl.minval = tl.te;
            else
                ;
            end
        end
        
        % 4. Randomize task length:
        tlength = round(normrnd(par.meanlen,par.varlen));
        
        tlid = mintl.minid;
        tstart = mintl.minval+1;
        tend = tstart + tlength;
        
        % 4. Create task
        task = CreateTask(tid,tstart,tend,tlid,tlength,depmean);

        % 5. Place task on tl
        alltls{tlid}.tasks = [alltls{tlid}.tasks;task];

        % 6. 
        alltls{tlid}.te = tend;
        alltasks{tid} = task;
        
    end
    
    model.all_t = alltasks;
    model.all_tl = alltls;
    model.w_ocost=par.w_ocost;
end


function t = CreateTask(tid,tstart,tend,tlid,length,dependencies)
    t=struct('id',tid,'s',tstart,'e',tend,'tlid',tlid,'len',length,'dep',dependencies);
end

function tl = CreateTimelines(tlid,length)
    tl = struct('tlid',tlid,'length',length,'te',0,'tasks',[]);
end