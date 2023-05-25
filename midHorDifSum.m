function midHorDifSum = midHorDifSum(image)
    numRows = size(image,1);
    numCols = size(image,2);
    horSlice = image(floor(numRows/2),:);
    midHorDifSum = 0;
    for col = 1:numCols - 1
        midHorDifSum = midHorDifSum + double(abs(horSlice(col+1)-horSlice(col)));
    end
end