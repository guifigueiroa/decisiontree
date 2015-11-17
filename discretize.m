function [ attribute ] = discretize( attribute, Y )

% calculate best splits for attribute
splits = sort(calculate_splits(attribute, Y));

splits = [min(attribute); splits; max(attribute)];

class = 0;

% Set classes according to splits calculated
for i=1:length(splits)-1
    attribute(find(attribute > splits(i) & attribute <= splits(i+1))) = class;
    
    class = class + 1;
end

end

