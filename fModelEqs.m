function modelEqs = fModelEqs(~,pop,modelParams,cAll,ageN)
% Calculates the differential rates used in the integration.
% Inputs:
% 
% Outputs:
% 

probT = modelParams(1);
sigma = modelParams(2);
gamma = modelParams(3);
kappa = modelParams(4);

S = pop(1:ageN)';
E1 = pop(ageN+1:2*ageN)';
E2 = pop(2*ageN+1:3*ageN)';
I1 = pop(3*ageN+1:4*ageN)';
I2 = pop(4*ageN+1:5*ageN)';
R = pop(5*ageN+1:6*ageN)';
Icum = pop(6*ageN+1:7*ageN)';

popN = S+E1+E2+I1+I2+R;

dS = -probT.*S.*((I1+I2)./popN)*cAll;
dE1 = probT.*S.*((I1+I2)./popN)*cAll -2*sigma*E1;
dE2 = 2*sigma*E1 -2*sigma*E2;
dI1 = 2*sigma*E2 -2*gamma*I1;
dI2 = 2*gamma*I1 -2*gamma*I2;
dR = 2*gamma*I2;
dIcum = 2*sigma*E2*exp(-gamma*kappa);

modelEqs = [dS';dE1';dE2';dI1';dI2';dR';dIcum'];

end