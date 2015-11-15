%load iris.data

%X = sparse(iris(:,1:4));
%Y = iris(:,5:5);

% Discretize variables (all)
%for i=1:size(X,2)
%    X(:,i) = discretize(X(:,i),Y);
%end

[training_data, training_classes, testing_data, testing_classes] = holdout(X,Y);

% generate decision tree
root = decisiontree_training(training_data, training_classes);

accuracy = zeros(length(testing_data),1);

for i=1:length(testing_data)
    class = classify(root,testing_data(i,:));
    accuracy(i) = class == testing_classes(i);
end

accuracy = sum(accuracy)/length(accuracy)
