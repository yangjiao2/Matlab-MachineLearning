%2
%a
curve80=load('data/curve80.txt');
curve80=load('data/curve80.txt');
feature = curve80(:,1);
target = curve80(:,2);
[Xtr Xte Ytr Yte]=splitData(feature,target,.75);

%b
lr = linearRegress( Xtr, Ytr ); % create and train model
xs = [0:.05:10]'; % densely sample possible x-values: note transpose!!!
ys = predict( lr, xs ); % make predictions at xs

plot(xs,ys,'black-',Xtr,Ytr,'red.','markersize',18,'linewidth',3);
ax = axis 
title('Prediction function', 'Fontsize', 12)
legend('Prediction', 'Training data', 'Test data');

figure;
mseXYtr = mse(lr,Xtr,Ytr)
mseXYte = mse(lr,Xte,Yte)


%c
Xtr2 = [Xtr, Xtr.^2];
TrainErr = [];
TestErr = [];
degrees = [1, 3, 5, 7, 10, 18];
for degree=degrees
  
    XtrP = fpoly(Xtr, degree, false); % create poly features up to given degree; no "1" feature
    [XtrP, M,S] = rescale(XtrP); % it's often a good idea to scale the features
    lr = linearRegress( XtrP, Ytr ); % create and train model
    Phi = @(x) rescale( fpoly(x,degree,false), M,S);
    YhatTrain = predict( lr, XtrP ); % predict on training data
    
  
    
    % defines an "implicit function" Phi(x)
    XteP = Phi(Xte);
    
    %parameters "degree", "M", and "S" are memorized at the function definition
    %Now, Phi will do the required feature expansion and rescaling:

    YhatTest = predict( lr, XteP ); % predict on test data
    

%     plot(xs,predict(lr,Phi(xs)),'black-', Xtr,Ytr,'red.', Xte,Yte,'green.','markersize',18);
%     axis(ax);
%     legend('Prediction function', 'Training data', 'Test data');
%     title(sprintf('Prediction function with degree %d', degree), 'Fontsize', 12);
%     figure;

    TrainErr(:,end+1) = mse(lr,XtrP,Ytr);
    TestErr(:,end+1) = mse(lr,XteP,Yte);
    
end
semilogy(degrees, TrainErr,'red-', degrees, TestErr, 'green-','markersize',24);
title('training and test errors', 'Fontsize', 12);
legend('Training error', 'Test error');

%3
nFolds = 5; 
performance = [];
for degree=degrees
    J = [];
    for iFold = 1:nFolds
        [Xti,Xvi,Yti,Yvi] = crossValidate(Xtr,Ytr,nFolds,iFold); % cross-val on training data
        XtiP = fpoly(Xti, degree, false); % create polynomial features up to given degree
        [XtiP, M,S] = rescale(XtiP); % scale the features
        Phi = @(x) rescale(fpoly(x,degree,false),M,S); % implicit function of feature transform
        learner = linearRegress( XtiP, Yti ); % create and train model
        J(iFold) = mse(learner,Phi(Xvi),Yvi);
    end;
    performance(:, end+1) = mean(J);
end;

semilogy(degrees,performance,'green-o');
title('cross-validation error');
figure;

semilogy(degrees,performance,'green-o', degrees, TestErr, 'blue-.');
title('MSE from cross-validation & MSE');
legend('cross-validation error', 'MSE')