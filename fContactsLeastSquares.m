function [cCorrected,coeffsMatrix] = fContactsLeastSquares(C,pop,targetContacts)

% Precision:
precision = 1e-6;%% Input data check:

% Check contact matrix dimensions:
[rows,cols] = size(C);
if(rows==cols)
    ageN = rows;
else
    disp('Warning: check dimensions')
end

% Check population vector:
[rows,~] = size(pop);
if(rows>1)
    pop = transpose(pop); % This code is prepared for population given as a row vector
end

% Target contacts check:
[~,cols] = size(targetContacts);
if(cols>1)
    targetContacts = transpose(targetContacts); % This code is prepared for target contacts as a column vector
end

%% Calculation:

% Population-weighted contact matrix (total contacts):
Cw = repmat(pop,[ageN,1]).*C;

% Number of unknowns:
unknowns = (ageN^2+ageN)/2;

% Matrix containing the weight variable indexes corresponding to the unknowns to be solved:
xindex = zeros(ageN,ageN);
indexes = linspace(1,unknowns,unknowns);
assigned = 0;
for ii=1:ageN
    xindex(ii,ii:end) = indexes(assigned+1:assigned+1+(ageN-ii));
    xindex(ii:end,ii) = transpose(indexes(assigned+1:assigned+1+(ageN-ii)));
    assigned = assigned+(ageN-ii)+1;
end

% Coefficients matrix for the equation to be solved:
eqCoeffs = zeros(ageN,unknowns);
for ii=1:ageN
    for jj=1:ageN
        % Find index of the variable that multiplies each population-weighted contact matrix:
        xindex_eq = xindex(jj,ii);
        % Introduce each population-weighted contact matrix element in the right place:
        eqCoeffs(ii,xindex_eq) = Cw(ii,jj);
    end
end

% Find a solution for the unknown coefficients using least-squares method
% under the constrain of minimizing the norm:
coeffs = lsqminnorm(eqCoeffs,targetContacts);

% Rearrange the obtained coefficients in a matrix:
coeffsMatrix = zeros(ageN,ageN);
for ii=1:length(coeffs)
    [row,col] = find(xindex==ii);
    for jj=1:length(row)
        coeffsMatrix(row(jj),col(jj)) = coeffs(ii);
    end
end
% Display warning only if those coefficients are greater than the precision:
if(any(abs(coeffsMatrix(coeffsMatrix<0))>precision,'all'))
    disp('Info: some coefficients retrieved using the least-squares method were negative, they have been fixed to 0')
end
% Fix negative elements to 0:
coeffsMatrix(coeffsMatrix<0) = 0;

cCorrected = C.*coeffsMatrix;