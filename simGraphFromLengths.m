function output = simGraphFromLengths(lengths,numberIters)
% outputs similarity data from a list of orbit lengths
% use this function after performing fastpathcalculator: plot(simGraphFromLengths(nonzeros(cellfun('size',coordTrackingCell,2)),1000000)/numPixels
lengthList = lengths;
output = [];
    for i = 1:numberIters
        modMat = mod(i,lengthList);
        zerosLoc = find(modMat == 0);
        output(end+1) = sum(lengthList(zerosLoc));
    end
end