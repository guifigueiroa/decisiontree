function [N] = decisiontree_training(X, Y, originalX, attribute_list)

    if nargin < 3
       originalX = X; 
    end

    if nargin < 4
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
    if sum(attribute_list) == 0 || length(X) < 300
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
    outcomes = unique(originalX(:,N.attribute));
    for i=1:length(outcomes)        
        pos = find(X(:,N.attribute)==outcomes(i));
        
        if isempty(pos)
            leafN = struct('leaf', true, 'attribute', 'null', 'conditions', [], 'vertices', [], 'class', mode(Y));
            N.conditions = [N.conditions outcomes(i)];
            N.vertices = [N.vertices leafN];
        else
            newX = X(pos,:);
            newY = Y(pos,:);
        
            N.conditions = [N.conditions outcomes(i)];
            N.vertices = [N.vertices decisiontree_training(newX, newY, originalX, attribute_list)];
        end
    end
end