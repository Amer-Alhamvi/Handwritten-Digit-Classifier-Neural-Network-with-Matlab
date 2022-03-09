function plot_synaptic_weights(prev_weights_sample)
    x = 1:1:10000;
    figure
    
%     plot(x,prev_weights_sample(1,:),"LineWidth",1);
    for i=1:30
        plot(x,prev_weights_sample(i,:),"LineWidth",1);
        hold on;
    end
    title('plot of synaptic weights');
    savefig('output/sample of weights');
end

