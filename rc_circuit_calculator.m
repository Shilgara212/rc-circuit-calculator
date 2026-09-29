function rc_circuit_calculator
% RC_CIRCUIT_CALCULATOR Plots capacitor charging or discharging voltage.
% Enter resistance in ohms, capacitance in farads, and voltage in volts.

clc;
close all;

fprintf('RC Circuit Calculator\n');
fprintf('---------------------\n');

mode = lower(strtrim(input('Choose charge or discharge: ', 's')));
R = input('Resistance R (ohms): ');
C = input('Capacitance C (farads): ');
V0 = input('Initial or supply voltage V0 (volts): ');

if ~(isscalar(R) && isfinite(R) && R > 0)
    error('R must be one positive number in ohms.');
end

if ~(isscalar(C) && isfinite(C) && C > 0)
    error('C must be one positive number in farads.');
end

if ~(isscalar(V0) && isfinite(V0))
    error('V0 must be one finite number in volts.');
end

tau = R * C;
t = linspace(0, 5 * tau, 500);

switch mode
    case 'charge'
        Vc = V0 * (1 - exp(-t / tau));
        plotTitle = 'Capacitor Charging';
        equationText = 'V_C(t) = V_0(1 - e^{-t/RC})';
    case 'discharge'
        Vc = V0 * exp(-t / tau);
        plotTitle = 'Capacitor Discharging';
        equationText = 'V_C(t) = V_0e^{-t/RC}';
    otherwise
        error("Choose either 'charge' or 'discharge'.");
end

fprintf('\nTime constant tau = %.4g s\n', tau);
fprintf('At t = tau, Vc = %.4g V\n', Vc(find(t >= tau, 1)));

figure('Color', 'w');
plot(t, Vc, 'b-', 'LineWidth', 2);
grid on;
xlabel('Time, t (s)');
ylabel('Capacitor voltage, V_C (V)');
title(plotTitle);
subtitle(sprintf('%s,   R = %.4g Ohm,   C = %.4g F,   tau = %.4g s', ...
    equationText, R, C, tau));
xlim([0, 5 * tau]);

hold on;
xline(tau, '--r', '\tau = RC', 'LabelVerticalAlignment', 'bottom');
yline(Vc(find(t >= tau, 1)), '--k', 'V_C(\tau)', ...
    'LabelHorizontalAlignment', 'left');
hold off;

end
