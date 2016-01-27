X =load('X1.train2.txt'); % load training, 1st feature set
Y =load('Y.train.txt'); % & training target values
Xe = load('X1.test.txt');



total_train_time=0;
total_test_time=0;



[N D] =size(X);
[Xt Xv Yt Yv] = splitData(X,Y,.8);



nEnsemble = 25;
Ye = zeros(size(Xe,1),1);
for l=1:nEnsemble, % (This can take a while!)
    [Xi Yi] = bootstrapData(X,Y,size(X,1)); % bootstrap sample for this learner
    rf{l} = treeRegress(Xi,Yi, 'maxDepth',20, 'nFeatures',60); % train next tree
    
    Ye = Ye + predict( rf{l}, Xe); % build and predict
end;
Ye = Ye / nEnsemble;



nFolds = 5; degrees = 1:18; errs=zeros(nFolds,max(degrees));
for degree=degrees, % for each degree
    for iFold = 1:nFolds, % and each partition of data:
        % Extract the ith cross-validation partition of the data:
        [Xti,Xvi,Yti,Yvi] = crossValidate(Xt,Yt,nFolds,iFold);
        % Build the feature transform on these training data:
        XtiP = fpoly(Xti, degree, false); % create polynomial features up to given degree
        [XtiP, M,S] = rescale(XtiP); % scale the features
        Phi = @(x) rescale(fpoly(x,degree,false),M,S); % implicit function of feature transform
        % Create and train the model, and save the error of this degree & split
        lr = linearRegress( XtiP, Yti );
        errs(iFold,degree) = mse(lr,Phi(Xvi),Yvi);
    end;
end;
errs = mean(errs,1); % compute average error over the splits
semilogy(degrees,errs,'r-','linewidth',3); % plot (again on semilog scale
axis(ax); % use the same axis as before for comparision



