%--------------------------------------------------------------------------
% Age-structured SEIR model for analyzing the impact of different 
% age-selective physical distancing control measures on the cumulative 
% number of COVID-19 related deaths and the number of people in the 
% active workforce in the setting of Wuhan.
% 
% Main script
% 
% Authors:
% Noé Ortega-Quijano
% Daniel Ortega-Quijano
%% ------------------------------------------------------------------------

clc
clear all
close all

% Plot parameters:
lineWidth = 1.5;
fontSize = 18;
% Plot colormaps:
cm1 = [1 1 1;0.98412698507309 0.990102708339691 0.994148790836334;0.968253970146179 0.980205416679382 0.988297522068024;0.952380955219269 0.970308125019073 0.982446312904358;0.936507940292358 0.960410833358765 0.976595103740692;0.920634925365448 0.950513541698456 0.970743834972382;0.904761910438538 0.940616250038147 0.964892625808716;0.888888895511627 0.930718958377838 0.95904141664505;0.873015880584717 0.920821666717529 0.95319014787674;0.857142865657806 0.91092437505722 0.947338938713074;0.841269850730896 0.901027083396912 0.941487729549408;0.825396835803986 0.891129791736603 0.935636460781097;0.809523820877075 0.881232500076294 0.929785251617432;0.793650805950165 0.871335208415985 0.923934042453766;0.777777791023254 0.861437916755676 0.918082773685455;0.761904776096344 0.851540625095367 0.91223156452179;0.746031761169434 0.841643333435059 0.906380355358124;0.730158746242523 0.83174604177475 0.900529086589813;0.714285731315613 0.821848750114441 0.894677877426147;0.698412716388702 0.811951458454132 0.888826668262482;0.682539701461792 0.802054166793823 0.882975399494171;0.666666686534882 0.792156875133514 0.877124190330505;0.650793671607971 0.782259583473206 0.87127298116684;0.634920656681061 0.772362291812897 0.865421712398529;0.61904764175415 0.762465000152588 0.859570503234863;0.60317462682724 0.752567708492279 0.853719294071198;0.58730161190033 0.74267041683197 0.847868025302887;0.571428596973419 0.732773125171661 0.842016816139221;0.555555582046509 0.722875833511353 0.836165606975555;0.539682567119598 0.712978541851044 0.830314338207245;0.523809552192688 0.703081250190735 0.824463129043579;0.507936537265778 0.693183958530426 0.818611919879913;0.492063492536545 0.683286666870117 0.812760651111603;0.476190477609634 0.673389375209808 0.806909441947937;0.460317462682724 0.6634920835495 0.801058232784271;0.444444447755814 0.653594791889191 0.795206964015961;0.428571432828903 0.643697500228882 0.789355754852295;0.412698417901993 0.633800208568573 0.783504545688629;0.396825402975082 0.623902916908264 0.777653276920319;0.380952388048172 0.614005625247955 0.771802067756653;0.365079373121262 0.604108333587646 0.765950858592987;0.349206358194351 0.594211041927338 0.760099589824677;0.333333343267441 0.584313750267029 0.754248380661011;0.31746032834053 0.57441645860672 0.748397171497345;0.30158731341362 0.564519166946411 0.742545902729034;0.28571429848671 0.554621875286102 0.736694693565369;0.269841283559799 0.544724583625793 0.730843484401703;0.253968268632889 0.534827291965485 0.724992215633392;0.238095238804817 0.524930000305176 0.719141006469727;0.222222223877907 0.515032708644867 0.713289797306061;0.206349208950996 0.505135416984558 0.70743852853775;0.190476194024086 0.495238095521927 0.701587319374084;0.174603179097176 0.485340803861618 0.695736110210419;0.158730164170265 0.475443512201309 0.689884841442108;0.142857149243355 0.465546220541 0.684033632278442;0.126984134316444 0.455648928880692 0.678182423114777;0.111111111938953 0.445751637220383 0.672331154346466;0.095238097012043 0.435854345560074 0.6664799451828;0.0793650820851326 0.425957053899765 0.660628736019135;0.0634920671582222 0.416059762239456 0.654777467250824;0.0476190485060215 0.406162470579147 0.648926258087158;0.0317460335791111 0.396265178918839 0.643075048923492;0.0158730167895555 0.38636788725853 0.637223780155182;0 0.376470595598221 0.631372570991516];
cm2 = [1 1 1;0.997634589672089 0.98929351568222 0.985683143138885;0.995269238948822 0.978586971759796 0.971366345882416;0.992903828620911 0.967880487442017 0.957049489021301;0.990538418292999 0.957174003124237 0.942732632160187;0.988173067569733 0.946467459201813 0.928415834903717;0.985807657241821 0.935760974884033 0.914098978042603;0.98344224691391 0.925054490566254 0.899782121181488;0.981076896190643 0.914347946643829 0.885465323925018;0.978711485862732 0.90364146232605 0.871148467063904;0.976346075534821 0.89293497800827 0.856831610202789;0.973980724811554 0.882228434085846 0.84251481294632;0.971615314483643 0.871521949768066 0.828197956085205;0.969249904155731 0.860815465450287 0.813881099224091;0.966884553432465 0.850108921527863 0.799564242362976;0.964519143104553 0.839402437210083 0.785247445106506;0.962153732776642 0.828695952892303 0.770930588245392;0.959788382053375 0.817989408969879 0.756613731384277;0.957422971725464 0.8072829246521 0.742296934127808;0.955057561397552 0.79657644033432 0.727980077266693;0.952692210674286 0.785869896411896 0.713663220405579;0.950326800346375 0.775163412094116 0.699346423149109;0.947961390018463 0.764456868171692 0.685029566287994;0.945596039295197 0.753750383853912 0.67071270942688;0.943230628967285 0.743043899536133 0.65639591217041;0.940865218639374 0.732337355613708 0.642079055309296;0.938499867916107 0.721630871295929 0.627762198448181;0.936134457588196 0.710924386978149 0.613445401191711;0.933769047260284 0.700217843055725 0.599128544330597;0.931403696537018 0.689511358737946 0.584811687469482;0.929038286209106 0.678804874420166 0.570494890213013;0.926672875881195 0.668098330497742 0.556178033351898;0.924307525157928 0.657391846179962 0.541861176490784;0.921942114830017 0.646685361862183 0.527544379234314;0.919576704502106 0.635978817939758 0.513227522373199;0.917211353778839 0.625272333621979 0.498910665512085;0.914845943450928 0.614565849304199 0.484593838453293;0.912480533123016 0.603859305381775 0.470277011394501;0.91011518239975 0.593152821063995 0.455960154533386;0.907749772071838 0.582446336746216 0.441643327474594;0.905384361743927 0.571739792823792 0.427326500415802;0.90301901102066 0.561033308506012 0.413009643554688;0.900653600692749 0.550326824188232 0.398692816495895;0.898288190364838 0.539620280265808 0.384375959634781;0.895922839641571 0.528913795948029 0.370059132575989;0.89355742931366 0.518207311630249 0.355742305517197;0.891192018985748 0.507500767707825 0.341425448656082;0.888826668262482 0.496794283390045 0.32710862159729;0.88646125793457 0.486087769269943 0.312791794538498;0.884095847606659 0.475381284952164 0.298474937677383;0.881730496883392 0.464674770832062 0.284158110618591;0.879365086555481 0.45396825671196 0.269841283559799;0.87699967622757 0.44326177239418 0.255524426698685;0.874634325504303 0.432555258274078 0.241207599639893;0.872268915176392 0.421848744153976 0.226890757679939;0.86990350484848 0.411142230033875 0.212573915719986;0.867538154125214 0.400435745716095 0.198257088661194;0.865172743797302 0.389729231595993 0.183940246701241;0.862807333469391 0.379022717475891 0.169623404741287;0.860441982746124 0.368316233158112 0.155306562781334;0.858076572418213 0.35760971903801 0.140989735722542;0.855711162090302 0.346903204917908 0.126672893762589;0.853345811367035 0.336196720600128 0.112356051802635;0.850980401039124 0.325490206480026 0.0980392172932625];

