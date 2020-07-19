%% Pontraygin's Minimum Principle

%% Initialization
load('UDDS_drive_cycle.mat');
Cycle.ts =1;
Cycle.N=length(t);
Cycle.P_dem = P_dem';

%% Battery Inputs
Bat.P_max = 15; % in kW
Bat.lb_SOC = 0.3;       Bat.ub_SOC = 0.8;       % Upper and Lower Limits of SOC
Bat.lb_P   = 0.1*Bat.P_max;   Bat.ub_P   = 0.9*Bat.P_max; % Upper and Lower Limits of Power Deliverable
Bat.U_oc = 320; %in V
Bat.Q_bat = 18000; %Battery Capacity
Bat.R0_B = 0.001; % in Ohm
Bat.P_bat     = zeros(Cycle.N,1);
Bat.SOC = zeros(1,Cycle.N);
Bat.SOC(1,1) = Bat.ub_SOC;

%% Engine Modellling
Engine.P_engine  = linspace(1,20,1000)';
Engine.P_opt_eng = zeros(Cycle.N,1);
Engine.fl_wy_en = 0.001;
Engine.P = Engine.P_engine(1,1);
Engine.eff = 0.45;

%% PMP Implementation
costate_p = zeros(Cycle.N,1);
w_factor =  zeros(Cycle.N,1);

SOC_1 = pontryagin(-5.33,Bat,Cycle,Engine);
SOC_2 = pontryagin(20000,Bat,Cycle,Engine);

%% Plotting
figure
plot(SOC_1)
hold on
plot(SOC_2)
hold off
ylim([0 1]);