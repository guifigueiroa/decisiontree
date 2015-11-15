function [ result ] = info_split( attribute_split, Y )

qt_instances = length(attribute_split);
classes = unique(Y);

result = 0;

for i=1:length(classes)
    proportion = (sum(attribute_split==classes(i))/qt_instances);
    attribute_entropy = entropy(Y(attribute_split==classes(i)));
    
    result = result + (proportion * attribute_entropy);
end

end
