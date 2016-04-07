PROGRAM prgWardrobeLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      button    : fbButtonProcessor;
      Auto      : fbAutoRelay;

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
  
  button(btn :=adr(MODULE4_IN.DI2 ));
  
  if button.shortPress then
     Lamp1.setState:= not Lamp1.state;
  end_if;

  lamp1( trigButton := r6_1WardrobeLight13_21,
         state      =>  MODULE2_OUT.DOs.DO3
         );



  Auto( Sensor_Motion.state   := MODULE2_IN.DI.DI3,
        autoMode              := r6_1WardrobeLight13_21_auto);

  button(btn :=adr(MODULE4_IN.DI2) );

  if Auto.stateChanged OR button.shortPress then
     Lamp1.setState := Auto.state;
  end_if;



END_PROGRAM

