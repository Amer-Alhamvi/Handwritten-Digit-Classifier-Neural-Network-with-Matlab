function [J, new_weights] = train (weights, NN_arch, X, y, alpha, lambda)
    % some variables
    m = size(X,1);
    no_of_layers = size(NN_arch,2);

    % Propagation
    [a, z] = propagate(X, weights);

    % cost function
    J = cost(a, y, m, weights, lambda);
    
    %% Back Propagatoin

    %%% sigmas
    % start from sigma of last layer (no_of_layers)
    sigmas{no_of_layers} = a{1,no_of_layers} - y;
    % sigmas down to layer 2 (first hidden layer)
    for i = no_of_layers-1:-1:2
        f = sigmas{1,i+1} * weights{1,i}(:, 2:end);
        s = sigmoid_grad(z{1,i});
        sigmas{i} = f .* s;
    end

    %%% deltas
    % deltas are the partial derivatives
    for i = 1:no_of_layers-1
        deltas{i} = sigmas{1, i+1}' * a{1,i} / m;
    end
    
    % Regularization
    for i = 2:no_of_layers-1
       deltas{i} = deltas{i} + lambda * weights{1,i};
    end
    
    %% Gradient Descent
    for i = 1:no_of_layers-1
        new_weights{1, i} = weights{1, i} - (alpha .* deltas{1, i});
    end
end

