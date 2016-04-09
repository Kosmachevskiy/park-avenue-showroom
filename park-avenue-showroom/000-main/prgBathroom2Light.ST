PROGRAM prgBathroom2Light
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

     r8_1Bathroom2Light14_15_16_auto       := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect            := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode               := NC;
     Auto.nightMode                        := true;

     init := true;
  end_if;
  
  button(btn:= MODULE5_AI4.STAT.OVR);
  if button.shortPress then
     lamp1.setState := not lamp1.state;
  end_if;

  lamp1( trigButton := r8_1Bathroom2Light14_15_16,
         state      => MODULE4_OUT.DO0
         );

  Auto( Sensor_Motion.state   := MODULE2_IN.DI.DI5,
        autoMode              := r8_1Bathroom2Light14_15_16_auto);

  if Auto.stateChanged then
     Lamp1.setState := Auto.state;
  end_if;

END_PROGRAM

