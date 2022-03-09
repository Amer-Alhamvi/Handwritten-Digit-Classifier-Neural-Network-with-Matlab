function [a, z] = propagate(X, weights)
    % add bias to input
    a{1,1} = X;
    z = {};

    % Propagation
    for i = 2:length(weights)+1
        a{1, i-1} = [ones(size(a{1, i-1}, 1), 1) a{1, i-1}];
        z{1,i} = a{1,i-1} * weights{1,i-1}';
        a{1,i} = sigmoid(z{1,i});
    end
end

