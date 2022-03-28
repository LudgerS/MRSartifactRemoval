function areas0 = getAreaStartingValues(spectrum, frequencyAxis, centers0, FWHMs0)

freqResolution = frequencyAxis(2) - frequencyAxis(1);
areas0 = zeros(1, numel(centers0));

for ii = 1:numel(centers0)
    
    cutPeak = spectrum((frequencyAxis > (centers0(ii) - FWHMs0(ii))) &...
                       (frequencyAxis < (centers0(ii) + FWHMs0(ii))));

    areas0(ii) = sum(cutPeak)*freqResolution;

end

% % lorentz area inside -FWHM to FWHM is 
% % (atan(2) - atan(-2))/pi * the full area
% areas0 = areas0/(atan(2) - atan(-2))*pi;


