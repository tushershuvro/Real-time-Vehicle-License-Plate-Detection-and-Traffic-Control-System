function r=takeboxes(NR,container,chk)
takethisbox=[]; % Initialize the variable to an empty matrix.
for i=1:size(NR,1)
    if NR(i,(2*chk))>=container(1) && NR(i,(2*chk))<=container(2) % finding boxes containing characters
        takethisbox=cat(1,takethisbox,NR(i,:));
    end
end
r=[];
for k=1:size(takethisbox,1)
    var=find(takethisbox(k,1)==reshape(NR(:,1),1,[])); 
    if length(var)==1                                 
        r=[r var];% if the box contains one character condition works                                 
    else                                               
        for v=1:length(var)                            
            M(v)=NR(var(v),(2*chk))>=container(1) && NR(var(v),(2*chk))<=container(2);% if the box contains more than one characters this condition works
        end
        var=var(M);
        r=[r var];% r contains the indices of rows of NR corresponding to each character
    end
end
end
