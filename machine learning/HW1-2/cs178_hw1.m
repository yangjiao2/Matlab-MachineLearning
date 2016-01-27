iris = load('/Users/yangjiao/Documents/MATLAB/HW1-2/data/iris.txt');
y = iris(:,end); % target value is last column
X = iris(:,1:end-1); % features are other columns
whos % show current variables in memory and sizes

% 1 (a)
numberOfFeatures = size (X,2)
numberOfData = size (X,1)

% % 1 (b)
% for i = 1:numberOfFeatures
%     hist(X(:,i));
%     figure;
% end

% 1 (c)
mean(X)

% 1 (d)
var(X)
std(X)

% 1 (e)
X = X - repmat(mean(X), [numberOfData,1]);
X = X ./repmat(std(X), [numberOfData,1])

% 1 (f)

for j = 2:4
    y0 = find (y == 0);
    plot(X(y0, 1), X(y0, j), 'b*');
    hold on;
    y1 = find (y == 1);
    plot(X(y1, 1), X(y1, j), 'g*');
    y2 = find (y == 2);
    plot(X(y2, 1), X(y2, j), 'r*');
    figure;
end;

% 2
iris = load('/Users/yangjiao/Documents/MATLAB/HW1-2/data/iris.txt');
y = iris(:,end); % target value is last column
X = iris(:,1:end-1); % features are other columns
[X y] = shuffleData(X,y);
X = X(:,1:2);
[Xtr Xte Ytr Yte] = splitData(X,y, .75); % split data into 75/25 train/test

% 2 (a)
% K = [1,5,10,50];
% for i = 1: length(K)
%     i
%     knn = knnClassify( Xtr, Ytr, K(i)); % replace or set K to some integer
%     plotClassify2D( knn, Xtr, Ytr ); % make 2D classification plot with data (Xtr,Ytr)
%     figure;
% end

% 2 (b)
% K=[1,2,5,10,50,100,200];
% for i=1:length(K)
%     learner1 = knnClassify(Xtr, Ytr, K(i));... % TODO: complete code to train model
%     Yhat1 = predict(learner1, Xtr );... % TDO: complete code to predict results on training data 
%     errTrain(i) = err(learner1, Xtr, Ytr);... % TODO: " " to count what fraction of predictions are wrong
% 
%     learner2 = knnClassify(Xte, Yte, K(i));
%     Yhat2 = predict(learner2, Xte );
%     errTest(i) = err(learner2, Xte, Yte);
% end;
% figure; 
% semilogx(K,errTrain, 'r-', K,errTest, 'g');... % TODO: " " to average and plot results on semi-log scale
%     

   
