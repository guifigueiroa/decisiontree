function [ Y ] = classify( N, X )
    
    % if leaf node, class found
    if N.leaf == true
        Y = N.class;
    else
        % check all conditions
        for i=1:length(N.conditions)
            if X(N.attribute) == N.conditions(i)
                Y = classify(N.vertices(i),X);
            end
        end
    end


end

