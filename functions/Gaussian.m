% part of https://github.com/LudgerS/MRSartifactRemoval  
%
% Normalized Gaussian curve
% follows Bruce et al., "An Analytical Derivation of a Popular Approximation 
% of the Voigt Function for Quantification of NMR Spectra", Journal of
% Magnetic Resonance (1999)
%
% lineshape according to Bruce et al.
% lineShape = 2/fwhm*sqrt(log(2)/pi)*...
%                 exp(-((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))).^2); 
%            
% corrected formula to achieve intended normalization
% lineShape = 2/fwhm*1/sqrt(log(2)*pi)*...
%                 exp(-((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))).^2); 

function lineShape = Gaussian(frequencyAxis, f0, fwhm)
            
% corrected formula to achieve intended normalization
lineShape = 2/fwhm*1/sqrt(log(2)*pi)*...
                exp(-((frequencyAxis - f0)/(fwhm/2*sqrt(log(2)))).^2); 