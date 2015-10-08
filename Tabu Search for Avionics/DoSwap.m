%% Swap/move on task one step (in each direction)
function q=DoSwap(p,id,sdir)
    q=p;
    q.all_t{id}.s=q.all_t{id}.s+sdir;    
end