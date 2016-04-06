Type
    SecuritySystemState : (init, disarmed, arming, armed, alarming);
    SecurityZoneMode    : (NO,NC);
    SecurityConfig      :
        struct
               exitTime        :time := t#15s;
               enterenceTime   :time := t#15s;
               Z1Mode          :SecurityZoneMode := NC;
               Z2Mode          :SecurityZoneMode := NC;
               Z3Mode          :SecurityZoneMode := NC;
               Z4Mode          :SecurityZoneMode := NC;
               Z5Mode          :SecurityZoneMode := NC;
               KeyBoardEnable  :bool := false;
               KeyBImpulseTime :time := t#1s;
        end_struct;
end_type

FUNCTION_BLOCK fbSecuritySystem
(*
Error codes description:
1 - Can't Armed system because Sabotage alarm is on.
2 - Can't Armed system because one or more zone is broken.
3 - Keypad error.
*)
  VAR_INPUT
    config      :SecurityConfig;
    Z1          :bool; (*Enter/Exit Door.*)
    Z2          :bool; (*Enter/Exit Zone.*)
    Z3          :bool; (*Doors, windows and PIR sensors.*)
    Z4          :bool; (*Other sensors.*)
    Z5          :bool; (*Tamper zone.*)
    keyBoard    :bool; (*relay keypad contact.*)
    arm         :bool r_edge;  (*Security On flag.*)
    disarm      :bool r_edge;  (*Security Off flag.*)
    alarmReset  :bool r_edge;  (*Alarm reset flag.*)
    sabotageReset:bool r_edge; (*Reset sabotege alarm.*)
  END_VAR
  VAR_OUTPUT
    securityState :bool;      (*TRUE when systen armed.*)
    alarm         :bool;      (*Alarm flag.*)
    siren         :bool;      (**)
    ledIndicator  :bool;      (**)
    sabotage      :bool;      (*TRUE when tamper zone was broken until reset by sabotageReset variable.*)
    error         :bool;      (*TRUE when error until next cycle.*)
    errorCode     :usint;     (*Error descrintion code.*)
  END_VAR
  VAR
    state               :SecuritySystemState;
    keyBoardImpulse     :TP;
    keyBoardEvent       :f_trig;
    keyBoardImpulseEnd  :f_trig;
    exitTimer           :ton;
    entranceTimer       :ton;
    ledPulse            :PWM;
    userEnterPassword   :bool;
    armWithoutDelay     :bool;
  END_VAR


//--Zone inverting accordin to their mode (FALSE - normal state)--//
  if config.Z1Mode = NC then
     Z1 := not Z1;
  end_if;
  
  if config.Z2Mode = NC then
     Z2 := not Z2;
  end_if;
  
  if config.z3Mode = NC then
     z3 := not z3;
  end_if;
  
  if config.z4Mode = NC then
     z4 := not z4;
  end_if;
  
  if config.z5Mode = NC then
     z5 := not z5;
  end_if;


//--General process-//
  if state <> init then
      error := false;

      if config.KeyBoardEnable then
          keyBoardImpulse(IN := not keyBoard, PT := config.KeyBImpulseTime + t#1s);
          keyBoardEvent(CLK := not keyBoard);
          keyBoardImpulseEnd(CLK := keyBoardImpulse.Q);

          userEnterPassword := false;
          userEnterPassword := keyBoardEvent.Q and keyBoardImpulse.Q;

          if keyBoardImpulseEnd.Q and (not keyBoard) then
             error     := true;
             errorCode := 3;
          end_if;
      end_if;

      if Z5 then
         sabotage := true;
      else
         if sabotageReset then
            sabotage := false;
         end_if;
      end_if;
  end_if;
  
  case state of
    init:
        state := disarmed;
        
    disarmed:
        if userEnterPassword or arm then
           if (not Z3) and (not Z4) and  (not Z5) and (not sabotage) then
              state := arming;
              if arm then
                 armWithoutDelay := true;
              else
                 armWithoutDelay := false;
              end_if;
           else
              error     := true;
              if sabotage then
                 errorCode := 1;
              else
                 errorCode := 2;
              end_if;
           end_if;
        end_if;
        ledIndicator := false;
        siren        := false;
        
    arming:
        exitTimer(IN := true, PT := config.exitTime);

        if Z3 or Z4 or Z5 then
           exitTimer(IN := false);
           error     := true;
           if sabotage then
              errorCode := 1;
           else
              errorCode := 2;
           end_if;
           state     := disarmed;
        end_if;
        
        if exitTimer.Q or armWithoutDelay then
           exitTimer(IN := false);
           if (not Z1) and (not Z2) then
              state := armed;
           else
              error     := true;
              errorCode := 2;
              state     := disarmed;
           end_if;
        end_if;
        
        ledPulse(Enb := true, Per := t#1s, Pls := 50.0, Out => ledIndicator);

    armed:
        if Z1 then
           entranceTimer.IN := true;
        end_if;

        if (Z2 and not entranceTimer.IN) or Z3 or Z4 or Z5 then
           state := alarming;
        end_if;

        //if (userEnterPassword and entranceTimer.IN) or disarm then
        if userEnterPassword or disarm then
           state := disarmed;
           entranceTimer(IN := false);
        end_if;
        
        entranceTimer(PT := config.enterenceTime);
        if entranceTimer.Q then
           entranceTimer(IN := false);
           state := alarming;
        end_if;
        
        if entranceTimer.IN then
           ledPulse(Enb := true, Per := t#1s, Pls := 50.0, Out => ledIndicator);
        else
           ledIndicator := true;
        end_if;
        siren := false;
        
    alarming:
        siren := true;
        ledPulse(Enb := true, Per := t#2s, Pls := 75.0, Out => ledIndicator);
        if alarmReset then
           state := armed;
        end_if;
        
        if userEnterPassword or disarm then
           state := disarmed;
           entranceTimer(IN := false);
        end_if;
        
  end_case;
  
  if state <> init then
       if state = alarming then
         alarm := true;
      else
         alarm := false;
      end_if;

      if state = armed then
         securityState := true;
      end_if;

      if state = disarmed then
         securityState := false;
      end_if;
  end_if;

END_FUNCTION_BLOCK
