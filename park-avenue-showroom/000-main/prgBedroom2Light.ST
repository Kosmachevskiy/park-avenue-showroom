PROGRAM prgBedroom2Light
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      Lamp2     : fbManualRelay;
      Lamp3     : fbManualRelay;

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

  lamp1( trigButton := r5_1Bedroom2Light11,
         //state      => out_Lamp1^
         );
  lamp2( trigButton := r5_1Bedroom2Light12,
         //state      => out_Lamp2^
         );
  lamp3( trigButton := r5_1Bedroom2Light10,
         //state      => out_Lamp3^
         );


  Auto( //Sensor_Motion.state   := in_MotionSensor^,
        autoMode              := r5_1Bedroom2Light10_auto);

  if Auto.stateChanged then
     Lamp3.setState := Auto.state;
  end_if;


END_PROGRAM

