PROGRAM prgBathroom1Light
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR

      Lamp1,
      Lamp2     : fbManualRelay;
      
      Auto8      : fbAutoRelay;

      button1,
      button2   : fbButtonProcessor;
      
      init      : bool;
      
  END_VAR
  VAR_TEMP
  END_VAR
  
  
  if not init then
     supervisorAuto08                 := AUTO_MODE_DEFAULT_STATE;
     Auto8.timeAfterMotionDetect       := AUTO_MODE_DEFAULT_TIME;
     Auto8.Sensor_Motion.mode          := NC;
     Auto8.nightMode                   := true;

     init := true;
 end_if;

 (*Lamp1*)
  button1(btn := button_15_1_16_1);
  
  if button1.shortPress then
     Lamp1.setState := not Lamp1.state;
  end_if;
  
  Lamp1(trigButton := supervisorLight_17_19);

  light_17_19_level := BOOL_TO_REAL(Lamp1.state) * 100.;

  Auto8(Sensor_Motion.state   := msensor08,
        autoMode              := supervisorAuto08);

  if Auto8.stateChanged then
     Lamp1.setState := Auto8.state;
  end_if;

  (*Lamp2*)
  button2(btn := button_15_2_16_2);

  if button2.shortPress then
     Lamp2.setState := not Lamp2.state;
  end_if;

  Lamp2(trigButton := supervisorLight_18);

  light_18_mirror := Lamp2.state;

END_PROGRAM