%% LOAD DEMOGRAPHIC DATA AND CONTACT MATRICES
% Note: these .mat files contains variables with the same names as the files
% (1,1) is the element corresponding to the youngest group

% Population (Wuhan):
load('./data/popWuhan.mat')

% Contact matrices proyected for Wuhan:
load('./data/cHome.mat')
load('./data/cWork.mat')
load('./data/cSchool.mat')
load('./data/cOthers.mat')
cAll = cHome+cWork+cSchool+cOthers;

%% PROCESS DEMOGRAPHIC DATA

% Initial population data:
ageNOrig = 16;
pop0Orig = popWuhan;

% Re-group population vector for age ranges of 10 years:
ageN = 8;
pop0 = zeros(1,ageN);
pop0 = [sum(popWuhan(1:2)),sum(popWuhan(3:4)),sum(popWuhan(5:6)),sum(popWuhan(7:8)),sum(popWuhan(9:10)),sum(popWuhan(11:12)),sum(popWuhan(13:14)),sum(popWuhan(15:16))];

% Total population:
popN = sum(pop0);
% Age ranges (initial age of each range):
ageRanges = linspace(0,80,ageN+1);
% Age ranges strings (this will be used for plotting their labels):
ageRangesStr = strcat(num2str(ageRanges'),'-',num2str(circshift(ageRanges',-1)));


%% PROCESS CONTACT MATRICES

% Save original contact matrices:
cHomeOrig = cHome;
cWorkOrig = cWork;
cSchoolOrig = cSchool;
cOthersOrig = cOthers;
cAllOrig = cAll;

