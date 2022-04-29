% part of https://github.com/LudgerS/MRSartifactRemoval  
%
% Voigt curve with variable area.
% Variable mixing of Lorentzian and Gaussian component, matched FWHM.
%
% Follows Bruce et al., "An Analytical Derivation of a Popular Approximation 
% of the Voigt Function for Quantification of NMR Spectra", Journal of
% Magnetic Resonance (1999)

function lineShape = complexVoigt(frequencyAxis, f0, fwhm, mixingRatio)

lineShape = mixingRatio*complexLorentzian(frequencyAxis, f0, fwhm) + ...
                  (1 - mixingRatio)*complexGaussian(frequencyAxis, f0, fwhm);

              
end              
              

