function g = sigmoid(x)
    g = zeros(size(x));
    g = 1.0 ./ (1.0 + exp(-x));
end