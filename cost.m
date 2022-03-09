function J = cost(a, y, m, weights, lambda)
    % cost function
    first = y .* log(a{1,end});
    second = first + (1-y);
    third = second .* log(1 - a{1,end});
    forth = sum(third);
    finally = sum(forth);

    J = finally;
    J = -1 * J / m;
    
    % Regularization
    reg = 0;
    for i = 1:length(weights)
        reg = reg + sum(sum(weights{i}.^2));
    end

    J = J + ((lambda * reg) / (2 * m));
end