PROGRAM prgKitchenLight
   VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      Lamp2     : fbManualRelay;
      
      Auto      : fbAutoRelay;
      
      button1,
      button2   : fbButtonProcessor;
      
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
  
  button1(btn :=MODULE6_IN.DI.DI3 );
  button2(btn := MODULE6_IN.DI.DI2 OR MODULE6_IN.DI.DI8 );
  



  lamp1( trigButton := r2_2KitchenLight03,
         state      => MODULE1_OUT.DO1
         );
         
  lamp2( trigButton := r2_2KitchenLight04_24,
         state      =>  MODULE2_OUT.DOs.DO1
         );

  Auto( Sensor_Motion.state   := MODULE1_IN.DI1,
        autoMode              := r2_2KitchenLight04_24_auto
        );

  if Auto.stateChanged then
     Lamp2.setState := Auto.state;
  end_if;

  if button1.shortPress then
     lamp1.setState := not lamp1.state;
  end_if;

  if button2.shortPress then
     Auto.setState := NOT Auto.state;
  end_if;

  MODULE6_OUT.DOs.DO3:= MODULE2_OUT.DOs.DO1;
  MODULE6_OUT.DOs.DO4:= MODULE1_OUT.DO1;
END_PROGRAM

