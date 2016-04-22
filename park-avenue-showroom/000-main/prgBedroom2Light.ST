PROGRAM prgBedroom2Light
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      Lamp2     : fbManualRelay;


      button1   :fbButtonProcessor;
      button2   :fbButtonProcessor;


      Auto6,
      Auto7      : fbAutoRelay;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     supervisorAuto06               := AUTO_MODE_DEFAULT_STATE;
     supervisorAuto07               := AUTO_MODE_DEFAULT_STATE;
     Auto6.timeAfterMotionDetect    := AUTO_MODE_DEFAULT_TIME;
     Auto7.timeAfterMotionDetect    := AUTO_MODE_DEFAULT_TIME;
     Auto6.Sensor_Motion.mode       := NC;
     Auto7.Sensor_Motion.mode       := NC;
     Auto6.nightMode                := true;
     Auto7.nightMode                := true;
     
     init := true;
  end_if;
  
  (*Lamp1*)
  button1(btn := button_09_1_10_2_17_1);

  if button1.shortPress then
     Lamp1.setState := not Lamp1.state;
  end_if;

  Lamp1(trigButton := supervisorLight_10_13_22);

  light_10_13_22 := Lamp1.state;

  Auto6(Sensor_Motion.state   := msensor06,
        autoMode              := supervisorAuto06);

  if Auto6.stateChanged then
     Lamp1.setState := Auto6.state;
  end_if;
  
(*Lamp2*)
  button2(btn := button_09_2_09_3_11_1_12_1_13_1_14_1_17_2);

  if button1.shortPress then
     Lamp2.setState := not Lamp2.state;
  end_if;

  Lamp2(trigButton := supervisorLight_11_12_21);

  light_11_12_21 := Lamp2.state;

  Auto7(Sensor_Motion.state   := msensor07,
        autoMode              := supervisorAuto07);

  if Auto7.stateChanged then
     Lamp2.setState := Auto7.state;
  end_if;

END_PROGRAM

