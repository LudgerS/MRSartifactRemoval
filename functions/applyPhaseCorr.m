function correctedSpectrum = applyPhaseCorr(freqAxis, complexSpectrum, pCorr0, pCorr1, centerFreq)
% based on a script from Ariane Filmer

% 0th order correction
correctedSpectrum0 = exp(-1i*pCorr0*pi/180)*complexSpectrum;

% 1st order correction
freqAxis = freqAxis - centerFreq;

PhpFreq = freqAxis.*pCorr1;
correctedSpectrum = exp(-PhpFreq.*1i).*correctedSpectrum0;




