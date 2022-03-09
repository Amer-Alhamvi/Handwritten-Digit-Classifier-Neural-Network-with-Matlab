function [persentage, confusion_matrix] = predict_confusionM(X,y, weights)
% propagation
    [a, ~] = propagate(X,weights);
    confusion_matrix = zeros(3,10);
    confusion_matrix(1,:) = sum(y,1);

    % one-vs-all
    [~, c] = max(a{1, end}, [], 2);
    b = (1:10) == c;
    a{1, end} = b;
   
    

    % calculate correctness
    check = zeros(length(a{1, end}),1);
    persentage = 0;
    for i = 1:length(a{1, end})
        [~, ind] = max(a{1, end}(i, :));
        [~,y_ind] = max(y(i, :));
        if ind == y_ind
            check(i) = 1;
            persentage = persentage + 1;  
        else
            confusion_matrix(2,y_ind) = confusion_matrix(2,y_ind) + 1;
        end
        
    end
    % return persentage
    confusion_matrix(3,:) = (confusion_matrix(2,:) ./ confusion_matrix(1,:)) * 100;
    persentage = (persentage / length(a{1, end})) * 100;
end

