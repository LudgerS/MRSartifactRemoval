% part of https://github.com/LudgerS/MRSartifactRemoval  
%
% assumes you enter the absolute frequency!

function ppm = freq2ppm(freq, freqRef)

ppm = (freq - freqRef)/freqRef*10^6;
