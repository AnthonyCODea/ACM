function lcmVal = newLCM(numberArray)
% takes in list of values and returns their LCM
% if the LCM is above around 10 ^ 308, then Inf is returned
    numberArray = nonzeros(unique(reshape(numberArray, [], 1)));
    numNums = size(numberArray,1);
    factorCells = cell(numNums,1);
    for i = 1:numNums
        temp = factor(numberArray(i));
        factorCells{i} = temp;
    end
 
    primesList = unique(horzcat(factorCells{:})); %can include 1 as a prime. Doesn't impact the end value
    numPrimes = size(primesList,2); 
    primesCounts = zeros(1,numPrimes);
    for i = 1:numPrimes
        currentPrime = primesList(i);
        count = 1;
        for j = 1:numNums
            if(sum(factorCells{j} == currentPrime) > count)
                count = sum(factorCells{j} == currentPrime);
            end
        end
        primesCounts(i) = count;
    end
    
    poweredPrimes = primesList.^primesCounts;
    lcmVal = prod(poweredPrimes);
