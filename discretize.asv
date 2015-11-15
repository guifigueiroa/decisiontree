function [ discrete_attr ] = discretize( attribute, Y )

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
       split_info = info_split(attribute_split, Y);

       gain = infoD - split_info;

       if gain > best_gain
           best_gain = gain;
           best_split=possible_splits(i);
       end
   end
end

discrete_attr = (attribute<=best_split);

end

