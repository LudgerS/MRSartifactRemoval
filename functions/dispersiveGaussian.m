function lineShape = dispersiveGaussian(frequencyAxis, f0, fwhm)
% Normalized Gaussian curve
% follows Bruce et al., "An Analytical Derivation of a Popular Approximation 
% of the Voigt Function for Quantification of NMR Spectra", Journal of
% Magnetic Resonance (1999)
% and 
% "Dispersion corrections to the Gaussian profile describing the Doppler
% broadening of spectral lines"
% S. Wojtewicz, P. Wcis?o, D. Lisak, and R. Ciury?o
%
% lineShape = 2/fwhm*sqrt(log(2)/pi)*...
%                 exp(-((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))).^2); 
%            
% corrected formula to achieve intended normalization
% lineShape = 2/fwhm*1/sqrt(log(2)*pi)*...
%                 exp(-((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))).^2); 
%            
% dispersive
%
% lineShape = 2/fwhm*1/sqrt(log(2)*pi)*...
%                 exp(-((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))).^2).*...
%                 erfi(((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))));
%

lineShape = 2/fwhm*1/sqrt(log(2)*pi)*...
                2/sqrt(pi)*dawson_weideman(((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))), 36);


            