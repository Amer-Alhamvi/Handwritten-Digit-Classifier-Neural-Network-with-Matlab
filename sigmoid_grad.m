function sigmoid_grad = sigmoid_grad(z)
    sub = 1 - sigmoid(z);
    sigmoid_grad = sigmoid(z) .* sub;
end