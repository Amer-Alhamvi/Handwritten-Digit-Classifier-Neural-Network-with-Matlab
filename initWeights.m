function weights = initWeights(neurons_in, neurons_out)
    weights = rand(neurons_out, neurons_in+1) * 2 * 0.2 - 0.2;
end
