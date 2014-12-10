function [] = showCumulativeDistributions(items, theXLabel, theColors, ...
    theTitle, theLegends, xRange)
% Plots the cummulative distributions
figure('Name', theTitle)
hold on
for k = 1:length(items)
    [f, x] = ecdf(items{k}(:));
    plot(x, f, 'Color', theColors(k, :))
end
xlabel(theXLabel);
ylabel('Cumulative probability')
title(theTitle)
legend(theLegends(1:length(items)), 'Location', 'NorthWest')
set(gca, 'XLim', xRange, 'XLimMode', 'manual')
hold off


