% Create actionlist from solution
function ActionList=CreatePermActionList(n)

    %% *** NEED improvements and understanding
    nMove=n*2;

    % ***
    % nReversion=n*2;
    % nInsertion=n^2;
    nAction=nMove; % +nReversion+nInsertion;
    
    ActionList=cell(nAction,1);
    
    c=0;

    % Add SWAP/MOVE
    for i=1:nMove
        c=c+1;
        tid=floor((i+1)/2);
        jump=[-20 -10 -1 1 10 20];
        sdir=jump(mod(i,6)+1);
        ActionList{c}=[1 tid sdir];
    end
    % ***
%     % Add REVERSION
%     for i=1:n-1
%         for j=i+1:n
%             if abs(i-j)>2
%                 c=c+1;
%                 ActionList{c}=[2 i j];
%             end
%         end
%     end
%     
%     % Add Insertion
%     for i=1:n
%         for j=1:n
%             if abs(i-j)>1
%                 c=c+1;
%                 ActionList{c}=[3 i j];
%             end
%         end
%     end
    ActionList=ActionList(1:c);
    %%
end