% part of https://github.com/LudgerS/MRSartifactRemoval  
%
% Normalized dispersive Gaussian curve
% follows  
% "Dispersion corrections to the Gaussian profile describing the Doppler
% broadening of spectral lines"
% S. Wojtewicz, P. Wcis?o, D. Lisak, and R. Ciury?o
%
% lineShape = 2/fwhm*1/sqrt(log(2)*pi)*...
%                 exp(-((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))).^2).*...
%                 erfi(((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))));

function lineShape = dispersiveGaussian(frequencyAxis, f0, fwhm)


lineShape = 2/fwhm*1/sqrt(log(2)*pi)*...
                2/sqrt(pi)*dawson_weideman(((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))), 36);


            