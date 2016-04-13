PROGRAM prgLivingroomLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      Auto      : fbAutoRelay;

      button    : fbButtonProcessor;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR


  if not init then

     r2_3LivingroomLight02_07_08_auto  := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect        := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode           := NC;
     Auto.nightMode                    := true;

     init := true;
 end_if;

  if button.shortPress then
     lamp1.setState := not lamp1.state;
  end_if;
  
  if panel.button[1].shortPress then
     Lamp1.setState := not Lamp1.state;
  end_if;
  
  Lamp1(trigButton :=r2_3LivingroomLight02_07_08,
                   state => MODULE4_OUT.DO1);

  panel.led[1]:= Lamp1.state;

  Auto( Sensor_Motion.state   := MODULE2_IN.DI.DI1,
        autoMode              := r2_3LivingroomLight02_07_08_auto);

  if Auto.stateChanged then
     lamp1.setState := Auto.state;
  end_if;


END_PROGRAM

