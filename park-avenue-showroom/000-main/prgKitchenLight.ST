PROGRAM prgKitchenLight
   VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      
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

  lamp1( trigButton := r2_2KitchenLight03,
         //state      =>
         );
         
  lamp2( trigButton := r2_2KitchenLight04_24,
         //state      =>
         );

  Auto( //Sensor_Motion.state   := ,
        autoMode              := r2_2KitchenLight04_24_auto);

  if Auto.stateChanged then
     Lamp2.setState := Auto.state;
  end_if;

END_PROGRAM

