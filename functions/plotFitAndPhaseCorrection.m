% part of https://github.com/LudgerS/MRSartifactRemoval  
%
% Generates the figure shown in MRSartifactRemoval.pdf

function plotFitAndPhaseCorrection(specAxis, spectrumOrignal, spectrumFinal, startingLine, fittedLine, displayRange, fileName)
% default font sizes and line width
displayScaling = 2;
set(0,'DefaultAxesFontSize', 8*displayScaling)
set(0,'defaultLineLineWidth', 1.5*displayScaling)
set(0,'defaultAxesLineWidth', 1.5*displayScaling)
legendFontSize = 7*displayScaling;
titleFontSize = 9*displayScaling;
fitLineWidth = 0.8*displayScaling;

% figure and paper size
Fig = figure;
Fig.Units = 'centimeters';
Fig.Position = [1.5, 3, 14.6*displayScaling, 5*displayScaling];

Fig.PaperUnits = 'centimeters';
Fig.PaperSize = Fig.Position(3:4);
Fig.PaperPosition = [0, 0, Fig.Position(3:4)];

% affects all subplots
% set(Fig, 'DefaultAxesPosition', [0.03, 0.1, 0.95, 0.7]);
% 1rd entry needs to be shifted for subplot 2 and 3
subAxisPosition = [0.07, 0.18, 0.25, 0.73];


% data scaling
figScale = max(abs(spectrumOrignal));
yLim = [-1.05, 1.05];
    
% original data and starting values
subplot(1,3,1)
plot(specAxis, real(spectrumOrignal)/figScale, 'color', matlabColors(2))
hold on
plot(specAxis, imag(spectrumOrignal)/figScale, 'color', matlabColors(3))
plot(specAxis, real(startingLine)/figScale, 'k-', 'lineWidth', fitLineWidth)
plot(specAxis, imag(startingLine)/figScale, 'k--', 'lineWidth', fitLineWidth)
    
xlim(displayRange)
ylim(yLim)
title('starting values', 'FontSize', titleFontSize)
xlabel('frequency (ppm)')
ylabel('SI (arb. units)')
set(gca, 'xdir','reverse')
lHdl = legend('real', 'imaginary', 'start real', 'start imag.', 'location', 'southEast');
lHdl.FontSize = legendFontSize;

set(gca, 'Position', subAxisPosition)
    
% original data with fitted line
subplot(1,3,2)
plot(specAxis, real(spectrumOrignal)/figScale, 'color', matlabColors(2))
hold on
plot(specAxis, imag(spectrumOrignal)/figScale, 'color', matlabColors(3))
plot(specAxis, real(fittedLine)/figScale, 'k-', 'lineWidth', fitLineWidth)
plot(specAxis, imag(fittedLine)/figScale, 'k--', 'lineWidth', fitLineWidth)
    
xlim(displayRange)
ylim(yLim)
title('fit', 'FontSize', titleFontSize)
xlabel('frequency (ppm)')
ylabel('SI (arb. units)')
set(gca, 'xdir','reverse')
lHdl = legend('real', 'imaginary', 'fit real', 'fit imag.', 'location', 'southEast');
lHdl.FontSize = legendFontSize;

set(gca, 'Position', subAxisPosition + [1/3, 0, 0, 0])

% after artifact subtraction and phase correction
subplot(1,3,3)
plot(specAxis, abs(spectrumFinal)/figScale, 'color', matlabColors(1))
hold on
plot(specAxis, real(spectrumFinal)/figScale, 'color', matlabColors(2))
    
xlim(displayRange)
ylim(yLim)
title('cleaned', 'FontSize', titleFontSize)
xlabel('frequency (ppm)')
ylabel('SI (arb. units)')
set(gca, 'xdir','reverse')
lHdl = legend('magnitude', 'real', 'location', 'southEast');
lHdl.FontSize = legendFontSize;

set(gca, 'Position', subAxisPosition + [2/3, 0, 0, 0])

%% print
    
print(fileName, '-dpng', num2str(600/displayScaling, '-r%d'))
print(fileName, '-dpdf')
                        
