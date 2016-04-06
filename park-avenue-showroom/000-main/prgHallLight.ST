PROGRAM prgHallLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      out_Lamp1 : ptr_to bool;
      Lamp1     : fbManualRelay;

      in_MotionSensor : ptr_to bool;
      Auto            : fbAutoRelay;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     out_Lamp1                  := adr(PLC_OUT.DO0);

     r1_1HallLight01_auto       := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode    := NC;
     Auto.nightMode             := true;
     in_MotionSensor            := adr(PLC_IN.DI0);

     init := true;
  end_if;

  lamp1( trigButton := r1_1HallLight01,
         state      => out_Lamp1^);

  Auto( Sensor_Motion.state   := in_MotionSensor^,
        autoMode              := r1_1HallLight01_auto);

  if Auto.stateChanged then
     Lamp1.setState := Auto.state;
  end_if;
END_PROGRAM

