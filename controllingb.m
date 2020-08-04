function r=controllingb(NR,no)

[Q,W]=hist(NR(:,4)); % Q contains the number of objects corresponding to each y-width dimension
ind=find(Q==no); % trying to find out which y-width corresponds to 6 elements



%% Now if the Q does not contain 6 , we the multiply the y coordinates with y width to find out 
% which of this product corresponds to 6 elements
for k=1:length(NR)   
    C_5(k)=NR(k,2) * NR(k,4);% multiplying y coordinate with y width
end
NR2=cat(2,NR,C_5');  % adding the multiplication result as 5th column of NR
[E,R]=hist(NR2(:,5));
Y=find(E==no); % finding which of these multiplication result corresponds to 6 elements         

%% now we try to find out the information about the bounding boxes that contains the characters


if length(ind)==1 
    MP=W(ind);  
    binsize=W(2)-W(1); % calculating the class size of each class in histogram
    container=[MP-(binsize/2) MP+(binsize/2)]; % finding the domain of y-widths corresponding to the characters 
    r=takeboxes(NR,container,2);
elseif length(Y)==1
    MP=R(Y);
    binsize=R(2)-R(1);
    container=[MP-(binsize/2) MP+(binsize/2)]; 
    r=takeboxes(NR2,container,2.5); 
 %% when neither Q or Y contains 6 elements, the we use y coordinate the sole parameter to find 6 characters
elseif isempty(ind) || length(ind)>1 
    [A,B]=hist(NR(:,2),20);
    ind2=find(A==6);
    if length(ind2)==1
        MP=B(ind2);
        binsize=B(2)-B(1);
        container=[MP-(binsize/2) MP+(binsize/2)]; 
        r=takeboxesb(NR,container,1);
        %% if the above works fail too, then we try to guess the boxes
    else
        container=guessthesix(A,B,(B(2)-B(1)),no); 
        if ~isempty(container) % if the guessing function fails,we again perform 
% box taking with narrowing down the search net		
            r=takeboxes(NR,container,1); 
        elseif isempty(container)
            container2=guessthesix(E,R,(R(2)-R(1)),no);
            if ~isempty(container2)
                r=takeboxes(NR2,container2,2.5);
            else
                r=[]; 
            end
        end
    end
end
end