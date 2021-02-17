function reciprocal = fReciprocityCheck(C,pop)

% Precision:
precision = 1e-6;

% Number of age groups:
ageN = length(pop);

% Total contacts matrix:
Cw = repmat(pop,[ageN,1]).*C;

% Check:
reciprocityCheck = norm(Cw-transpose(Cw));
reciprocal = reciprocityCheck<precision;

if(reciprocal==0)
    disp('Warning: non-reciprocal contact matrix!')
end