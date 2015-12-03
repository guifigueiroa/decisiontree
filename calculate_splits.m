function [ splits ] = calculate_splits( attribute, Y, splits )

if nargin < 3
   splits = []; 
end

% Set minimum tuples for each class
if length(attribute) < 2500
    return;
end

% Set min split size
minSplit = 0.20  * length(attribute);

infoD = entropy(Y);

best_gain = 0;
best_split=0;
possible_splits = sort(unique(attribute));

% test gain from each split
for i=1:length(possible_splits)

   attribute_split = attribute<=possible_splits(i);
   
   % if sppliting point has enough instances (minsplit)
   if sum(attribute_split) > minSplit
       % calculate new info and gain
       split_info = info_split(attribute_split, Y);

       gain = infoD - split_info;

       % if gain got better
       if gain > best_gain
           best_gain = gain;
           best_split=possible_splits(i);
       end
   end
end

% if split point is already included
if any(splits==best_split)
    return;
end

splits = [splits; best_split];

% recursion for both sides
splits1 = calculate_splits(attribute(find(attribute<=best_split)), Y, splits);
splits2 = calculate_splits(attribute(find(attribute>best_split)), Y, splits);

splits = unique([splits1; splits2]);

end

