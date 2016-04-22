PROGRAM prgHallLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;

      Auto1     : fbAutoRelay;

      button    : fbButtonProcessor;
      
      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then

     supervisorAuto01               := AUTO_MODE_DEFAULT_STATE;
     Auto1.timeAfterMotionDetect    := AUTO_MODE_DEFAULT_TIME;
     Auto1.Sensor_Motion.mode       := NC;
     Auto1.nightMode                := true;

     init := true;
  end_if;
  
  if panel.button[1].shortPress then
     Lamp1.setState := not Lamp1.state;
  end_if;
  


  lamp1( trigButton := supervisorLight_01_08_23_24,
         state      => light_01_08_23_24
         );

  panel.led[1]:= Lamp1.state;

  Auto1( Sensor_Motion.state   := msensor01,
        autoMode              := supervisorAuto01
        );

  if Auto1.stateChanged then
     Lamp1.setState := Auto1.state;
  end_if;
  
END_PROGRAM

