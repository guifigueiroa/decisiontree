function [ training_data, training_classes, testing_data, testing_classes ] = holdout( X,Y )
    nfold = 3;
    classes = unique(Y);
    
    % Inicializa Xc e Yc
    for i=1:nfold
        Xc{i} = [];
        Yc{i} = [];
    end
    
    % Para cada classe
	for i=1:length(classes)
        % Obtem dados correspondentes a classe
        pos = find(Y==classes(i));
        data = X(pos,:);
        
        % Deixa dados aleatórios
        data = data(randperm(size(data,1)),:);
        
        % Calcula quantidade de elementos por fold
        fold = floor(size(data,1)/nfold);
        resto = mod(size(data,1),nfold);
        
        % Divide lista em nfolds e coloca em Xc (preenche Yc com classes)
        for j=1:nfold
            for k=1:fold
                Xc{j} = cat(1, Xc{j}, data((j*fold)-(fold-k),:));
                Yc{j} = cat(1, Yc{j}, classes(i));
            end
        end
        
        % Preenche restos
        j=1;
        while resto>0
            Xc{j} = cat(1, Xc{j}, data(size(data,1)+1-resto,:));
            Yc{j} = cat(1, Yc{j}, classes(i));
            j=j+1;
            resto=resto-1;
        end
    end
    
    training_data = [Xc{1}; Xc{2}];
    training_classes = [Yc{1}; Yc{2}];
    testing_data = Xc{3};
    testing_classes = Yc{3};
end