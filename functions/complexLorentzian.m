function lineShape = complexLorentzian(frequencyAxis, f0, fwhm)
% Normalized Absorption and Dispersion mode Lorentzian curve
% From Keeler "Understanding NMR Spectroscopy", 9.1.4

T2 = 2/fwhm;
absorption = T2./(1 + (frequencyAxis - f0).^2*T2^2);
dispersion = (frequencyAxis - f0)*T2.^2./(1 + (frequencyAxis - f0).^2*T2.^2); 

lineShape = (absorption - 1i*dispersion)/pi;



