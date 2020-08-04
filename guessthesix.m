function container=guessthesix(Q,W,bsize,no)

for l=no-1:-1:2 % if 6 elements are not found corresponding to a single y width or y coordinate ,we try to find if 2-5 characters can be found
    val=find(Q==l); 
    var=length(val);
    if isempty(var) || var == 1 % when only one class is found within particular frequency
        if val == 1
            index=val+1; 
        else
            index=val; 
        end
        if length(Q)==val
            index=[];    
        end
        if Q(index)+Q(index+1) == no %trying to find whether two consecutive class contains 6 characters
            container=[W(index)-(bsize/2) W(index+1)+(bsize/2)]; %if two consecutive class contains two characters,we change the bin size and return t as output
            break;                                               
        elseif Q(index)+Q(index-1) == no % this loop performs the same function as above only with the preceeding class
            container=[W(index-1)-(bsize/2) W(index)+(bsize/2)]; 
            break;                                               
        end
    else 
        for k=1:1:var % if more than one class is found for one particular frequency, we repeat the above algorithm for every class
            if val(k)==1
                index=val(k)+1; 
            else
                index=val(k); 
            end
            if length(Q)==val(k) 
                index=[];        
            end
            if Q(index)+Q(index+1) == no
                container=[W(index)-(bsize/2) W(index+1)+(bsize/2)];
                break;
            elseif Q(index)+Q(index-1) == no
                container=[W(index-1)-(bsize/2) W(index)+(bsize/2)];
                break;
            end
        end
        if k~=var
            break;
        end
    end
end
if l==2 
    container=[];
end
end