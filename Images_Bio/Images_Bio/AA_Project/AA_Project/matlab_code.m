% Capacitor charging simulation
clc;
clear all;

% Wanted bit Number
% N = 8;
% cycle = 5*N;

% Capacitor C1 parameters
C1 = 1e-6;     % capacitance in farads
% V1 = 10;       % voltage in volts
Tclk = 1;
%Iin = 28;     % charging current in 30 or 25, 46, 47 microamperes
n_bits = 10;

% Capacitor C2 parameters
C2 = 1e-6;     % capacitance in farads (same as C1)
Iref = 10;   % charging current in 9.3-9.5 or 7.1, 16, 15.7 microamperes

nb_points = 1000;

for k = 1:nb_points
    
Iin = k*40/nb_points;    
%Iin = 2.8;
fprintf('Iin : %d\n', Iin);
% Check if I1 is less than 4 times I2
if Iin >= 4*Iref
    warning('Iin should be less than 4 times Iref');
end

% Calculate the charge required for capacitor C1
Q1 = Tclk *  Iin;

% Calculate the time required to charge capacitor C2
Tref = Q1 / Iref;

% Print the results
% fprintf('Capacitor C1 is charged for %.3f seconds with %.2e A of current\n', Tclk, Iin);
% fprintf('Capacitor C2 is charged for %.3f seconds with %.2e A of current\n', Tref, Iref);

Tref_int = fix(Tref);
% Total number of cycles for MSB
% fprintf('Total number of cycle for MSB %d \n', Tref_int);
Code = Tref_int * 2^(n_bits-2);

% k = 12;
Tres = zeros(1,n_bits-1); % set the value of Tres
TresB = zeros(1,n_bits-1);
% Calacultate the residual time
Tres(1) = Tref - Tref_int;
TresB(1) = Tclk - Tres(1);

for n = 1:n_bits-2
    m = n+2; % This variable for ADC output after 2 MSB. 

    if 2*TresB(n) > Tclk
        ADC(m) = 1;
        TresB(n+1)=2*Tclk-2*TresB(n);
    else 
        
        ADC(m) = 0;
        TresB(n+1)=Tclk-2*TresB(n);  
    end
%    fprintf('New ADC bit: %d \n', ADC(m)); % Adding 0 bit to the corresponding ADC index.
    Code = Code + (ADC(m)+1)*(-2)^(n_bits-2-n);

end
Code_fin(k)=Code;
fprintf('Code = %d \n', Code);

end

figure();
x = linspace(0.04, 40, 1000);
plot(x, Code_fin);