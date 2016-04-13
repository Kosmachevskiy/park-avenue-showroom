PROGRAM prgBedroom2Light
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      Lamp2     : fbManualRelay;
      Lamp3     : fbManualRelay;

      button1   :fbButtonProcessor;
      button2   :fbButtonProcessor;
      button3   :fbButtonProcessor;

      Auto      : fbAutoRelay;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     r5_1Bedroom2Light10_auto   := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode    := NC;
     Auto.nightMode             := true;
     init := true;
  end_if;
  
  button1(btn := MODULE7_IN.DI2);
  button2(btn := MODULE7_IN.DI0);
  button3(btn := MODULE4_IN.DI3);

  if button2.shortPress then
     Lamp2.setState := not Lamp2.state;
  end_if;

  if button3.shortPress or button1.shortPress then
     Lamp3.setState:= not Lamp3.state;
  end_if;
  
  lamp2( trigButton := r5_1Bedroom2Light12,
         state      => MODULE2_OUT.DOs.DO8);
         
  lamp3( trigButton := r5_1Bedroom2Light10_22,
         state      => MODULE2_OUT.DOs.DO7);

  Auto( Sensor_Motion.state   := MODULE2_IN.DI.DI2,
        autoMode              := r5_1Bedroom2Light10_auto);

  if Auto.stateChanged then
     Lamp3.setState := Auto.state;
  end_if;


END_PROGRAM

