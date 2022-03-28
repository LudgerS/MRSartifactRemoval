function line = complexVoigtWithPhase(specAxis, area, center, fwhm, mixingRatio, phase, pCorr1)
line = area*exp(-1i*phase*pi/180)*complexVoigt(specAxis, center, fwhm, mixingRatio);

% 1st order phase correction
line = exp(-1i*specAxis*pCorr1).*line;


        