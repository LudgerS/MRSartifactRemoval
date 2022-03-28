function lineShape = complexGaussian(frequencyAxis, f0, fwhm)
% Normalized Absorption and Dispersion mode Gaussian curve
% See subfunctions for documentation

lineShape = Gaussian(frequencyAxis, f0, fwhm) -...
                1i*dispersiveGaussian(frequencyAxis, f0, fwhm);




