PROGRAM prgBathroom2Light
 VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1,
      Lamp2     : fbManualRelay;

      Auto9     : fbAutoRelay;
      
      button1,
      button2   : fbButtonProcessor;

      init      : bool;
      
      //kostyl    :R_TRIG;
      
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     supervisorAuto09                  := AUTO_MODE_DEFAULT_STATE;
     Auto9.timeAfterMotionDetect       := AUTO_MODE_DEFAULT_TIME;
     Auto9.Sensor_Motion.mode          := NC;
     Auto9.nightMode                   := true;

     init := true;
 end_if;

 (*Lamp1*)
  button1(btn := button_20_1_21_1);

  if button1.shortPress then
     Lamp1.setState := not Lamp1.state;
  end_if;

  //эта штука появилась тут из-за того, что нужно было
  //добавить в сценарий "пришел домой" включение света в СУ2
  //а Юрко не нашел кода, который этот сценарий реализует
  //kostyl(CLK := generalPower);
  if generalPowerObserver.rising Then
     supervisorLight_14_16 := true;
  End_if;

  Lamp1(trigButton := supervisorLight_14_16);

  light_14_16 := Lamp1.state;

  Auto9(Sensor_Motion.state   := msensor09,
        autoMode              := supervisorAuto09);

  if Auto9.stateChanged then
     Lamp1.setState := Auto9.state;
  end_if;

  (*Lamp2*)
  button2(btn := button_20_2_22_1);

  if button2.shortPress then
     Lamp2.setState := not Lamp2.state;
  end_if;

  Lamp2(trigButton := supervisorLight_15);

  light_15 := Lamp2.state;
  
  
  if generalPowerObserver.falling then
     Lamp1.setState := false;
     Lamp2.setState := false;
  end_if;

END_PROGRAM

