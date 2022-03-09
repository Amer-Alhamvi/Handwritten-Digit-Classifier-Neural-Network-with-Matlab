function save_parameters(num_of_train_data,threshold,norm_factor,max_iter,alpha,lambda,hidden_layers,training_time)
% Saves all the parameters that was used throught training and testing
% process and store it at output/parametars.txt
    fid = fopen('output/parametars.txt','w');
    fprintf(fid, strcat("num_of_train_data : ",string(num_of_train_data)));
    fprintf(fid, '\n' );
    fprintf(fid, strcat("threshold : ",string(threshold)));
    fprintf(fid, '\n' );
    fprintf(fid, strcat("norm_factor : ",string(norm_factor)));
    fprintf(fid, '\n' );
    fprintf(fid, strcat("max_iter : ",string(max_iter)));
    fprintf(fid, '\n' );
    fprintf(fid, strcat("alpha : ",string(alpha)));
    fprintf(fid, '\n' );
    fprintf(fid, strcat("lambda : ",string(lambda)));
    fprintf(fid, '\n' );
    fprintf(fid, 'Arch : [');
    for i=1:length(hidden_layers)
        fprintf(fid, strcat(" ",string(hidden_layers(i))));
    end
    fprintf(fid, ' ]');
    fprintf(fid, '\n' );
    fprintf(fid, strcat('training time : ',string(training_time)));
    fclose(fid);
end

