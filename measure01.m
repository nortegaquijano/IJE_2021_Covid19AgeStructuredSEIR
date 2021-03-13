%--------------------------------------------------------------------------
% MEASURE 1: No physical distancing
% 
% Cite as:
% Daniel Ortega-Quijano, Noe Ortega-Quijano, Impact of age-selective vs 
% non-selective physical-distancing measures against coronavirus disease 
% 2019: a mathematical modelling study, International Journal of 
% Epidemiology, 2021; dyab043
% https://doi.org/10.1093/ije/dyab043
%% ------------------------------------------------------------------------

% Measure number:
ii = 1;
% Number of phases in this measure:
jj = 5;
% Number of measure (auto):
measure.nMeasure{ii} = ii;
% Number of phases (auto):
measure.nPhases{ii} = jj;
% Measure description:
measure.Desc{ii} = 'No physical distancing';


%% Phase dates (there have to be jj+1 entries):
% Note: date from phase 2 onwards indicates the last day of the previous phase
measure.phaseDate{1,ii} = dateInitial;          % Nov 22, 2019 to Jan 14, 2020: Normal situation
measure.phaseDate{2,ii} = datetime(2020,1,14);  % Jan 15 to Jan 23, 2020: Winter school holidays
measure.phaseDate{3,ii} = datetime(2020,1,23);  % Jan 24 to Jan 30, 2020: Lunar New Year holidays
measure.phaseDate{4,ii} = datetime(2020,1,30);  % Jan 31 to Feb 10, 2020: Winter school holidays (continuation). 
measure.phaseDate{5,ii} = datetime(2020,2,10);  % Feb 11 to Apr 7, 2020: Normal situation
measure.phaseDate{6,ii} = dateFinal;


%% Phase 1 contacts:

% Contact matrices weightings:
measure.wHome{1,ii} = 1;
measure.wWork{1,ii} = 1;
measure.wSchool{1,ii} = 1;
measure.wOthers{1,ii} = 1;

% Contact matrices (phase 1) (auto):
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


%% Phase 3 contacts:

% Contact matrices weightings:
measure.wHome{3,ii} = 1;
measure.wWork{3,ii} = 0.1;
measure.wSchool{3,ii} = 0;
measure.wOthers{3,ii} = 1;

% Contact matrices (auto):
measure.cHome{3,ii} = measure.wHome{3,ii}.*cHome;
measure.cWork{3,ii} = measure.wWork{3,ii}.*cWork;
measure.cSchool{3,ii} = measure.wSchool{3,ii}.*cSchool;
measure.cOthers{3,ii} = measure.wOthers{3,ii}.*cOthers;
measure.cAll{3,ii} = measure.cHome{3,ii}+measure.cWork{3,ii}+measure.cSchool{3,ii}+measure.cOthers{3,ii};
measure.cRest{3,ii} = measure.cAll{3,ii}-measure.cWork{3,ii};

% Verify that contact matrices satisfy the reciprocity condition (auto):
fReciprocityCheck(measure.cHome{3,ii},pop0);
fReciprocityCheck(measure.cWork{3,ii},pop0);
fReciprocityCheck(measure.cSchool{3,ii},pop0);
fReciprocityCheck(measure.cOthers{3,ii},pop0);
fReciprocityCheck(measure.cAll{3,ii},pop0);
fReciprocityCheck(measure.cRest{3,ii},pop0);


%% Phase 4 contacts:

% Contact matrices weightings:
measure.wHome{4,ii} = 1;
measure.wWork{4,ii} = 1;
measure.wSchool{4,ii} = 0;
measure.wOthers{4,ii} = 1;

% Contact matrices (auto):
measure.cHome{4,ii} = measure.wHome{4,ii}.*cHome;
measure.cWork{4,ii} = measure.wWork{4,ii}.*cWork;
measure.cSchool{4,ii} = measure.wSchool{4,ii}.*cSchool;
measure.cOthers{4,ii} = measure.wOthers{4,ii}.*cOthers;
measure.cAll{4,ii} = measure.cHome{4,ii}+measure.cWork{4,ii}+measure.cSchool{4,ii}+measure.cOthers{4,ii};
measure.cRest{4,ii} = measure.cAll{4,ii}-measure.cWork{4,ii};

% Verify that contact matrices satisfy the reciprocity condition (auto):
fReciprocityCheck(measure.cHome{4,ii},pop0);
fReciprocityCheck(measure.cWork{4,ii},pop0);
fReciprocityCheck(measure.cSchool{4,ii},pop0);
fReciprocityCheck(measure.cOthers{4,ii},pop0);
fReciprocityCheck(measure.cAll{4,ii},pop0);
fReciprocityCheck(measure.cRest{4,ii},pop0);


%% Phase 5 contacts:

% Contact matrices weightings:
measure.wHome{5,ii} = 1;
measure.wWork{5,ii} = 1;
measure.wSchool{5,ii} = 1;
measure.wOthers{5,ii} = 1;

% Contact matrices (auto):
measure.cHome{5,ii} = measure.wHome{5,ii}.*cHome;
measure.cWork{5,ii} = measure.wWork{5,ii}.*cWork;
measure.cSchool{5,ii} = measure.wSchool{5,ii}.*cSchool;
measure.cOthers{5,ii} = measure.wOthers{5,ii}.*cOthers;
measure.cAll{5,ii} = measure.cHome{5,ii}+measure.cWork{5,ii}+measure.cSchool{5,ii}+measure.cOthers{5,ii};
measure.cRest{5,ii} = measure.cAll{5,ii}-measure.cWork{5,ii};

% Verify that contact matrices satisfy the reciprocity condition (auto):
fReciprocityCheck(measure.cHome{5,ii},pop0);
fReciprocityCheck(measure.cWork{5,ii},pop0);
fReciprocityCheck(measure.cSchool{5,ii},pop0);
fReciprocityCheck(measure.cOthers{5,ii},pop0);
fReciprocityCheck(measure.cAll{5,ii},pop0);
fReciprocityCheck(measure.cRest{5,ii},pop0);