% Calculate total number of contacts for the new age groups:
cHomeContacts = repmat(pop0Orig,[ageNOrig,1]).*cHomeOrig;
cWorkContacts = repmat(pop0Orig,[ageNOrig,1]).*cWorkOrig;
cSchoolContacts = repmat(pop0Orig,[ageNOrig,1]).*cSchoolOrig;
cOthersContacts = repmat(pop0Orig,[ageNOrig,1]).*cOthersOrig;
cAllContacts = cHomeContacts+cWorkContacts+cSchoolContacts+cOthersContacts;

% Re-group contact matrices for new age groups:
cHome = zeros(ageN,ageN);
cWork = zeros(ageN,ageN);
cSchool = zeros(ageN,ageN);
cOthers = zeros(ageN,ageN);
for cc=1:ageN
    for rr=1:ageN
        cHome(rr,cc) = (sum(cHomeContacts(2*rr-1:2*rr,2*cc-1:2*cc),'all')/pop0(cc));
        cWork(rr,cc) = (sum(cWorkContacts(2*rr-1:2*rr,2*cc-1:2*cc),'all')/pop0(cc));
        cSchool(rr,cc) = (sum(cSchoolContacts(2*rr-1:2*rr,2*cc-1:2*cc),'all')/pop0(cc));
        cOthers(rr,cc) = (sum(cOthersContacts(2*rr-1:2*rr,2*cc-1:2*cc),'all')/pop0(cc));
    end
end

cAll = cHome+cWork+cSchool+cOthers;
cRest = cAll-cWork;

% Graphical output of contact matrices (original versus regrouped):
figure('Name','Contact matrices (16 vs 8 age groups)')
set(gca,'fontsize',fontSize)

s = subplot(2,4,1);
imagesc(cHomeOrig)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Home')

s = subplot(2,4,2);
imagesc(cWorkOrig)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Work')

s = subplot(2,4,3);
imagesc(cSchoolOrig)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('School')

s = subplot(2,4,4);
imagesc(cOthersOrig)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Others')

s = subplot(2,4,5);
imagesc(cHome)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Home')

s = subplot(2,4,6);
imagesc(cWork)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Work')

s = subplot(2,4,7);
imagesc(cSchool)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('School')

s = subplot(2,4,8);
imagesc(cOthers)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Others')

% Graphical output of contact matrices (original versus regrouped):
figure('Name','Contact matrices (8 age groups, work vs rest)')

s = subplot(2,4,1);
imagesc(cHome)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Home')
set(gca,'fontsize',fontSize)

s = subplot(2,4,2);
imagesc(cWork)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Work')
set(gca,'fontsize',fontSize)

s = subplot(2,4,3);
imagesc(cSchool)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('School')
set(gca,'fontsize',fontSize)

s = subplot(2,4,4);
imagesc(cOthers)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Others')
set(gca,'fontsize',fontSize)

s = subplot(2,4,6);
imagesc(cWork)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Work')
set(gca,'fontsize',fontSize)

s = subplot(2,4,7);
imagesc(cRest)
axis xy; axis image; colormap(s,cm1); colorbar
xlabel('Age group'); ylabel('Number of contacts')
title('Rest')
set(gca,'fontsize',fontSize)

%% COMPARTMENTAL MODEL PARAMETERS

% Time unit is days

% Periods:
incubationDays = 5.2;
infectionDays = 2.9;
confirmationDays = 6.1;

