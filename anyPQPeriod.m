tic %tic and toc are for tracking time
% this script is for finding period across different p and q values
% takes a while to run
%coordTrackingCell contains the orbits
width = 64*2;
height = width;
initial = zeros(height,width);
index = 1;
for col = 1:width
    for row = 1:height
        initial(row,col) = index;
        index = index + 1;
    end
end
periodList = [];

for p = 0:width-1
    for q = 0:width-1
        checkedAlreadyTable = zeros(height,width);
        index = 1;
        coordTrackingCell = cell(height,width);
        picture=ACMGenOperator2(initial,p,q);
        
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
        period = newLCM(unique(nonzeros(cellfun('size',coordTrackingCell,2))));
        periodList(end+1) = period;
    end
end
plot(periodList);
sum(periodList)
% useful functions
% histogram(nonzeros(cellfun('size',coordTrackingCell,2)),'BinWidth',1)
% set(gcf,'Units','inches','Position',[2 2 9.75 3.])
% set(gca,'FontSize',15)
% xlabel(gca,'Iterations')
% ylabel(gca,'Frequency')
% plot(simGraphFromLengths(nonzeros(cellfun('size',coordTrackingCell,2)),1000000)/numPixels
% newLCM(unique(nonzeros(cellfun('size',coordTrackingCell,2))))
% unique(cellfun('size',coordTrackingCell,2))
toc