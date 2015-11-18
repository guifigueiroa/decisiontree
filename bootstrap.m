function [X,Y] = bootstrap(X,Y)

    randIndexes = ceil(length(X) * rand(length(X),1));
    X = X(randIndexes,:);
    Y = Y(randIndexes,:);
    
end