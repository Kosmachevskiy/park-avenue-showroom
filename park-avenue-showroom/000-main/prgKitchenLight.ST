PROGRAM prgKitchenLight
   VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      Lamp2     : fbManualRelay;
      
      Auto      : fbAutoRelay;
      
      button    : fbButtonProcessor;
      
      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     r2_2KitchenLight04_24_auto := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode    := NC;
     Auto.nightMode             := true;
     init := true;
  end_if;
  
  if panel.button[2].shortPress then
     Lamp2.setState := not Lamp2.state;
  end_if;
  
  lamp1( trigButton := r2_2KitchenLight03,
         state      => MODULE1_OUT.DO1
         );
         
  lamp2( trigButton := r2_2KitchenLight04_24,
         state      =>  MODULE2_OUT.DOs.DO1
         );

  panel.led[2]:= Lamp2.state;

  Auto( Sensor_Motion.state   := MODULE1_IN.DI1,
        autoMode              := r2_2KitchenLight04_24_auto
        );

  if Auto.stateChanged then
     Lamp2.setState := Auto.state;
  end_if;

END_PROGRAM

