%% plot benchmark data
close all
time=benchData.Time;

Vin=benchData.Data(:,1); 
Vout=benchData.Data(:,2);
Iin=benchData.Data(:,3);
Iout=benchData.Data(:,4);
DutyCycle=benchData.Data(:,5);
Voltage_Bat=benchData.Data(:,6);
Current_Bat=benchData.Data(:,7);
SOC_Bat=benchData.Data(:,8);
TEG_Power_MPPT=benchData.Data(:,9);     %response with IC only
     %response with IC only
 
Ts=0.01;
%Voltage
figure(1)
subplot(2,2,1)
plot(time,Vin)
title('Vin');xlabel('Time (s)'); ylabel('Voltage (V)')
set(gca,'FontSize', 12);
ylim([1,2]);

subplot(2,2,2)
plot(time,Vout)
title('Vout');xlabel('Time (s)'); ylabel('Voltage (V)')
set(gca,'FontSize', 12);
ylim([3,4]);
xlim([0,0.00003]);

%Current
subplot(2,2,3)
plot(time,Iin)
title('Iin');xlabel('Time (s)'); ylabel('Current (mA)')
set(gca,'FontSize', 12);
ylim([0,0.01]);


subplot(2,2,4)
plot(time,abs(Iout))
title('Iout');xlabel('Time (s)'); ylabel('Current (mA)')
set(gca,'FontSize', 12);
ylim([0,0.01]);


%PWM, batt
figure(2)
subplot(2,2,1)
plot(time,DutyCycle)
title('PWM Duty Cycle');xlabel('Time (s)'); ylabel('DC %')
set(gca,'FontSize', 12);
ylim([0,0.015]);

subplot(2,2,2)
plot(time,TEG_Power_MPPT)
title('MPPT power generated');xlabel('Time (s)'); ylabel('Power (mW)')
set(gca,'FontSize', 12);


subplot(2,2,3)
plot(time,Voltage_Bat)
title('Battery voltage');xlabel('Time (s)'); ylabel('Voltage (V)')
set(gca,'FontSize', 12);
ylim([1,4]);
xlim([0,0.00003]);

subplot(2,2,4)
plot(time,Current_Bat)
title('Battery current');xlabel('Time (s)'); ylabel('Current (mA)')
set(gca,'FontSize', 12);
ylim([0.03,0.05]);

%% SOC performance indices

Win=Vin.*Iin;
Wout=Vout.*Iout;

fprintf("Input power")
IAFinal=     (1/length(Win))*sum(abs(Win));
RMS=    ((1/length(Win)))*sqrt(sum(Win).^2);
varNames={'IAE','RMS'};
table(IAFinal,RMS,...
    'VariableNames',varNames)

fprintf("output power")
IAFinal=     (1/length(Win))*sum(abs(Wout));
RMS=    ((1/length(Win)))*sqrt(sum(Wout).^2);
varNames={'IAE','RMS'};
table(IAFinal,RMS,...
    'VariableNames',varNames)
%% TEG noise and clean power response
Vnoise = TEG_Noise.Data(:,1);
Vclean = TEG_Noise.Data(:,2);
Currernt_TEG = TEG_Noise.Data(:,3);

Wnoise=Vnoise.*Currernt_TEG;
Wclean=Vclean.*Currernt_TEG;

fprintf("TEG power noise")

IAFinal=     (1/length(Wnoise))*sum(abs(Wnoise));
RMS=    ((1/length(Wnoise)))*sqrt(sum(Wnoise).^2);
varNames={'IAE','RMS'};
table(IAFinal,RMS,...
    'VariableNames',varNames)

fprintf("TEG power clean")
IAFinal=     (1/length(Wclean))*sum(abs(Wclean));
RMS=    ((1/length(Wclean)))*sqrt(sum(Wclean).^2);
varNames={'IAE','RMS'};
table(IAFinal,RMS,...
    'VariableNames',varNames)
