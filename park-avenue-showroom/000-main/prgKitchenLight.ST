PROGRAM prgKitchenLight
   VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      out_Lamp1 : ptr_to bool;
      Lamp1     : fbManualRelay;
      
      out_Lamp2 : ptr_to bool;
      Lamp2     : fbManualRelay;
      
      Auto            : fbAutoRelay;
      in_MotionSensor : ptr_to bool;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     out_Lamp1                  := adr(PLC_OUT.DO1);
     out_Lamp2                  := adr(MODULE1_OUT.DOs.DO1);
     r2_2KitchenLight04_24_auto := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode    := NC;
     Auto.nightMode             := true;
     in_MotionSensor            := adr(PLC_IN.DI1);
     init := true;
  end_if;

  lamp1( trigButton := r2_2KitchenLight03,
         state      => out_Lamp1^);
         
  lamp2( trigButton := r2_2KitchenLight04_24,
         state      => out_Lamp2^);

  Auto( Sensor_Motion.state   := in_MotionSensor^,
        autoMode              := r2_2KitchenLight04_24_auto);

  if Auto.stateChanged then
     Lamp2.setState := Auto.state;
  end_if;

END_PROGRAM

