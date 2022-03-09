function plot_confusion_matrix(confusion_matrix,titlex)
    
% re-arrange confusion matrix to put the zero in front
    r = confusion_matrix(:,10);
    re = confusion_matrix(:,1:9);
    confusion_matrix = [r re];

    x = 0:1:9;
    figure('Name',titlex)
    bar(x,confusion_matrix(1,:))
    hold on;
    bar(x,confusion_matrix(2,:))
    title(titlex);
    xlabel("Digits");
    ylabel("Number of data && number of errors");
    legend({'Total','Error'},"Location","best");
    figName = strcat('output/',titlex);  
    savefig(figName);
   
    
end

