function par = GetParameters(dirpath)
    %GETPARAMETERS Summary of this function goes here
    %   Detailed explanation goes here
    
    timelines=1;    % 3:30
    tasks=10;       % 10^4
    complexity=1; %1, 2, 3
    tl_length=100; % 10^9
    weight_overlaycost = 1; % variable
    max_iterations=400;
    
    
    par.tls = timelines;
    par.tl_len = tl_length;
    
    par.tks = tasks;
    par.meanlen = 50;
    par.varlen = 10;
    par.cmp = complexity;
    par.w_ocost = weight_overlaycost;
    par.max_it=max_iterations;
end