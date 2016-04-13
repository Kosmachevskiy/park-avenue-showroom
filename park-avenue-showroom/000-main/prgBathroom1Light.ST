PROGRAM prgBathroom1Light
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
     r7_1Bathroom1Light17_18_19_auto  := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect       := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode          := NC;
     Auto.nightMode                   := true;

     init := true;
 end_if;


  button(btn := MODULE2_IN.DI.DI7);
  
  if button.shortPress then
     Lamp1.setState := not Lamp1.state;
  end_if;
  
  Lamp1(trigButton := r7_1Bathroom1Light17_18_19);
  MODULE3_OUT.OUT1.LEVEL := BOOL_TO_REAL(Lamp1.state) * 100.;
  
  Auto( Sensor_Motion.state   := MODULE2_IN.DI.DI4,
        autoMode              := r7_1Bathroom1Light17_18_19_auto);

  if Auto.stateChanged then
     Lamp1.setState := Auto.state;
  end_if;


END_PROGRAM

