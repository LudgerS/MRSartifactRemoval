%% fitPeakAndCoupledArtifacts.m
%
% part of https://github.com/LudgerS/MRSartifactRemoval  
%
% Fits the sum of three complex Voigt peaks to spectrum of which two are
% coupled regarding their amplitude.
% Bayesian priors are placed on the peak locations, widths, Voigt mixing
% ratios, the ratio between the coupled peaks, and the 1st order phase 
% correction.
% 
% Where applicable input variables should use matching units:
%   specAxis - the frequency domain x-axis
%   spectrum - the frequency domain data
%   peakPriorMu - prior mean values for the signal peak
%   peakPriorSigma - prior standard deviations for the signal peak
%   artifactPriorsMu - prior mean values for the coupled artifact peaks
%   artifactPriorsSigma - prior standard deviations for the coupled artifact peaks
%   pCorr1Sigma - standard deviation 1st order phase correction
%   startingPhase - 0th order phase correction starting values for each peak
%   dataSigma - noise standard deviation
%
%
% Please see the readme and MRSartifactRemoval.pdf for details on the 
% provided functionality and its application.
%
% Written by Ludger Starke; Max Delbrück Center for Molecular Medicine in
% the Helmholtz Association, Berlin; 22-04-29
%
% License: GNU GPLv3 

function [fit, fittedLine, startingLine, artifact] = fitPeakAndCoupledArtifacts(specAxis, spectrum, peakPriorMu, peakPriorSigma,...
                                                                        artifactPriorsMu, artifactPriorsSigma, pCorr1Sigma,...
                                                                        startingPhase, dataSigma)
%% adjust array orientations
% lsqnonlin expects row vector parameters of the fit function

originalSize = size(spectrum);
specAxis = specAxis(:)';
spectrum = spectrum(:).';
                                                                    
                                                                    
                                                                    %% model 3 complex Voigt peaks, the amplitudes of no. 2 and 3 are coupled
% p = [[area_1, area_2, ratio], centers, fwhms, mixingRatios, phases, pCorr1]
fitFunction = @(p) tripleVoigtSpectrum(specAxis, [p(1), p(2)*p(3), p(2)*(1 - p(3))],...
                                            p(4:6), p(7:9), p(10:12), p(13:15), p(16));
                                        
%% sort priors
% No priors are set for the areas and phases.
% Prior arrays: [ratio, centers, fwhms, mixingRatios, pCorr1]
% The prior means also serve as starting values.
priorsMu = [artifactPriorsMu.ratio;...
                [peakPriorMu.center; artifactPriorsMu.centers(:)];...
                [peakPriorMu.fwhm; artifactPriorsMu.fwhms(:)];...
                [peakPriorMu.mixing; artifactPriorsMu.mixing(:)]; 0]';
            
priorsSigma = [artifactPriorsSigma.ratio;...
                   [peakPriorSigma.center; artifactPriorsSigma.centers(:)];...
                   [peakPriorSigma.fwhm; artifactPriorsSigma.fwhms(:)];...
                   [peakPriorSigma.mixing; artifactPriorsSigma.mixing(:)]; pCorr1Sigma]';
            
%% preparation non-linear least squares fit
% tighter bounds could be used to avoid selection of unwanted local minima, 
% yet this currently does not seem necessary
options = optimoptions('lsqnonlin', 'Algorithm', 'trust-region-reflective', 'MaxFunctionEvaluations', 2000);
lowerBounds = [0, 0, 0, [-Inf, -Inf, -Inf], [0, 0, 0], [0, 0, 0], [0, 0, 0], -Inf];        
upperBounds = [Inf, Inf, 1, [Inf, Inf, Inf], [Inf, Inf, Inf], [1, 1, 1], [360, 360, 360], Inf];     

deviationFunction = @(p) abs(spectrum - fitFunction(p));                                        
logBayesPosterior = @(p) [deviationFunction(p)/dataSigma, ((p([3:12, 16]) - priorsMu)./priorsSigma)];

%% compute and collect starting values
areaEstimates = getAreaStartingValues(abs(spectrum), specAxis, priorsMu(2:4), priorsMu(5:7));              
startingValues = [areaEstimates(1), sum(areaEstimates(2:3)), priorsMu(1:10), startingPhase(:)', priorsMu(11)];

startingLine = fitFunction(startingValues);

%% do fit, compute fitted line and artifact
[fit, resnorm, residual, exitflag, output, lambda, J] = lsqnonlin(logBayesPosterior, startingValues, lowerBounds, upperBounds, options);
fittedLine = fitFunction(fit);

artifact = doubleVoigtSpectrum(specAxis, [fit(2)*fit(3); fit(2)*(1 - fit(3))],...
                                            fit(5:6), fit(8:9), fit(11:12), fit(14:15), fit(16));

%% reshape outputs
fittedLine = reshape(fittedLine, originalSize);
startingLine = reshape(startingLine, originalSize);
artifact = reshape(artifact, originalSize);

