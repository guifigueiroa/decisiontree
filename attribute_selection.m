function [ best_attrib ] = attribute_selection( X, Y, attribute_list )
    
    infoD = entropy(Y);
    
    best_gain = 0;
    best_attrib = 0;
    
    for i=find(attribute_list==1)'
        newInfo = info(X(:,i),Y);
        
        gain = infoD - newInfo;
        
        if gain > best_gain
           best_gain = gain;
           best_attrib = i;
        end
    end
end

