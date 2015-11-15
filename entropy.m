function [ result ] = entropy(X);

[occurrences,] = hist(X, unique(X));

qt_instances = sum(occurrences);

result =  sum(-(occurrences./qt_instances) .* log2(occurrences./qt_instances));

end