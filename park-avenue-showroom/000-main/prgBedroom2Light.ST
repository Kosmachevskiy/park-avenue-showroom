PROGRAM prgBedroom2Light
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      out_Lamp1 : ptr_to bool;
      Lamp1     : fbManualRelay;

      out_Lamp2 : ptr_to bool;
      Lamp2     : fbManualRelay;
      
      out_Lamp3 : ptr_to bool;
      Lamp3     : fbManualRelay;

      Auto            : fbAutoRelay;
      in_MotionSensor : ptr_to bool;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     out_Lamp1                  := adr(MODULE1_OUT.DOs.DO7);
     out_Lamp2                  := adr(MODULE1_OUT.DOs.DO8);
     out_Lamp3                  := adr(IR_15_01_OUT.DO6);
     r2_2KitchenLight04_24_auto := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode    := NC;
     Auto.nightMode             := true;
     in_MotionSensor            := adr(MODULE1_IN.DI.DI2);
     init := true;
  end_if;

  lamp1( trigButton := r5_1Bedroom2Light11,
         state      => out_Lamp1^);
  lamp2( trigButton := r5_1Bedroom2Light12,
         state      => out_Lamp2^);
  lamp3( trigButton := r5_1Bedroom2Light10,
         state      => out_Lamp3^);


  Auto( Sensor_Motion.state   := in_MotionSensor^,
        autoMode              := r5_1Bedroom2Light10_auto);

  if Auto.stateChanged then
     Lamp3.setState := Auto.state;
  end_if;


END_PROGRAM

