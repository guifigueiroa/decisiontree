%load iris.data

%X = sparse(iris(:,1:4));
%Y = iris(:,5:5);


% Load tf-idf sparse table
X = load('tfidfSparseDF5.txt');
X = spconvert(X);

% Load classes
Y = load('classesDF5.txt');

% Discretize variables (all)
disp('Discretizando campos');
for i=1:size(X,2)
    X(:,i) = discretize(X(:,i),Y);
end

disp('Aplicando holdout');
[training_data, training_classes, testing_data, testing_classes] = holdout(X,Y);

% generate decision tree
disp('Treinando árvore');
root = decisiontree_training(training_data, training_classes);

accuracy = zeros(length(testing_data),1);

disp('Classificando dados de teste');
for i=1:length(testing_data)
    class = classify(root,testing_data(i,:));
    accuracy(i) = class == testing_classes(i);
end

accuracy = sum(accuracy)/length(accuracy)