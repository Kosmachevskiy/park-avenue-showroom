PROGRAM prgLivingroomLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      Auto5     : fbAutoRelay;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR


  if not init then

     supervisorAuto05                   := AUTO_MODE_DEFAULT_STATE;
     Auto5.timeAfterMotionDetect        := AUTO_MODE_DEFAULT_TIME;
     Auto5.Sensor_Motion.mode           := NC;
     Auto5.nightMode                    := true;

     init := true;
 end_if;

  if panel.button[4].shortPress then
     Lamp1.setState := not Lamp1.state;
  end_if;
  
  Lamp1(trigButton :=supervisorLight_02_06_07,
                   state => light_02_06_07);

  panel.led[4]:= Lamp1.state;

  Auto5(Sensor_Motion.state   := msensor05,
        autoMode              := supervisorAuto05);

  if Auto5.stateChanged then
     lamp1.setState := Auto5.state;
  end_if;


END_PROGRAM

