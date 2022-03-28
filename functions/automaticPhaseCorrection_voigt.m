function [spectrum, peakCenter, fwhm, finalLine] = automaticPhaseCorrection_voigt(specAxis, spectrum, peakCenterEstimate, fwhmEstimate)
% automatic 0th-order phase correction for a single peak
% fits a complex lorentzian to find the phase correction value
% specAcis, peakCenter and fwhmEstimate need to be in the same units, e.g.
% ppm or kHz

%% preparation
% params: [area, center, fwhm, mixingRatio, phase, pCorr1]
fitFunction = @(params) complexVoigtWithPhase(specAxis, params(1), params(2), params(3), params(4), params(5), params(6));
% guide 1st-order phase correction towards 0 so that it does not substitute
% the phase itself
pCorr1Sigma = 0.1;
deviationFunction = @(params) [abs(spectrum(:) - fitFunction(params));  params(6)/pCorr1Sigma];

options = optimoptions(@lsqnonlin, 'Algorithm', 'trust-region-reflective');
lowerBound = [0, -Inf, 0, 0, 0, -Inf];
upperBound = [Inf, Inf, Inf, 1, 360, Inf];

area0 = getAreaStartingValues(abs(spectrum), specAxis, peakCenterEstimate, fwhmEstimate);

%% try different phase starting values and use the fit with the smallest resnorm
% offset starting values can lead to a local extremum being selected
phase0s = [0, 45, 90, 135, 180, 225, 270, 315];
% phase0s = [0, 90, 180, 270];
allFits = cell(1, numel(phase0s));
resnorm = zeros(1, numel(phase0s));

for ii = 1:numel(phase0s)
    x0 = [area0, peakCenterEstimate, fwhmEstimate, 0.8, phase0s(ii), 0];
    [allFits{ii}, resnorm(ii), ~, ~, ~, ~, ~] = lsqnonlin(deviationFunction, x0, lowerBound, upperBound, options);
end

[~, I] = min(resnorm);
fit = allFits{I};

%% apply phase correction and compute fitted line
spectrum = applyPhaseCorr(specAxis, spectrum, -fit(5), -fit(6), 0);

peakCenter = fit(2);
fwhm = fit(3);

finalLine = fit(1)*complexLorentzian(specAxis, peakCenter, fwhm);
