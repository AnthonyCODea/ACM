
% testing grounds basically
% setting squaresize = height = width results in normal ACM, otherwise
height = 512;
width = 512;
numPixels = height*width;
squareSize = 512;
overlap = 2*squareSize-width;

P = 1;
Q = 1;

startPointRows = []; startPointCols = [];
for i = 1:height-squareSize
    if mod(i-1,squareSize-overlap)==0
        startPointRows(end+1) = i;
    end
end
startPointRows(end+1)=height-squareSize+1;
for i = 1:width-squareSize
    if mod(i-1,squareSize-overlap)==0
        startPointCols(end+1) = i;
    end
end
startPointCols(end+1)=width-squareSize+1;

initial = zeros(height,width);
index = 1;
for col = 1:width
    for row = 1:height
        initial(row,col) = index; 
        index = index + 1;
    end
end

first = initial;
second = initial;

for rowIndex = 1:size(startPointRows,2)
    for colIndex = 1:size(startPointCols,2)
        row = startPointRows(rowIndex);
        col = startPointCols(colIndex);
        %first(row:row+squareSize-1,col:col+squareSize-1)=ACMGenOperator1(first(row:row+squareSize-1,col:col+squareSize-1),P,Q);
        second(row:row+squareSize-1,col:col+squareSize-1)=ACMGenOperator2(second(row:row+squareSize-1,col:col+squareSize-1),P,Q);
    end
end

% path1 = pathCalcer(first,initial);
% orbitLengths1 = unique(nonzeros(cellfun('size',path1,2)));
% lcm1 = newLCM(orbitLengths1);

path2 = pathCalcer(second,initial);
orbitLengths2 = (nonzeros(cellfun('size',path2,2)));
lcm2 = newLCM(orbitLengths2);

% useful functions
figure(1)
histogram(orbitLengths2,'BinWidth',1)
set(gcf,'Units','inches','Position',[2 2 9.75 3.])
set(gca,'FontSize',15)
xlabel(gca,'Orbit Length')
ylabel(gca,'Frequency')

figure(2)
plot(simGraphFromLengths(orbitLengths2,383)/numPixels);
set(gcf,'Units','inches','Position',[2 2 9.75 3.])
set(gca,'FontSize',15)
xlabel(gca,'Iterations')
ylabel(gca,'Similarity')
% plot(simGraphFromLengths(nonzeros(cellfun('size',coordTrackingCell,2)),1000000)/numPixels
% newLCM(unique(nonzeros(cellfun('size',coordTrackingCell,2))))
% unique(cellfun('size',coordTrackingCell,2))

function output = ACMGenOperator1(inputMatrix,p,q)
% Inverse ACM based on pixel setting and getting
    width = size(inputMatrix,2);
    height = size(inputMatrix,1);
    output = zeros(height,width);
    for row = 1:height
        for col = 1:width
            output(row,col) = inputMatrix(mod((1+p*q)*row+q*col-q-1-p*q,height)+1,mod(p*row+col-1-p,width)+1);
        end
    end
end

function output = ACMGenOperator2(inputMatrix,p,q)
% Forward ACM
    width = size(inputMatrix,2);
    height = size(inputMatrix,1);
    output = zeros(height,width);
    for row = 1:height
        for col = 1:width
            output(mod((1+p*q)*row+q*col-q-1-p*q,height)+1,mod(p*row+col-1-p,width)+1) = inputMatrix(row,col);
        end
    end
end

function output = ACMGenOperator3(inputMatrix,p,q)
% Inverse ACM based on matrix
    width = size(inputMatrix,2);
    height = size(inputMatrix,1);
    output = zeros(height,width);
    for row = 1:height
        for col = 1:width
            output(mod(-q*(col-1)+row-1,height)+1,mod(-p*(row-1)+(1+p*q)*(col-1),width)+1) = inputMatrix(row,col);
        end
    end
end


function output = ACMGenOperator4(inputMatrix,p,q)
% ACM where x and y stretches are flipped
    width = size(inputMatrix,2);
    height = size(inputMatrix,1);
    output = zeros(height,width);
    for row = 1:height
        for col = 1:width
            output(mod(p*(col-1)+row-1,height)+1,mod(q*(row-1)+(1+p*q)*(col-1),width)+1) = inputMatrix(row,col);
        end
    end
end

function output = ACMGenOperator5(inputMatrix,p,q)
% ACM where x and y stretches are flipped and inverse
    width = size(inputMatrix,2);
    height = size(inputMatrix,1);
    output = zeros(height,width);
    for row = 1:height
        for col = 1:width
            output(row,col) = inputMatrix(mod(p*(col-1)+row-1,height)+1,mod(q*(row-1)+(1+p*q)*(col-1),width)+1);
        end
    end
end