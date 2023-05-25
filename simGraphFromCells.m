function output = simGraphFromCells(coordTrackingCell,numberIters)
% doesn't actually plot the data, it returns the data to be plotted. 
% returns the number of points back in their original location across iters
lengthList = [];
numRows = size(coordTrackingCell,1);
numCols = size(coordTrackingCell,2);
for col = 1:numCols
    for row = 1:numRows
        if(~isempty(coordTrackingCell{row,col}))
            lengthList(end+1) = size(coordTrackingCell{row,col},2);
        end
    end
end

output = [];
for i = 1:numberIters
    modMat = mod(i,lengthList);
    zerosLoc = find(modMat == 0);
    output(end+1) = sum(lengthList(zerosLoc));
end
   % output;
end