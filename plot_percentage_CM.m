function plot_percentage_CM(CM_train,CM_test,filename)
%plots the error percentage through both the confusion matrix for the
%training and testing
    figure('Name','persentages')
    x = 0:1:9;
    plot(x,CM_train(3,:),"LineWidth",1);
    hold on;
    plot(x,CM_test(3,:),'--','LineWidth',1);
    grid on
    title('Percentage of Errors (%) ');
    xlabel("Digits");
    ylabel("percentage of Errors (%) ");
    legend({'train','test'},"Location","best");
    figName = strcat('output/',filename);  
    savefig(figName);
end

