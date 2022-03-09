function plot_cost(cost,max_iter)
    x = linspace(1,max_iter,max_iter);
    figure
    
    plot(x,cost,'LineWidth', 1);
    title('Cost function');
    xlabel("num of epochs")
    ylabel("J value (cost function)")
    
    savefig('output/cost');
end
