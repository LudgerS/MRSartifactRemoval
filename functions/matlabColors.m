% part of https://github.com/LudgerS/MRSartifactRemoval  
%
% allows addressing the build-in standard Matlab colors

function color = matlabColors(number)

switch number
    case 1
        color = [0,0.447000000000000,0.741000000000000];
    case 2
        color = [0.850000000000000,0.325000000000000,0.0980000000000000];        
    case 3
        color = [0.929000000000000,0.694000000000000,0.125000000000000];        
    case 4
        color = [0.494000000000000,0.184000000000000,0.556000000000000];        
    case 5
        color = [0.466000000000000,0.674000000000000,0.188000000000000];        
    case 6
        color = [0.301000000000000,0.745000000000000,0.933000000000000];        
    case 7
        color = [0.635000000000000,0.0780000000000000,0.184000000000000];        
    otherwise
        error('there are only 7 colors available')
end
        
        
        
        
        
        
        