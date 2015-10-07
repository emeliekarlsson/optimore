%% plots try
clf
clc
figure(1)
hold on

for i=1:model.ntk
    
    model.all_t{i}.len;
    
    n = model.all_t{i}.len;
    t = model.all_t{i};
    
    ts = t.s;
    tlid=model.all_t{i}.tlid;
    
    if tlid==1
        plot(ts,tlid,'g*')
        plotv([ts:ts+n; tlid*ones(n+1,1)],'-')
        plot(ts+n,tlid,'r*')
    elseif tlid==2
        plot(ts,tlid,'g*')
        plotv([ts:ts+n; tlid*ones(n+1,1)],'-')
        plot(ts+n,tlid,'r*')
    elseif tlid==3
        plot(ts,tlid,'g*')
        plotv([ts:ts+n; tlid*ones(n+1,1)],'-')
        plot(ts+n,tlid,'--rs')
    end
    
    
    
end