function [ result ] = info( X, Y )

qt_instances = length(X);
categories = unique(X);

result = 0;

for i=1:length(categories)
    proportion = sum(X==categories(i))/qt_instances;
    category_entropy = entropy(Y(X==categories(i)));
    
    result = result + (proportion * category_entropy);
end

end

