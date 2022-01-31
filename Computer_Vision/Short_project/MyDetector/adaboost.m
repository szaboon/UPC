function bestFeature = adaboost(featureDatabase, initialWeights)


for f = 1:size(featureDatabase,2)
    fvector = featureDatabase(:,f);
    [~, order] = sort(fvector(:,1));
    fsorted = fvector(order,:);
    avg = zeros(size(fsorted,1),1);
    GiniThreshold = zeros(size(fsorted,1)-1,1);
    
    % Calculating threshold
    for t = 1:size(fsorted,1)-1
        avg(t) = (fsorted(t,1)+fsorted(t+1,1))/2;  % Average between 2 neighbour features
        lower = (fsorted(:,1)<avg(t)).*fsorted;    % Features lower than calculated avg
        higher = (fsorted(:,1)>avg(t)).*fsorted;   % Features higher than calculated avg
        lowP = length(find(lower(:,2)==1));     % Finding positive features
        lowN = length(find(lower(:,2)==-1));    % Finding negative features
        highP = length(find(higher(:,2)==1));   % Finding positive features
        highN = length(find(higher(:,2)==-1));  % Finding negative features
        GiniThreshold(t) = Gini(lowP,lowN,highP,highN);
    end
    % We find the lowest Gini value which is the number that
    % best separates positive and negative samples
    threshold = avg(GiniThreshold==min(GiniThreshold));
    if length(threshold)>1;threshold = threshold(1);end
    % Separating features using this threshold
    lower = (fsorted(:,1)<threshold).*fsorted;    % Features lower than calculated avg
    higher = (fsorted(:,1)>threshold).*fsorted;   % Features higher than calculated avg
    lowP = length(find(lower(:,2)==1));     % Finding positive features
    lowN = length(find(lower(:,2)==-1));    % Finding negative features
    highP = length(find(higher(:,2)==1));   % Finding positive features
    highN = length(find(higher(:,2)==-1));  % Finding negative features
    
    GiniHaar(f) = Gini(lowP,lowN,highP,highN);
end

    % Simply taking best features
    incorrect = lowP+highN;
    
    % Adaboost
    error = initialWeight*(lowP+highN);
    AoS = 0.5*log((1-error)/error);
    % Positions of incorrectly classified samples
    iC_Pos = [find(lower(:,2)==1);find(higher(:,2)==-1)];
    % Weight multiplier
    multiplier(:,1) = exp(-AoS);
    multiplier(iC_Pos,1) = exp(AoS);
    % New weights
    neweights = initialWeights.*multiplier;
    neweights = neweights/sum(neweights);

    % Creating new collection of stamples
    cum = cumsum(neweights);
    newColl = zeros(weightsNum,1);
    for w = 1:weightsNum
        between = 0;
        rnd = rand;
        wn = 1;
        while between == 0
            if rnd<cum(wn)
                between = 1;
                newColl(w) = neweights(wn);
                fvector(w,1) = fsorted(wn,1);
                fvector(w,2) = fsorted(wn,2);
            else
                wn = wn+1;
            end
        end
    end

end