%% demo.m
%
% part of https://github.com/LudgerS/MRSartifactRemoval  
%
% Demonstration script calling the artifact subtraction and phase 
% estimation functionality of
%   fitPeakAndCoupledArtifacts.m
% and
%   automaticPhaseCorrection_voigt.m
%
% To run the script, ensure that both exampleData.mat, priors.mat and the
% 'functions' folder are on the search path. This should automatically be 
% the case if the repository is simply downloaded and the scripts location
% is made the curent folder.
% 
% Please see readme and MRSartifactRemoval.pdf for details on the provided
% functionality and its application.
%
% Written by Ludger Starke; Max Delbrück Center for Molecular Medicine in
% the Helmholtz Association, Berlin; 22-04-29
%
% License: GNU GPLv3 

clear, close all
addpath([pwd, filesep, 'functions'])

%% 1. load data and priors
load('exampleData')
artifactPriors = load('priors');

%% 2. set parameters
% to account for shim effects and field drift
shimUncertaintyHz = 250;
shimUncertaintyPpm = freq2ppm(shimUncertaintyHz, params.freqRef) - freq2ppm(0, params.freqRef);

% softly bias 1st order phase correction towards 0
pCorr1Uncertainty = 20*10^-5*(specAxisHz(2) - specAxisHz(1))/(specAxisPpm(2) - specAxisPpm(1));

% width of display beyond the fitted peaks
dispBorder = 25;

%% 3. prepare data structure
spectrum.phaseCorrArtifact = spectrum.raw;
spectrum.removedArtifact = spectrum.raw;
spectrum.final = spectrum.raw;

%% 4. subtract backgound and estimate noise
background = false(size(specAxisPpm));
background([1:params.borderWidth, (end - params.borderWidth+1):end]) = true;

baseline = mean(spectrum.raw(background));
spectrum.removedBaseline = spectrum.raw - baseline; 

zeroFillFactor = params.FFTlength/params.nAcqPoints_shortened;
sigma = mean(std([real(spectrum.removedBaseline(background)); imag(spectrum.removedBaseline(background))]));
sigma = zeroFillFactor*sigma;

%% 5. find signal peak and phase starting values
% reevalutate section (ctrl + enter) to set parameters
peakPriorMu.center = -58.5;
peakPriorMu.fwhm = 3;
phaseStartingValues = [180, 0, 180];         % in degrees

plotSignalPeakEstimate(specAxisPpm, spectrum.removedBaseline, peakPriorMu.center , peakPriorMu.fwhm, artifactPriors.mu.centers(:))

%% 6. prepare additional prior values
peakPriorMu.mixing = 0.8;

% The fit function prepares the possibility to integrate prior knowledge on 
% the signal peak for added stability. In this application the uncertainty 
% on the signal peak priors is set very high to achieve unbiased,  
% effectively non-Bayesian estimates. 
peakPriorSigma.center = 10^6;
peakPriorSigma.fwhm = 10^6;
peakPriorSigma.mixing = 10^6;

% increase uncertainty on artifact centers to account for shim and field
% drift effects
artifactPriors.sigma.centers = sqrt(artifactPriors.sigma.centers.^2 + shimUncertaintyPpm.^2);

%% 7. do fit
[fit, fittedLine, startingLine, artifact] =...
            fitPeakAndCoupledArtifacts(specAxisPpm, spectrum.removedBaseline, peakPriorMu, peakPriorSigma,...
                                            artifactPriors.mu, artifactPriors.sigma, pCorr1Uncertainty,...
                                             phaseStartingValues, sigma);

%% 8. compute cleaned spectrum and do phase correction                                         
spectrum.cleaned = spectrum.removedBaseline - artifact;
[spectrum.final, peakCenter, fwhm, finalLine] =...
        automaticPhaseCorrection_voigt(specAxisPpm, spectrum.cleaned(:, 1), fit(4), fit(7));

    
%% 9. plot fit
allCenters = [peakPriorMu.center, artifactPriors.mu.centers];
zoomRange = [min(allCenters) - dispBorder, max(allCenters) + dispBorder];

imFile = [pwd, filesep, 'demoResults'];
plotFitAndPhaseCorrection(specAxisPpm, spectrum.removedBaseline,...
                                        spectrum.final, startingLine, fittedLine, zoomRange, imFile);    

                                    