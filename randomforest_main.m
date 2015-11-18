load iris.data

X = sparse(iris(:,1:4));
Y = iris(:,5:5);

% Discretize variables (all)
for i=1:size(X,2)
    X(:,i) = discretize(X(:,i),Y);
end

[training_data, training_classes, testing_data, testing_classes] = holdout(X,Y);

% define quantity of random trees
B = 500;
randomForest = cell(B,1);

% TRAINING
for i=1:B
    % Sample with replacement using bootstrap
    [sampleX, sampleY] = bootstrap(training_data, training_classes);
    
    % generate random decision tree
    randomForest{i} = decisiontree_training(sampleX, sampleY);
end

% TESTING
accuracy = zeros(length(testing_data),1);
for j=1:length(testing_data)
    classes = zeros(B,1);
    for i=1:B
        % classify data
        classes(i) = classify(randomForest{i},testing_data(j,:));
    end

    accuracy(j) = testing_classes(j) == mode(classes);
end

accuracy = sum(accuracy)/length(accuracy)
