% part of https://github.com/LudgerS/MRSartifactRemoval  
%
% Normalized Absorption and Dispersion mode Gaussian curve
% See subfunctions for documentation

function lineShape = complexGaussian(frequencyAxis, f0, fwhm)

lineShape = Gaussian(frequencyAxis, f0, fwhm) -...
                1i*dispersiveGaussian(frequencyAxis, f0, fwhm);




