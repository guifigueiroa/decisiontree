%load iris.data

%X = sparse(iris(:,1:4));
%Y = iris(:,5:5);

% Load tf-idf sparse table
X = load('tfidfSparse15-1000.txt');
X = spconvert(X);

% Load classes
Y = load('classes15-1000.txt');

% Discretize variables (all)
for i=1:size(X,2)
    disp('Discretizando campos');
    i
    X(:,i) = discretize(X(:,i),Y);
end

[training_data, training_classes, testing_data, testing_classes] = holdout(X,Y);

% define quantity of random trees
B = 10;
randomForest = cell(B,1);

% TRAINING
for i=1:B
    disp('Training tree');
    i
    
    % Sample with replacement using bootstrap
    [sampleX, sampleY] = bootstrap(training_data, training_classes);
    
    % generate random decision tree
    randomForest{i} = decisiontree_training(sampleX, sampleY);
end

% TESTING
accuracy = zeros(size(testing_data,1),1);
disp('Testing forest');
for j=1:size(testing_data,1)
    classes = zeros(B,1);
    j
    for i=1:B
        % classify data
        classes(i) = classify(randomForest{i},testing_data(j,:));
    end

    accuracy(j) = testing_classes(j) == mode(classes);
end

sum_accuracy = sum(accuracy)/length(accuracy)
