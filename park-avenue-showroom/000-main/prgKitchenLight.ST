PROGRAM prgKitchenLight
   VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      button1,
      button2   : fbButtonProcessor;
      Lamp2     : fbManualRelay;
      
      Auto            : fbAutoRelay;

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
  
  //button1(btn :=adr() );
  //button2(btn :=adr() );

  lamp1( trigButton := r2_2KitchenLight03,
         state      => MODULE1_OUT.DO1
         );
         
  lamp2( trigButton := r2_2KitchenLight04_24,
         state      =>  MODULE2_OUT.DOs.DO1
         );

  Auto( Sensor_Motion.state   := MODULE1_IN.DI1,
        autoMode              := r2_2KitchenLight04_24_auto);

  if Auto.stateChanged then
     Lamp2.setState := Auto.state;
  end_if;

END_PROGRAM

