function soc = pontryagin(p0,Bat,Cycle,Engine)

costate_p(1,1) = p0;
for i = 1:Cycle.N-1
    Bat.P_bat = Cycle.P_dem(i) - Engine.P;
    if Bat.SOC(i)<=Bat.lb_SOC
        w_factor(i)=-10^8;    
    elseif Bat.SOC(i)>=Bat.ub_SOC 
        w_factor(i)=+10^8;
    else
        w_factor(i)=0;
    end    
    
    I_bat = (Bat.U_oc-sqrt(Bat.U_oc^2-Bat.R0_B*Bat.P_bat*1000*4))/(Bat.R0_B*2); 
    Del_soc = -(Cycle.ts*I_bat)/(0.9*Bat.Q_bat);
    H = Engine.fl_wy_en*Cycle.ts*Engine.P_engine/Engine.eff + (costate_p(i)+w_factor(i))*Del_soc;
    H_min = H;
    P_eng = Engine.P;
    
    for j =2:length(Engine.P_engine)
        Engine.P = Engine.P_engine(j,1);
        Bat.P_bat = Cycle.P_dem(i)-Engine.P;
        I_bat = (Bat.U_oc-sqrt(Bat.U_oc^2-Bat.R0_B*Bat.P_bat*1000*4))/(Bat.R0_B*2); 
        Del_soc = -(Cycle.ts*I_bat)/(0.9*Bat.Q_bat);
        H = Engine.fl_wy_en*Cycle.ts*Engine.P_engine/Engine.eff + (costate_p(i)+w_factor(i))*Del_soc;
        if H_min > H
            H_min = H;
            P_eng = Engine.P;
        end
    end
    
    Engine.P_opt_eng(i) = P_eng;
    Bat.P_bat(i)     = Cycle.P_dem(i)-Engine.P_opt_eng(i);
    I_bat        = (Bat.U_oc-sqrt(Bat.U_oc^2-Bat.R0_B*Bat.P_bat(i)*1000*4))/(Bat.R0_B*2);
    Bat.SOC(i+1)     = Bat.SOC(i) - (Cycle.ts*I_bat/(0.9*Bat.Q_bat));
    del_p =  costate_p(i)* 1 / Bat.Q_bat * (1/(2*Bat.R0_B) - 1/(4*Bat.R0_B^2) * Bat.U_oc / sqrt(Bat.U_oc^2/(4*Bat.R0_B^2) - Bat.P_bat(i)*1000/Bat.R0_B)) * 1;  
    costate_p(i+1) = del_p*Cycle.ts + costate_p(i);
end
soc = Bat.SOC;
end