function [ Y ] = classify( N, X )

    if N.leaf == true
        Y = N.class;
    else
        for i=1:length(N.conditions)
            if X(N.attribute) == N.conditions(i)
                Y = classify(N.vertices(i),X);
            end
        end
    end


end
