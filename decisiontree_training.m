function [N] = decisiontree_training(X, Y, attribute_list)

    if nargin < 3
        % initialise attribute list with ones
        attribute_list = ones(size(X,2),1);
    end

    N = struct('leaf', false, 'attribute', 'null', 'conditions', [], 'vertices', [], 'class', 'null');
    
    % if tuples are all of the same class
    if length(unique(Y)) == 1
       N.class = Y(1);
       N.leaf = true;
       return;
    end
    
    % if attribute list is empty
    if sum(attribute_list) == 0 || length(X) < 5
       N.class = mode(Y);
       N.leaf = true;
       return;
    end
    
    % find best attribute for node (higher gain)
    N.attribute = attribute_selection(X, Y, attribute_list);    
    if N.attribute == 0
        N.class = mode(Y);
        N.leaf = true;
        return;
    end
    
    % remove attribute    
    attribute_list(N.attribute) = 0; 
    
    % for each outcome partition tuple
    outcomes = unique(X(:,N.attribute));
    for i=1:length(outcomes)        
        pos = find(X(:,N.attribute)==outcomes(i));
        newX = X(pos,:);
        newY = Y(pos,:);
        
        N.conditions = [N.conditions outcomes(i)];
        N.vertices = [N.vertices decisiontree_training(newX, newY, attribute_list)];
    end
end