% Basic reproductive ratio for all the population (# of secundary infections from a single individual):
R0 = 2.55;

% Total daily contacts per age group:
dailyContactsAge = sum(cAllContacts);
% Mean daily contacts for all the population (weighted mean):
dailyContactsMean = sum(dailyContactsAge,2)/sum(pop0Orig);

% Probability of transmission for all the population:
probT = (R0/infectionDays)/dailyContactsMean;  % This is a biological-meaningful value, fixed for all the population

% Transmission rate (incorporates the encounter rate between susceptible and infectious individuals together with the probability of transmission):
beta = R0*(1/infectionDays);  % This is not used in the model, as the contact matrices model already uses the encounter rate and the probability of transmission

% Infection rate (exposed to infectious):
sigma = 1/incubationDays;

% Recovery rate (infectious to recovered):
gamma = 1/infectionDays;

% Reporting rate (onset to confirmation):
kappa = 1/confirmationDays;

% Case fatality ratio (mortality) by age group:
CFR = (1/100)*[0.00329 0.0154 0.0608 0.155 0.287 1.26 4.03 10.3];

% Graphical output of case fatality ratios:
figure('Name','Case fatality ratio')

bar(100*CFR)
grid on
xticklabels({'10','20','30','40','50','60','70','80'})
xlabel('Age group (years)')
ylabel('CFR [%]')
set(gca,'fontsize',fontSize)

%% NUMERICAL SIMULATION PARAMETERS

% Start date:
dateInitial = datetime(2019,11,22);
% End date:
dateFinal = datetime(2020,10,1);

% Initial population:
S0 = pop0;
E10 = zeros(1,ageN);
E20 = zeros(1,ageN);
I10 = zeros(1,ageN);
I20 = zeros(1,ageN);
R0 = zeros(1,ageN);
Icum0 = zeros(1,ageN);

% Age group of the initial infectious:
ageGroupInf0 = 5;
% Number of initial infectious individuals in that group:
nInf0 = 1;
% Automatically update initial population:
S0(ageGroupInf0) = S0(ageGroupInf0)-nInf0;
I10(ageGroupInf0) = nInf0;

%% LOCKDOWN MEASURES DEFINITION

measure = struct;

% Total number of measures to be simulated:
measureNT = 4;

% Execute measure configuration scripts:
measure01
measure02
measure03
measure04

%% LOCKDOWN MEASURES SIMULATION

for ii=1:measureNT
    
    timeVector = [];
    pop = [];
    
    % Numerical simulation (ODE, ordinary differential equations)
    
    for jj=1:measure.nPhases{ii}
        
        % Load measure dates:
        dateStart = measure.phaseDate{jj,ii};
        dateEnd = measure.phaseDate{jj+1,ii};
        % Load measure contact matrices:
        cWork = measure.cWork{jj,ii};
        cAll = measure.cAll{jj,ii};
        cRest = measure.cRest{jj,ii};
        
        if(isempty(timeVector))
            % Initialize:
            timeVector = [0];
        end
        % Start time for current phase simulation:
        timeStart = timeVector(end);
        % End time for current phase simulation:
        timeEnd = days(dateEnd-dateInitial);
        % Total time range:
        timeRange = [timeStart,timeEnd];
        
        if(isempty(pop))
            % Initialize populations:
            S = S0;
            E1 = E10;
            E2 = E20;
            I1 = I10;
            I2 = I20;
            R = R0;
            Icum = Icum0;
        end
        
        % Define initial population vector for current phase (column vector, required by ODE solver):
        pop0v = [S(end,:)';E1(end,:)';E2(end,:)';I1(end,:)';I2(end,:)';R(end,:)';Icum(end,:)'];
        
        % ODE solver options:
        odeOptions = odeset('RelTol',1e-5);
        
        % Model parameters:
        modelParams = [probT,sigma,gamma,kappa];
        
        % ODE solver:
        [timeVals,pop] = ode45(@fModelEqs,timeRange,pop0v,odeOptions,modelParams,cAll,ageN);
        
        % Concatenate time vector:
        timeVector = [timeVector; timeVals(2:end)];
        
        % Results retrieval: population evolution as a function of time
        % Note: columns correspond to age groups, rows corresponds to time
        S = [S; pop(2:end,1:ageN)];
        E1 = [E1; pop(2:end,ageN+1:2*ageN)];
        E2 = [E2; pop(2:end,2*ageN+1:3*ageN)];
        I1 = [I1; pop(2:end,3*ageN+1:4*ageN)];
        I2 = [I2; pop(2:end,4*ageN+1:5*ageN)];
        R = [R; pop(2:end,5*ageN+1:6*ageN)];
        Icum = [Icum; pop(2:end,6*ageN+1:7*ageN)];
        
    end
    
    % Time vector day-wise (1-day spacing between days):
    timeVectorDays = linspace(0,timeEnd,timeEnd+1);
    % Convert numerical vector into dates vector (just for displaying dates in the figures):
    dateVectorDays = dateInitial+days(timeVectorDays);
    
    % Interpolate results in order to have daily data:
    S = interp1(timeVector,S,timeVectorDays);
    E1 = interp1(timeVector,E1,timeVectorDays);
    E2 = interp1(timeVector,E2,timeVectorDays);
    I1 = interp1(timeVector,I1,timeVectorDays);
    I2 = interp1(timeVector,I2,timeVectorDays);
    R = interp1(timeVector,R,timeVectorDays);
    Icum = interp1(timeVector,Icum,timeVectorDays);
    
    % Store results:
    results.timeVectorDays{ii} = timeVectorDays;
    results.dateVectorDays{ii} = dateVectorDays;
    results.S{ii} = S;
    results.E1{ii} = E1;
    results.E2{ii} = E2;
    results.I1{ii} = I1;
    results.I2{ii} = I2;
    results.R{ii} = R;
    results.Icum{ii} = Icum;
    
end


%% RESULTS ANALYSIS AND GRAPHICAL OUTPUT


% GLOBAL VIEW OF CONTACT MATRICES 1
figure()

s = subplot(4,3,1);
imagesc(measure.cWork{1,1})
axis xy; axis image; colormap(s,cm1); caxis([0,2]); colorbar
xticklabels({});
yticklabels({'20','40','60','80'})
ylabel('Contact age (years)')
title('Work')
set(gca,'fontsize',fontSize)

s = subplot(4,3,2);
imagesc(measure.cRest{1,1})
axis xy; axis image; colormap(s,cm1); caxis([0,5]); colorbar
xticklabels({}); yticklabels({})
title('Rest')
set(gca,'fontsize',fontSize)

s = subplot(4,3,3);
imagesc(measure.cAll{1,1})
axis xy; axis image; colormap(s,cm1); caxis([0,6]); colorbar
xticklabels({}); yticklabels({})
title('All')
set(gca,'fontsize',fontSize)

s = subplot(4,3,4);
imagesc(measure.cWork{3,2})
axis xy; axis image; colormap(s,cm1); caxis([0,0.1]); colorbar
xticklabels({});
yticklabels({'20','40','60','80'})
ylabel('Contact age (years)')
set(gca,'fontsize',fontSize)

s = subplot(4,3,5);
imagesc(measure.cRest{3,2})
axis xy; axis image; colormap(s,cm1); caxis([0,1.5]); colorbar
xticklabels({}); yticklabels({})
set(gca,'fontsize',fontSize)

s = subplot(4,3,6);
imagesc(measure.cAll{3,2})
axis xy; axis image; colormap(s,cm1); caxis([0,1.5]); colorbar
xticklabels({}); yticklabels({})
set(gca,'fontsize',fontSize)

s = subplot(4,3,7);
imagesc(measure.cWork{3,3})
axis xy; axis image; colormap(s,cm1); caxis([0,0.1]); colorbar
xticklabels({});
yticklabels({'20','40','60','80'})
ylabel('Contact age (years)')
set(gca,'fontsize',fontSize)

s = subplot(4,3,8);
imagesc(measure.cRest{3,3})
axis xy; axis image; colormap(s,cm1); caxis([0,1.5]); colorbar
xticklabels({}); yticklabels({})
set(gca,'fontsize',fontSize)

s = subplot(4,3,9);
imagesc(measure.cAll{3,3})
axis xy; axis image; colormap(s,cm1); caxis([0,1.5]); colorbar
xticklabels({}); yticklabels({})
set(gca,'fontsize',fontSize)

s = subplot(4,3,10);
imagesc(measure.cWork{3,4})
axis xy; axis image; colormap(s,cm1); caxis([0,0.6]); colorbar
xticklabels({'20','40','60','80'})
xlabel('Individual age (years)')
yticklabels({'20','40','60','80'})
ylabel('Contact age (years)')
set(gca,'fontsize',fontSize)

s = subplot(4,3,11);
imagesc(measure.cRest{3,4})
axis xy; axis image; colormap(s,cm1); caxis([0,1.5]); colorbar
xticklabels({'20','40','60','80'})
yticklabels({});
xlabel('Individual age (years)')
set(gca,'fontsize',fontSize)

s = subplot(4,3,12);
imagesc(measure.cAll{3,4})
axis xy; axis image; colormap(s,cm1); caxis([0,1.5]); colorbar
xticklabels({'20','40','60','80'})
yticklabels({});
xlabel('Individual age (years)')
set(gca,'fontsize',fontSize)


% TOTAL CONTACTS PER AGE GROUP
figure()

s = subplot(4,1,1);
bar(sum(measure.cAll{1,1},1))
ylabel('Number of contacts')
xticklabels({});
title('Total per age group')
set(gca,'fontsize',fontSize)

s = subplot(4,1,2);
bar(sum(measure.cAll{3,2},1))
ylabel('Number of contacts')
xticklabels({});
set(gca,'fontsize',fontSize)

s = subplot(4,1,3);
bar(sum(measure.cAll{3,3},1))
ylabel('Number of contacts')
xticklabels({});
set(gca,'fontsize',fontSize)

s = subplot(4,1,4);
bar(sum(measure.cAll{3,4},1))
xticklabels({'','20','','40','','60','','80'})
ylabel('Number of contacts')
xlabel('Individual age (years)')
set(gca,'fontsize',fontSize)


measureInfecteds = zeros(measureNT,ageN);
measureDeceased = zeros(measureNT,ageN);
measureWorkforce = zeros(measureNT,1);
measureLegend = cell(measureNT,1);

for ii=1:measureNT
    
    % Load simulation results:
    timeVectorDays = results.timeVectorDays{ii};
    dateVectorDays = results.dateVectorDays{ii};
    S = results.S{ii};
    E1 = results.E1{ii};
    E2 = results.E2{ii};
    I1 = results.I1{ii};
    I2 = results.I2{ii};
    R = results.R{ii};
    Icum = results.Icum{ii};
    
    % Agregated population (sum of all age groups):
    STot = sum(S,2);
    E1Tot = sum(E1,2);
    E2Tot = sum(E2,2);
    I1Tot = sum(I1,2);
    I2Tot = sum(I2,2);
    RTot = sum(R,2);
    IcumTot = sum(Icum,2);
    
    % Daily variation per age group:
    Sd = diff(S,[],1);
    E1d = diff(E1,[],1);
    E2d = diff(E2,[],1);
    I1d = diff(I1,[],1);
    I2d = diff(I2,[],1);
    Rd = diff(R,[],1);
    Icumd = diff(Icum,[],1);
    
    % Agregated daily variation:
    STotd = diff(STot);
    E1Totd = diff(E1Tot);
    E2Totd = diff(E2Tot);
    I1Totd = diff(I1Tot);
    I2Totd = diff(I2Tot);
    RTotd = diff(RTot);
    IcumTotd = diff(IcumTot);
    
    
    % Find date vector index corresponding to 7 April (lockdown enddate eve):
    liftdate = '07-Apr-2020';
    if(ii==1)
        endDate = find(dateVectorDays=='07-Apr-2020');
    elseif(ii==2)
        endDate = find(dateVectorDays=='07-Apr-2020');
        dailyInfectedsCriterium = IcumTotd(endDate);
    else
        firstSearchDate = find(dateVectorDays=='23-Jan-2020');
        [~,endDate] = min(abs(IcumTotd(firstSearchDate:end)-dailyInfectedsCriterium));
        endDate = firstSearchDate+endDate;
    end
    
    % Workforce calculation (from 24 Jan):
    if(ii==1)
        % Workforce:
        wf = 0;
        wf = wf + days(measure.phaseDate{4,ii}-measure.phaseDate{3,ii})*sum(measure.cWork{3,ii},'All');
        wf = wf + days(measure.phaseDate{5,ii}-measure.phaseDate{4,ii})*sum(measure.cWork{4,ii},'All');
        wf = wf + days(dateVectorDays(endDate)-measure.phaseDate{5,ii})*sum(measure.cWork{5,ii},'All');
        % Total days:
        td = days(dateVectorDays(endDate)-measure.phaseDate{3,ii});
        % Workforce relative to Wuhan lockdown (does not apply to the first simulated scenario)
        wfRelative = 0;
    else
        % Workforce:
        wf = days(dateVectorDays(endDate)-datetime(2020,1,24))*sum(measure.cWork{3,ii},'All');
        % Total days:
        td = days(dateVectorDays(endDate)-datetime(2020,1,24));
        % Workforce relative to Wuhan lockdown (does not apply to the first simulated scenario)
        wfWuhanLockdown = days(dateVectorDays(endDate)-datetime(2020,1,24))*sum(measure.cWork{3,2},'All');
        wfRelative = 100*wf/wfWuhanLockdown;
        
    end
    
    % AGREGATED CURVES
    figure('Name',measure.Desc{ii})
    plot(dateVectorDays(1:endDate),[STot(1:endDate),E1Tot(1:endDate),E2Tot(1:endDate),I1Tot(1:endDate),I2Tot(1:endDate),RTot(1:endDate)],'linewidth',lineWidth)
    xlabel('Date'); xlim([dateVectorDays(1),dateVectorDays(endDate)])
    ylabel('Number of individuals'); %ylim([0 popN])
    fFormatIntLabelsAxis('y');
    legend('S','E1','E2','I1','I2','R')
    grid on
    
    
    % DAILY AND CUMULATED INFECTED
    figure('Name',measure.Desc{ii})
    
    subplot(2,1,1)
    plot(dateVectorDays(2:endDate),IcumTotd(1:endDate-1),'Color','#0072BD','linewidth',lineWidth)
    xlabel('Date'); xlim([dateVectorDays(1),dateVectorDays(endDate)])
    ylabel('Number of individuals')
    fFormatIntLabelsAxis('y');
    title('Daily infected')
    grid on
    set(gca,'fontsize',fontSize)
    
    subplot(2,1,2)
    plot(dateVectorDays(1:endDate),IcumTot(1:endDate),'Color','#0072BD','linewidth',lineWidth)
    xlabel('Date'); xlim([dateVectorDays(1),dateVectorDays(endDate)])
    ylabel('Number of individuals')
    fFormatIntLabelsAxis('y');
    title('Cumulated infected')
    grid on
    set(gca,'fontsize',fontSize)
    
    
    % DAILY INFECTED AS A FUNCTION OF DATE AND AGE GROUP
    figure('Name',measure.Desc{ii})
    
    subplot(1,2,1)
    imagesc(Icumd(1:endDate,:)')
    axis xy; colorbar; set(colorbar,'TickLabels',{});
    xlabel('Day'); ylabel('Age group (years)')
    yticks([1 2 3 4 5 6 7 8])
    yticklabels({'10' '20' '30' '40' '50' '60' '70' '80'})
    title('Daily infected')
    set(gca,'fontsize',fontSize)
    
    subplot(1,2,2)
    surf(Icumd(1:endDate,:)')
    view(55,25)
    xlabel('Day'); ylabel('Age group (years)'); zlabel('Number of individuals')
    yticks([0 2 4 6 8])
    yticklabels({'0' '20' '40' '60' '80'})
    fFormatIntLabelsAxis('z');
    title('Daily infected')
    set(gca,'fontsize',fontSize)
    
    
    % INFECTED AND DECEASED
    figure('Name',measure.Desc{ii})
    
    subplot(4,2,1)
    bar(pop0,'FaceColor','#77AC30','EdgeColor','k')
    ylabel('#')
    fFormatIntLabelsAxis('y');
    title(sprintf('Population (tot=%d)',sum(pop0)))
    
    subplot(4,2,2)
    bar(dailyContactsAge,'FaceColor',[0.5 0.5 0.5],'EdgeColor','k')
    ylabel('#')
    fFormatIntLabelsAxis('y');
    title('Total daily contacts per age group')
    
    subplot(4,2,3)
    bar(max(Icum(1:endDate,:)),'FaceColor','#0072BD','EdgeColor','k')
    ylabel('#')
    fFormatIntLabelsAxis('y');
    title(sprintf('Cumulated infected (tot=%.1f)',sum(max(Icum(1:endDate,:)))))
    
    subplot(4,2,4)
    bar(100*max(Icum(1:endDate,:)./pop0,[],1),'FaceColor','#4DBEEE','EdgeColor','k')
    ylabel('Per 100')
    fFormatIntLabelsAxis('y');
    title(sprintf('Cumulated infected relative to population in each group (tot=%.1f)',100*sum(max(Icum(1:endDate,:)./pop0,[],1))))
    
    subplot(4,2,5)
    bar(CFR.*max(Icum(1:endDate,:),[],1),'FaceColor','#A2142F','EdgeColor','k')
    ylabel('#')
    fFormatIntLabelsAxis('y');
    title(sprintf('Cumulated deceased (tot=%.1f) ',sum(CFR.*max(Icum(1:endDate,:)))))
    
    subplot(4,2,6)
    bar(1000*CFR.*max(Icum(1:endDate,:)./pop0,[],1),'FaceColor','#EDB120','EdgeColor','k')
    ylabel('Per 1000')
    fFormatIntLabelsAxis('y');
    title(sprintf('Cumulated deceased relative to population in each group (tot=%.4f)',1000*sum(CFR.*max(Icum(1:endDate,:)./pop0,[],1))))
    
    subplot(4,2,7)
    bar(100*CFR.*max(Icum(1:endDate,:),[],1)/sum(CFR.*max(Icum(1:endDate,:),[],1)),'FaceColor','#D95319','EdgeColor','k')
    ylabel('Per 100')
    fFormatIntLabelsAxis('y');
    title('Deceased relative to all deceased')
    
    
    % INFECTED AND DECEASED
    figure('Name',measure.Desc{ii})
    
    subplot(2,2,1)
    bar(max(Icum(1:endDate,:)),'FaceColor','#0072BD','EdgeColor','k')
    xticklabels({'10','20','30','40','50','60','70','80'})
    xlabel('Age group (years)')
    ylabel('Number of individuals')
    fFormatIntLabelsAxis('y');
    title('Cumulated infected')
    set(gca,'fontsize',fontSize)
    
    subplot(2,2,2)
    bar(100*max(Icum(1:endDate,:)./pop0,[],1),'FaceColor','#4DBEEE','EdgeColor','k')
    xticklabels({'10','20','30','40','50','60','70','80'})
    xlabel('Age group (years)')
    ylabel('Per 100')
    fFormatIntLabelsAxis('y');
    title('Cumulated infected relative to population')
    set(gca,'fontsize',fontSize)
    
    subplot(2,2,3)
    bar(CFR.*max(Icum(1:endDate,:),[],1),'FaceColor','#A2142F','EdgeColor','k')
    xticklabels({'10','20','30','40','50','60','70','80'})
    xlabel('Age group (years)')
    ylabel('Number of individuals')
    fFormatIntLabelsAxis('y');
    title('Cumulated deceased')
    set(gca,'fontsize',fontSize)
    
    subplot(2,2,4)
    bar(1000*CFR.*max(Icum(1:endDate,:)./pop0,[],1),'FaceColor','#EDB120','EdgeColor','k')
    xticklabels({'10','20','30','40','50','60','70','80'})
    xlabel('Age group (years)')
    ylabel('Per 1000')
    fFormatIntLabelsAxis('y');
    title('Cumulated deceased relative to population')
    set(gca,'fontsize',fontSize)
    
    
    % INFECTED AND DECEASED (simplified)
    % DAILY AND CUMULATED INFECTED (same graph)
    figure('Name',measure.Desc{ii})
    
    subplot(2,2,[1,2])
    yyaxis left
    plot(dateVectorDays(2:endDate),IcumTotd(1:endDate-1),'Color','#0072BD','linewidth',lineWidth)
    fFormatIntLabelsAxis('y');
    yyaxis right
    plot(dateVectorDays(1:endDate),IcumTot(1:endDate),'linewidth',lineWidth)
    fFormatIntLabelsAxis('y');
    xlim([dateVectorDays(1),dateVectorDays(endDate)])
    legend('Daily','Cumulated')
    title('Infected individuals')
    grid on
    set(gca,'fontsize',fontSize)
    
    subplot(2,2,3)
    bar(max(Icum(1:endDate,:)),'FaceColor','#0072BD','EdgeColor','k')
    xticklabels({'10','20','30','40','50','60','70','80'})
    xlabel('Age group (years)')
    ylabel('Individuals')
    fFormatIntLabelsAxis('y');
    title('Cumulated infected')
    set(gca,'fontsize',fontSize)
    
    subplot(2,2,4)
    bar(CFR.*max(Icum(1:endDate,:),[],1),'FaceColor','#A2142F','EdgeColor','k')
    xticklabels({'10','20','30','40','50','60','70','80'})
    xlabel('Age group (years)')
    ylabel('Individuals')
    fFormatIntLabelsAxis('y');
    title('Cumulated deceased')
    set(gca,'fontsize',fontSize)
    
    
    % SAVE DATA FOR LAST COMPARATIVE:
    measureInfecteds(ii,:) = Icum(endDate,:);
    measureDeceased(ii,:) = CFR.*Icum(endDate,:);
    measureWorkforce(ii) = wfRelative;
    measureLegend{ii,1} = sprintf('Scenario %d',ii);
    
    % Display information:
    disp(sprintf('\nMeasure #%d',ii))
    disp(sprintf('Cumulated infected: %d',round(sum(Icum(endDate,:)))))
    disp(sprintf('Cumulated infected relative to population (per 100): %.2f',100*round(sum(Icum(endDate,:)))/popN))
    disp(sprintf('Deceased: %d',round(sum(CFR.*Icum(endDate,:)))))
    disp(sprintf('Deceased relative to population (per 10000): %.2f',10000*round(sum(CFR.*Icum(endDate,:)))/popN))
    disp(sprintf('Lockdown duration (days): %d', td))
    disp(sprintf('Total workforce: %.2f', wf))
    disp(sprintf('Workforce compared to Wuhan (per 100): %.2f', wfRelative))
    
end

% GLOBAL COMPARISON:
figure('Name','Global comparison')

subplot(1,3,1)
bar(measureDeceased(2:end,:)');
grid on
xticklabels({'10','20','30','40','50','60','70','80'})
xlabel('Age group (years)')
ylabel('Cumulated deceased')
set(gca,'fontsize',fontSize)

subplot(1,3,2)
bar([sum(measure.cWork{3,2},1);sum(measure.cWork{3,3},1);sum(measure.cWork{3,4},1)]');
grid on
xticklabels({'10','20','30','40','50','60','70','80'})
xlabel('Age group (years)')
ylabel('Daily work contacts')
set(gca,'fontsize',fontSize)

subplot(1,3,3)
for ii=2:measureNT
    scatter(measureWorkforce(ii),100*sum(measureDeceased(ii,:))./sum(measureDeceased(2,:)),'filled','SizeData',200)
    hold on
end
hold off
xlabel('Relative workforce (%)')
ylabel('Relative death toll (%)')
% Set limits by hand:
xlim([50,600])
% ylim([1800,2600])
grid on
legend(measureLegend(2:measureNT),'location','southeast')
set(gca,'fontsize',fontSize)


% GLOBAL COMPARISON 2:
figure('Name','Global comparison')

subplot(2,2,1)
bar(measureInfecteds(2:end,:)');
fFormatIntLabelsAxis('y');
grid on
xticklabels({'10','20','30','40','50','60','70','80'})
xlabel('Age group (years)')
ylabel('Cumulated infected')
set(gca,'fontsize',fontSize)

subplot(2,2,2)
bar(measureDeceased(2:end,:)');
grid on
xticklabels({'10','20','30','40','50','60','70','80'})
xlabel('Age group (years)')
ylabel('Cumulated deceased')
set(gca,'fontsize',fontSize)

subplot(2,2,3)
bar([sum(measure.cWork{3,2},1);sum(measure.cWork{3,3},1);sum(measure.cWork{3,4},1)]');
grid on
xticklabels({'10','20','30','40','50','60','70','80'})
xlabel('Age group (years)')
ylabel('Daily work contacts')
set(gca,'fontsize',fontSize)

subplot(2,2,4)
for ii=2:measureNT
    scatter(measureWorkforce(ii),100*sum(measureDeceased(ii,:))./sum(measureDeceased(2,:)),'filled','SizeData',200)
    hold on
end
hold off
xlabel('Relative workforce (%)')
ylabel('Relative death toll (%)')
% Set limits by hand:
xlim([50,600])
% ylim([1800,2600])
grid on
legend(measureLegend(2:measureNT),'location','southeast')
set(gca,'fontsize',fontSize)