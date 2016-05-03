function [fitresult, gof] = createFit(sl, nsl)
%CREATEFIT(SL,NSL)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : sl
%      Y Output: nsl
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 02-May-2016 15:10:49


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( sl, nsl );

% Set up fittype and options.
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.282755968001751 -2.63431523870225];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, xData, yData );
% legend( h, 'nsl vs. sl', 'untitled fit 1', 'Location', 'NorthEast' );
% % Label axes
% xlabel sl
% ylabel nsl
% grid on

