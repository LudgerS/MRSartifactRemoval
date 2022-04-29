% part of https://github.com/LudgerS/MRSartifactRemoval  

function line = doubleVoigtSpectrum(specAxis, areas, centers, fwhms, mixingRatios, phases, pCorr1)
% add two complex voigt lines
line = complex(zeros(size(specAxis)));
for ii = 1:2
    line = line + areas(ii)*exp(-1i*phases(ii)*pi/180)*...
                    complexVoigt(specAxis, centers(ii), fwhms(ii), mixingRatios(ii));
end

% 1st order phase correction
line = exp(-1i*specAxis*pCorr1).*line;


        