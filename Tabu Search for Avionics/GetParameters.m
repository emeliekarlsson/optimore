function par = GetParameters(dirpath)
    %GETPARAMETERS Summary of this function goes here
    %   Detailed explanation goes here
    
    timelines=3;
    tasks=100;
    complexity=1; %1, 2, 3
    tl_length=10^3; % 10^9
    weight_overlaycost = 1;
    
    
    par.tls = timelines;
    par.tl_len = tl_length;
    
    par.tks = tasks;
    par.meanlen = 50;
    par.varlen = 10;
    par.cmp = complexity;
    par.w_ocost = weight_overlaycost;
end