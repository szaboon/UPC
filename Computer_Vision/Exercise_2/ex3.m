close all;
class1 = [6 6; 6 8; 7 6; 7 7; 8 6; 8 7; 8 9; 9 5; 9 8; 10 4; 10 2; 11 3];
class2 = [4 5; 4 6; 5 4; 5 5; 6 4; 7 5; 9 7; 10 5; 10 6; 10 7; 11 8];
samples = [8 3; 8 5; 8 8; 10 8];

figure
rectangle('Position',[3 1 9 9]),hold on
plot(class1(:,1),class1(:,2),'bo','MarkerSize',10),
plot(class2(:,1),class2(:,2),'rx','MarkerSize',10)
hold off
grid on

c1 = ones(size(class1,1),3);
c2 = 2*ones(size(class2,1),3);
c1(:,1:2)=class1;
c2(:,1:2)=class2;

class = [c1;c2];
dist = [];
all = [class1;class2;samples];
belongs_to = zeros(size(all,1),3);
for s = 1:size(all,1)
    for i = 1:size(class,1)
        disty = all(s,1)-class(i,1);
        distx = all(s,2)-class(i,2);
        dist(i,1) = sqrt(distx^2+disty^2);
    end
    
%     c = unique(dist);    % Sorting distances
%     c(c==0)=[];
%     classes = {};
%     for k = 1:length(c)
%         d = find(dist==c(k))
%         classes{k} = class(d,3);
%     end
%     
%     near{1} = classes{1};
%     near{2} = [classes{1};classes{2};classes{3}];
%     near{3} = [classes{1};classes{2};classes{3};classes{4};classes{5}];

    [~, order] = sort(dist(:,1));
    dist(order,:)
    dist(dist==0)=[];
    near = {};
    order
    order(1:3)
    class(order(1:3),3)
    near{1} = class(order(1),3)
    near{2} = class(order(1:3),3)
    near{3} = class(order(1:5),3)
    
    for k=1:3
        n1 = length(find(near{k}==1))
        n2 = length(find(near{k}==2))
    
        if n1==n2
            ans = 715;
        elseif n1>n2
            ans= 1;
        else
            ans=2;
        end
        belongs_to(s,k) = ans;
    end
end
belongs_to;

Num = reshape(1:size(all,1),[size(all,1),1])
Coordinates = all;
class = [class(:,3);zeros(size(samples,1),1)];
K1 = belongs_to(:,1);
K3 = belongs_to(:,2);
K5 = belongs_to(:,3);

results = table(Num,Coordinates,class,K1,K3,K5)


%%
% Class 1
mean1 = zeros(1,2);
for i=1:length(class1)
    mean1 = mean1 + class1(i,:);
end
mean1 = (mean1/length(class1))'

cov1 = zeros(2,2);
for i=1:length(class1)
    cov1 = cov1 + class1(i,:)'*class1(i,:) - mean1*mean1';
end
cov1 = cov1/length(class1)

% Class2
mean2 = zeros(1,2);
for i=1:length(class2)
    mean2 = mean2 + class2(i,:);
end
mean2 = (mean2/length(class2))'

cov2 = zeros(2,2);
for i=1:length(class2)
    cov2 = cov2 + class2(i,:)'*class2(i,:) - mean2*mean2';
end
cov2 = cov2/length(class2)

% Bayes
% Points of class 1
p1 = 12/23;     
p2 = 11/23;
expression1 = zeros(length(class1),2);
for i=1:length(class1)
    expression1(i,1) = log(p1) - 0.5*log(det(cov1)) - 0.5*(class1(i,:)'-mean1)'*inv(cov1)*(class1(i,:)'-mean1);
    expression1(i,2) = log(p2) - 0.5*log(det(cov2)) - 0.5*(class1(i,:)'-mean2)'*inv(cov2)*(class1(i,:)'-mean2);
end
expression1

% Points of class 2
expression2 = zeros(length(class2),2);
for i=1:length(class2)
    expression2(i,1) = log(p1) - 0.5*log(det(cov1)) - 0.5*(class2(i,:)'-mean1)'*inv(cov1)*(class2(i,:)'-mean1);
    expression2(i,2) = log(p2) - 0.5*log(det(cov2)) - 0.5*(class2(i,:)'-mean2)'*inv(cov2)*(class2(i,:)'-mean2);
end
expression2;

% New points
expression3 = zeros(length(samples),2);
for i=1:length(samples)
    expression3(i,1) = log(p1) - 0.5*log(det(cov1)) - 0.5*(samples(i,:)'-mean1)'*inv(cov1)*(samples(i,:)'-mean1);
    expression3(i,2) = log(p2) - 0.5*log(det(cov2)) - 0.5*(samples(i,:)'-mean2)'*inv(cov2)*(samples(i,:)'-mean2);
end
expression3

% Mahalanobis

% Class 1
distance1 = zeros(length(class1),2);
for i=1:length(class1)
    distance1(i,1) = sqrt( (class1(i,:)'-mean1)'*inv(cov1)*(class1(i,:)'-mean1) );
    distance1(i,2) = sqrt( (class1(i,:)'-mean2)'*inv(cov2)*(class1(i,:)'-mean2) );
end
distance1

% Class 2
distance2 = zeros(length(class2),2);
for i=1:length(class2)
    distance2(i,1) = sqrt( (class2(i,:)'-mean1)'*inv(cov1)*(class2(i,:)'-mean1) );
    distance2(i,2) = sqrt( (class2(i,:)'-mean2)'*inv(cov2)*(class2(i,:)'-mean2) );
end
distance2

% New points
distance3 = zeros(length(samples),2);
for i=1:length(samples)
    distance3(i,1) = sqrt( (samples(i,:)'-mean1)'*inv(cov1)*(samples(i,:)'-mean1) );
    distance3(i,2) = sqrt( (samples(i,:)'-mean2)'*inv(cov2)*(samples(i,:)'-mean2) );
end
distance3