%clear all
%close all
clc

%% Switches
% training switch
DO_TRAINING = true;
% testing switch
DO_TESTING  = true;
% testing through the epochs switch
DO_TESTING_THROUGH_EPOCHS = true;

%% Variables
num_of_train_data = 60000;
threshold = 128; % 0 means no thresholding
norm_factor = 16; % 1 means no normalization

% note: alpha: learning rate || lambda: regularization rate
max_iter = 10000;
alpha = 3;
lambda = 0.0008;

    
% define the networks architecture
% chaning this array will change the network arch.
% input and output layers added automatically depending on input shape and number_of_classes
hidden_layers = [200];

number_of_classes = 10; % can be changed for diffrent datasets (for other applications)

% Dynamic learning rate options
DYNAMIC_ALPHA = false; % dynamic alpha switch
DYNAMIC_ALPHA_ITER = 10;
DYNAMIC_ALPHA_ITER_MUL = 0.6;


%% Read Trainnig Dataset
T = readtable('mnist_train.csv','NumHeaderLines',1);

% extract output form data
y_raw = T{:, 1};
y_raw = y_raw(1:num_of_train_data,:);

% convert y in to boleean of 10 classes
y = (0:9) == y_raw;
y = [y(:,2:10) y(:,1)];

% extract input form data
x = T{:, 2:end}(1:num_of_train_data,:);
% threshold input
x(x<threshold) = 0;
% normaliz input
x = fix(x/norm_factor);

%% Training Part 
if DO_TRAINING
    disp('Start Training .....')

    inputs = length(x(1,:));
    no_hidden_layers = length(hidden_layers);
    
    % Network arch
    NN_arch = [inputs hidden_layers number_of_classes];

    tic;
    % init random weights
    for i = 1:no_hidden_layers+1
        weights{i} = initWeights(NN_arch(i), NN_arch(i+1));
    end

    % some variables
    J = 0.;
    iter = 0;
    
    % store previous weights and cost functions
    prev_weights = cell(1, max_iter);
    J_lst = zeros(1, max_iter);
    sample_of_weights = zeros(30, max_iter);
    
    % start training process
    for i = 1:max_iter
        % show progress ever 50 iter
        if mod(i, 100) == 0
            disp("iter : " + i);
        end

        % In case of dynamic alpha
        if mod(i, DYNAMIC_ALPHA_ITER) == 0 && DYNAMIC_ALPHA
            alpha = alpha * DYNAMIC_ALPHA_ITER_MUL;
            disp("iter : " + i+ " learning rate: "+alpha);
        end
            
        % train 
        [J, weights] = train(weights, NN_arch, x, y, alpha, lambda);
        
        % store prev values
        J_lst(1, i) = J;
        sample_of_weights(:,i) = weights{1,2}(1,1:30);
        prev_weights{i} = weights;
    end
    
    % store final weights matrix and graph change in J
    save('output/weights.mat','weights');
    save('output/sample_of_weights.mat','sample_of_weights');
    save('output/J_lst.mat','J_lst');
    
    plot_cost(J_lst,max_iter);
    training_time = toc;
    disp(strcat('training time : ',string(training_time)));
    save_parameters(num_of_train_data,threshold,norm_factor,max_iter,alpha,lambda,hidden_layers,training_time);
end

%% Testing part
% do testing?
if DO_TESTING
    disp('Testing started .....')
    % Read test dataset
    T1 = readtable('mnist_test.csv','NumHeaderLines',1);

    % extract input form data
    y_raw_diff = T1{:, 1};
    y_raw_diff = y_raw_diff(1:10000,:);
    
    % convert y in to boleean of 10 classes
    y_diff = (0:9) == y_raw_diff;
    y_diff = [y_diff(:,2:10) y_diff(:,1)];

    % extract input form data
    x_diff = T1{:, 2:end}(1:10000,:);
    % threshold
    x_diff(x_diff<128) = 0;
    % normalization 
    x_diff = fix(x_diff/16);


    [persentage0, confusion_of_training] = predict_confusionM(x,y, weights); % test on training dataset
    [persentage1, confusion_of_testing] = predict_confusionM(x_diff,y_diff, weights); % test on test dataset

    disp("persentage on training dataset : " + persentage0);
    disp("persentage on testing dataset : " + persentage1);
    
    plot_confusion_matrix(confusion_of_training,'CM for Training data');
    plot_confusion_matrix(confusion_of_testing,'CM for Testing data');
    plot_percentage_CM(confusion_of_training,confusion_of_testing,'CM Error percentages');
    disp('Testing finished .....')
end

%% Testing through the epochs
% do training thorough the epocs
if DO_TESTING_THROUGH_EPOCHS
    disp(' ')
    disp('Testing through the epochs started .....')
 
    if ~DO_TESTING
        % Read test dataset if DO_TESTING was false
        T1 = readtable('mnist_test.csv','NumHeaderLines',1);
    
        % extract input form data
        y_raw_diff = T1{:, 1};
        y_raw_diff = y_raw_diff(1:10000,:);
        
        % convert y in to boleean of 10 classes
        y_diff = (0:9) == y_raw_diff;
        y_diff = [y_diff(:,2:10) y_diff(:,1)];
    
        % extract input form data
        x_diff = T1{:, 2:end}(1:10000,:);
        % threshold
        x_diff(x_diff<128) = 0;
        % normalization 
        x_diff = fix(x_diff/16);
    end
    
    percentage = zeros(2, length(prev_weights));
    for i = 1:length(prev_weights)
        if mod(i, 100) == 0
            disp("iter : " + i);
        end
        %sample_of_weights(:,i) = prev_weights{1,i}{1,2}(1,1:30);
        percentage(1, i) = predict(x,y_raw,prev_weights{1, i}); % test on training dataset
        percentage(2, i) = predict(x_diff,y_raw_diff, prev_weights{1., i}); % test on test dataset
    end
    plot_prev_weights(percentage, length(prev_weights),'Prev weights percentages');
    plot_synaptic_weights(sample_of_weights);
    save('output/percentage_of_weights_through_epochs.mat','percentage');
    disp('Testing through the epochs finished .....')
end


