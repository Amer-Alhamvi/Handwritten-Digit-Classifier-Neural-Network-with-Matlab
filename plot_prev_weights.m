function plot_prev_weights(percentage,num_of_epochs,filename)
% plots the accuracy change of the model through out each epoch of training
    x = linspace(1,num_of_epochs,num_of_epochs);
    figure
    plot(x,percentage(1,:),"LineWidth",1);
    hold on;
    plot(x,percentage(2,:),'--',"LineWidth",1.5);
    title('prev weights (%) a cross epochs');
    xlabel("num of epochs");
    ylabel("percintage a cross epochs");
    legend({'Train Dataset','Test Dataset'},"Location","best");
    figName = strcat('output/',filename);  
    savefig(figName);
end

