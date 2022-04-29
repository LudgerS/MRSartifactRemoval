% part of https://github.com/LudgerS/MRSartifactRemoval  
%
% see https://en.wikipedia.org/wiki/Dawson_function
%
% dawson(z) = sqrt(pi)/2*exp(-z^2)*erfi(z)
%           = -i*sqrt(pi)/2*exp(-z^2)*(1 - exp(z^2)*w(-z))
%           = -i*sqrt(pi)/2*(exp(-z^2) - w(-z))
%
% where w(z) is the Fadeeva function
% implemented only for real input
%
% see Fadeeva_weideman for documentation on the used approximation

function out = dawson_weideman(z, N)

out = real(-1i*sqrt(pi)/2*(exp(-z.^2) - Fadeeva_weideman(-z, N)));    