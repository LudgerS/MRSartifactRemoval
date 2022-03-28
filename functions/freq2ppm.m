function ppm = freq2ppm(freq, freqRef)
% assumes you enter the absolute frequency!

ppm = (freq - freqRef)/freqRef*10^6;
