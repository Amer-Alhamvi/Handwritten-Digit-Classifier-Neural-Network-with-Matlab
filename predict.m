function persentage = predict(X,y, weights)
    % propagation
    [a, ~] = propagate(X,weights);
    
    % one-vs-all
    [~, c] = max(a{1, end}, [], 2);

    if length(y(1,:)) > 1
        b = (1:10) == c;
        % calculate correctness
        correct_matches = 0;
        for i = 1:length(b)
            if isequal(y(i,:), b(i, :))
                correct_matches = correct_matches + 1;
            end
        end
    else
        y(y==0) = 10;
        correct_matches = sum(y == c);
    end
    % return persentage
    persentage = (correct_matches / length(c)) * 100;

end