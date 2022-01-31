% Gini() function
function GiniTotal = Gini(lowP,lowN,highP,highN)

    % Calculating Gini for lower numbers than avg
    Ginilower = 1-(lowP/(lowP+lowN))^2-(lowN/(lowP+lowN))^2;
    % Calculating Gini for higher numbers than avg
    GiniHigher = 1-(highP/(highP+highN))^2-(highN/(highP+highN))^2;
    % Total Gini
    GiniTotal = ((lowP+lowN)/(lowP+lowN+highP+highN))*Ginilower...
                +((highP+highN)/(lowP+lowN+highP+highN))*GiniHigher;
end