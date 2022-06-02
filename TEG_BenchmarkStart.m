%% Thermoelectric Generator Model and Study
%Author: Charles Kennedy
%Date: 11/7/2019
%
%Not all the equations are used in the symulink model some are just for
%reference

%% From HZ-20HV datasheet
%Estimated Th   ermal and Electrical Characteristics
%-----------------------%Parameter Conditions:      min     typ     max
% Power Th=250°C, Tc=50°C @matched load       |     23.1    24.3    25.5 W
% Open Circuit Voltage Th=250°C, Tc=50°C      |     10.3    10.8    11.3 V
% Matched load Voltage Th=250°C, Tc=50°C      |     5.2     5.4     5.6 V
% Internal Resistance Th=250°C, Tc=50°C       |     1.14    1.2     1.26 
% Th = Tc = 25°C                              |     0.73    0.77    0.81
% Current Th=250°C, Tc=50°C @matched load     |     4.3     4.5     4.7 A
% Th=250°C, Tc=50°C @short circuit            |     8.5     9.0     9.5 A
% Heat Flow Th=250°C, Tc=50°C @matched load   |     703     740     777 W
% Th=250°C, Tc=50°C @open circuit             |     570     600     630 W
% Heat Flux Th=250°C, Tc=50°C @matched load   |     15      16      17 W/cm^2
% Mass                                        |     69      70      71 g
% Max_eff = (25.5/777)*100 = 3.2819

%% Temperature Conversions
%
%Kelvin (K) = Celsius (C) + 273.15
%
%Fahrenheit (F) = Celsius (C)*(1.8) + 32
%F = C*1.8 + 32

%% SIMULINK MODEL
%Th %Hot side temperature (Celsius)
Th = 400;
% Hot Side temperature (Kelvin)
Th = Th + 273.15;

%Tc %Cold Side Temperature (Celsius)
Tc = 20;
%Cold Side Temperature (Kelvin)
Tc = Tc + 273.15;

%delta_T %Temperature difference between the hot side and cold side
delta_T = Th - Tc;

%Vm %matched voltage
Vm = 1.2;

%Wm %Matched Power
Wm = 0.2;

%R %internal Resistance
%RL %Load Resistance (matched to internal resistance where R=RL)
RL = (Vm^2)/Wm; 
R = RL;

%Seebeck Coefficient
alpha = 2*Vm/delta_T;

%if RL = mR where m is the ratio between the internal and load
m = 1;

%I %Electric current
Ie = (alpha*delta_T)/((1+m)*R); 
%  = (u(1)*u(3))/((1+m)*R)

%Im %Matched Load Current
Im = (alpha*delta_T)/(2*R);
%  = (u(1)*u(3))/(2*R)

%Isc %Short Circuit Current @Vl = 0     %Isc = 2*Im=(2*Wm)/Vm;
Isc = (2*Wm)/Vm;
Isc_1 = 2*Im;

%V %Output Voltage
V = -R*(Ie-Isc);
% = -u(2)*(u(1)-(2*Wm)/Vm)

%% Physical test model study

%Vo %Open Circuit Voltage
%Vl %Load Voltage
%Rl %load resistor %look at datasheet for appropriate size in Ohms
%Vr %Voltage drop across resistor 

%I_load %current from module
%I_load = Vr/Rl

%Ri %Internal Resistance
%Ri = (Vo * Vl)/I_load

%Pmax %Maximum Power Output
%Pmax = (Vo^2)/(4*Ri)

%%
% Run the Benchmark file
sim("TEG_MPPT_PO_Benchmark_noise.slx")

% Print figures
TEG_Benchmark_Performance_Indices
