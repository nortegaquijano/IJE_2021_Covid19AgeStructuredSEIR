%--------------------------------------------------------------------------
% MEASURE 3: Public health lockdown
% 
% Cite as:
% Daniel Ortega-Quijano, Noe Ortega-Quijano, Impact of age-selective vs 
% non-selective physical-distancing measures against coronavirus disease 
% 2019: a mathematical modelling study, International Journal of 
% Epidemiology, 2021; dyab043
% https://doi.org/10.1093/ije/dyab043
%% ------------------------------------------------------------------------

% Measure number:
ii = 3;
% Number of phases in this measure:
jj = 3;
% Number of measure (auto):
measure.nMeasure{ii} = ii;
% Number of phases (auto):
measure.nPhases{ii} = jj;
% Measure description:
measure.Desc{ii} = 'Public health lockdown';


%% Phase dates (there have to be jj+1 entries):
% Note: date from phase 2 onwards indicates the last day of the previous phase
measure.phaseDate{1,ii} = dateInitial;          % Nov 22, 2019 to Jan 14, 2020: Normal situation
measure.phaseDate{2,ii} = datetime(2020,1,14);  % Jan 15 to Jan 23, 2020: Winter school holidays
measure.phaseDate{3,ii} = datetime(2020,1,23);  % Lockdown
measure.phaseDate{4,ii} = dateFinal;


%% Phase 1 contacts:

% Contact matrices weightings:
measure.wHome{1,ii} = 1;
measure.wWork{1,ii} = 1;
measure.wSchool{1,ii} = 1;
measure.wOthers{1,ii} = 1;

% Contact matrices (auto):
measure.cHome{1,ii} = measure.wHome{1,ii}.*cHome;
measure.cWork{1,ii} = measure.wWork{1,ii}.*cWork;
measure.cSchool{1,ii} = measure.wSchool{1,ii}.*cSchool;
measure.cOthers{1,ii} = measure.wOthers{1,ii}.*cOthers;
measure.cAll{1,ii} = measure.cHome{1,ii}+measure.cWork{1,ii}+measure.cSchool{1,ii}+measure.cOthers{1,ii};
measure.cRest{1,ii} = measure.cAll{1,ii}-measure.cWork{1,ii};

% Verify that contact matrices satisfy the reciprocity condition (auto):
fReciprocityCheck(measure.cHome{1,ii},pop0);
fReciprocityCheck(measure.cWork{1,ii},pop0);
fReciprocityCheck(measure.cSchool{1,ii},pop0);
fReciprocityCheck(measure.cOthers{1,ii},pop0);
fReciprocityCheck(measure.cAll{1,ii},pop0);
fReciprocityCheck(measure.cRest{1,ii},pop0);


%% Phase 2 contacts:

% Contact matrices weightings:
measure.wHome{2,ii} = 1;
measure.wWork{2,ii} = 1;
measure.wSchool{2,ii} = 0;
measure.wOthers{2,ii} = 1;

% Contact matrices (auto):
measure.cHome{2,ii} = measure.wHome{2,ii}.*cHome;
measure.cWork{2,ii} = measure.wWork{2,ii}.*cWork;
measure.cSchool{2,ii} = measure.wSchool{2,ii}.*cSchool;
measure.cOthers{2,ii} = measure.wOthers{2,ii}.*cOthers;
measure.cAll{2,ii} = measure.cHome{2,ii}+measure.cWork{2,ii}+measure.cSchool{2,ii}+measure.cOthers{2,ii};
measure.cRest{2,ii} = measure.cAll{2,ii}-measure.cWork{2,ii};

% Verify that contact matrices satisfy the reciprocity condition (auto):
fReciprocityCheck(measure.cHome{2,ii},pop0);
fReciprocityCheck(measure.cWork{2,ii},pop0);
fReciprocityCheck(measure.cSchool{2,ii},pop0);
fReciprocityCheck(measure.cOthers{2,ii},pop0);
fReciprocityCheck(measure.cAll{2,ii},pop0);
fReciprocityCheck(measure.cRest{2,ii},pop0);


%% Contact matrices weightings (phase 3):

cAll = cHome+cWork+cSchool+cOthers;

% See supplementary material p. 12-13 for a description of the procedure 
% followed to fix the value of the B parameter:
B = 0.7885;
ncAll = (1-B)*sum(cAll*pop0');

% Distribution of infected (see supplementary material p. 5-6):
DI = [0.115553257; 0.105077132; 0.144218952; 0.150945365; 0.175958632; 0.136394355; 0.103899914; 0.067952393];

% Assumption for scenario 3 follows scenario 2: 5% of the workforce 
% remained at their workplace (see supplementary material p. 14-16):
ncRest = ncAll-sum(0.05*cWork*pop0');
targetContactsRest = ncRest*DI;
% Additional 30% reduction in the number of contacts for individuales aged
% more than 60 (see supplementary material p. 14-16):
targetContactsRest = [1 1 1 1 1 1 0.5 0.5]'.*targetContactsRest;
cRest = cAll-cWork;

% Constrained linear least-squares algorithm for determining the fitted 
% contact matrix at the rest of locations:
[cRestFitted3,coeffsMatrix] = fContactsLeastSquares(cRest,pop0,targetContactsRest);

% Contact matrices for phase 3:
measure.wWork{3,ii} = 0.05;
measure.cWork{3,ii} = measure.wWork{3,ii}.*cWork;
measure.cRest{3,ii} = cRestFitted3;
measure.cAll{3,ii} = measure.cWork{3,ii}+measure.cRest{3,ii};

% Verify that contact matrices satisfy the reciprocity condition (auto):
fReciprocityCheck(measure.cWork{3,ii},pop0);
fReciprocityCheck(measure.cAll{3,ii},pop0);
fReciprocityCheck(measure.cRest{3,ii},pop0);