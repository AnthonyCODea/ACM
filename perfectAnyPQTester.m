height = 512;
s = 2;
width = s*height;

P = 470;
Q = 125;

initial = zeros(height,width);
index = 1;
for col = 1:width
    for row = 1:height
        initial(row,col) = index; 
        index = index + 1;
    end
end

%image(second,'CDataMapping','scaled')

first = ACMGenOperator1(initial,P,Q);
path1 = pathCalcer(first,initial);
lcm1 = newLCM(unique(nonzeros(cellfun('size',path1,2))));

second = ACMGenOperator2(initial,P,Q);
path2 = pathCalcer(second,initial);
lcm2 = newLCM(unique(nonzeros(cellfun('size',path2,2))));

third = ACMGenOperator3(initial,1,1);

% third = initial;
% for i = 1:384*2
%     third = ACMGenOperator1(third,1,1);
% end

% fourth = initial;
% for i = 1:384*2
%     fourth = ACMGenOperator1(fourth,1,1);
% end

%image(picture,'CDataMapping','scaled')

fifth = ACMGenOperator1(initial,P,Q);
fifth = ACMGenOperator2(fifth,P,Q);
good = isequal(fifth,initial);

sixth = ACMGenOperator2(initial,P+height,Q);
sixth2 = ACMGenOperator2(initial,P,Q);
good1 = isequal(sixth,sixth2);

seventh = ACMGenOperator2(initial,P,Q);
seventh2 = ACMGenOperator2(initial,P,Q+height);
good2 = isequal(seventh,seventh2);

% sixth = ACMGenOperator4(initial,25,13);
% sixth = ACMGenOperator5(sixth,25,13);
% good2 = isequal(sixth,initial);

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