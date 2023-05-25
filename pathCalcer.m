function output = pathCalcer(nextMatrix,initial)
    
    height = size(nextMatrix,1);
    width = size(nextMatrix,2);
    picture = nextMatrix;
    coordTrackingCell = cell(height,width);
    checkedAlreadyTable = zeros(height,width);

    for row = 1:height
        for col = 1:width
             currentPixel = picture(row,col);
             if checkedAlreadyTable(row,col) == 1
                continue
             end
             checkedAlreadyTable(currentPixel) = 1;
             coordTrackingCell{row,col} = [coordTrackingCell{row,col},currentPixel];
             while currentPixel ~= initial(row,col)
                currentPixel=picture(currentPixel);
                checkedAlreadyTable(currentPixel) = 1;
                coordTrackingCell{row,col} = [coordTrackingCell{row,col},currentPixel];
             end
        end
    end

    output = coordTrackingCell;

end