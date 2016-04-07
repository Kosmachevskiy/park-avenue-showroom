PROGRAM prgBedroom2Light
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      Lamp2     : fbManualRelay;
      Lamp3     : fbManualRelay;

      button1,
      button2,
      button3   :fbButtonProcessor;

      Auto      : fbAutoRelay;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     r2_2KitchenLight04_24_auto := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode    := NC;
     Auto.nightMode             := true;
     init := true;
  end_if;
  
  button1(btn:= adr(MODULE5_AI1.STAT.OVR));
  button2(btn:= adr(MODULE5_AI2.STAT.OVR));
  button3(btn:= adr(MODULE5_AI0.STAT.OVR));
  
  if button1.shortPress then
     Lamp1.setState:= not Lamp1.state;
  end_if;

  if button2.shortPress then
     Lamp2.setState:= not Lamp2.state;
  end_if;
  
    if button3.shortPress then
     Lamp3.setState:= not Lamp3.state;
  end_if;
  
  lamp1( trigButton := r5_1Bedroom2Light11,
         state      => MODULE2_OUT.DOs.DO7
         );
  lamp2( trigButton := r5_1Bedroom2Light12,
         state      => MODULE2_OUT.DOs.DO8
         );
  lamp3( trigButton := r5_1Bedroom2Light10,
         state      => MODULE4_OUT.DO6
         );


  Auto( Sensor_Motion.state   := MODULE2_IN.DI.DI2,
        autoMode              := r5_1Bedroom2Light10_auto);

  if Auto.stateChanged then
     Lamp3.setState := Auto.state;
  end_if;


END_PROGRAM

