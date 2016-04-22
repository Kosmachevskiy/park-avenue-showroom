PROGRAM prgBedroom1Light
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;

      Auto4      : fbAutoRelay;
      
      button    : fbButtonProcessor;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then

     supervisorAuto04                := AUTO_MODE_DEFAULT_STATE;
     Auto4.timeAfterMotionDetect     := AUTO_MODE_DEFAULT_TIME;
     Auto4.Sensor_Motion.mode        := NC;
     Auto4.nightMode                 := true;

     init                           := true;
  end_if;
  
  button(btn:= button_07_1_08_1);
  
  if button.shortPress then
     lamp1.setState := not lamp1.state;
  end_if;

  lamp1( trigButton := supervisorLight_09,
         state      =>  light_09
         );

  Auto4(Sensor_Motion.state   := msensor04,
        autoMode              := supervisorAuto04);

  if Auto4.stateChanged then
     Lamp1.setState := Auto4.state;
  end_if;

END_PROGRAM

