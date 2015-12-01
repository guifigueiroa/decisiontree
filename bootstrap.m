function [X,Y] = bootstrap(X,Y)

    randIndexes = ceil(size(X,1) * rand(size(X,1),1));
    X = X(randIndexes,:);
    Y = Y(randIndexes,:);
    
end