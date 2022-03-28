function plotSignalPeakEstimate(specAxisPpm, spectrum, centerEstimate, fwhmEstimate, artifactCenters)
close all

% display x-ranges
fullRange = specAxisPpm([1, end]);

zoomBorder = 15;
smallRange = [centerEstimate - zoomBorder, centerEstimate + zoomBorder];

% display y-range
figScale = max(abs(spectrum));
yLim = [-1.05, 1.05];

% color and linewidth specifications
dashlineColor = 0.3*[1,1,1];
dashlineWidth = 1.5;

rectangleColor = 0.85*[1,1,1];

%
Fig = figure;
set(Fig, 'position', [50, 50, 1100, 500]) 
set(Fig, 'PaperPositionMode', 'Auto') 


% full view -----------------------------------------------------
subplot(1,2,1)

hMagn = plot(specAxisPpm, abs(spectrum)/figScale);
hold on
hReal = plot(specAxisPpm, real(spectrum)/figScale);
hCenter = plot(centerEstimate, yLim(1), '^');
hPrior = plot(artifactCenters, yLim(1)*[1,1], 'o');
plot(centerEstimate*[1, 1], yLim, '--', 'Color', dashlineColor, 'LineWidth', dashlineWidth)
% plot(artifactCenters(1)*[1, 1], yLim, '--', 'Color', dashlineColor, 'LineWidth', dashlineWidth)
% plot(artifactCenters(2)*[1, 1], yLim, '--', 'Color', dashlineColor, 'LineWidth', dashlineWidth)

xlim(fullRange)
ylim(yLim)

title('input spectrum, full')
xlabel('frequency (ppm)')
ylabel('SI (arb. units)')
set(gca, 'xdir','reverse')

lHdl = legend('magnitude', 'real', 'estimate', 'prior means', 'location', 'northWest');
lHdl.FontSize = round(lHdl.FontSize*0.7);


% restricted view ------------------------------------------------
subplot(1,2,2)

hMagn = plot(specAxisPpm, abs(spectrum)/figScale);
hold on
hReal = plot(specAxisPpm, real(spectrum)/figScale);
hCenter = plot(centerEstimate*[1, 1], yLim, '--', 'Color', dashlineColor, 'LineWidth', dashlineWidth);
hFwhm = rectangle('Position', [centerEstimate - fwhmEstimate/2, yLim(1), fwhmEstimate, yLim(2) - yLim(1)],...
                  'EdgeColor', rectangleColor, 'FaceColor', rectangleColor);

set(gca, 'Children', flipud(get(gca, 'Children')))


xlim(smallRange)
ylim(yLim)
title('input spectrum, zoom')
xlabel('frequency (ppm)')
ylabel('SI (arb. units)')
set(gca, 'xdir','reverse')

