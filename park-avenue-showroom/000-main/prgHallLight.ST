PROGRAM prgHallLight
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

     r1_1HallLight01_auto       := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode    := NC;
     Auto.nightMode             := true;

     init := true;
  end_if;
  
  button(btn:= adr(MODULE4_IN.DI0));
  if button.shortPress then
     lamp1.setState := not lamp1.state;
  end_if;

  lamp1( trigButton := r1_1HallLight01,
         state      => MODULE1_OUT.DO0
         );

  Auto( Sensor_Motion.state   := MODULE1_IN.DI0,
        autoMode              := r1_1HallLight01_auto
        );

  if Auto.stateChanged then
     Lamp1.setState := Auto.state;
  end_if;
  
END_PROGRAM

