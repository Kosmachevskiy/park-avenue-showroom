PROGRAM prgLivingroomLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualDimm;
      Auto      : fbAutoRelay;

      button    : fbButtonProcessor;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR


  if not init then

     r8_1Bathroom2Light14_15_16_auto  := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect       := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode          := NC;
     Auto.nightMode                   := true;


     init := true;
 end_if;


  Lamp1( btn        := MODULE6_IN.DI.DI1,
         slider     := r2_3LivingroomLight02_07_08_level,
         trigButton := r2_3LivingroomLight02_07_08,
         value      => MODULE3_OUT.OUT2.LEVEL
         );

  Auto( Sensor_Motion.state   := MODULE2_IN.DI.DI1,
        autoMode              := r2_3LivingroomLight02_07_08_auto);


  if Auto.stateChanged then
     Lamp1.setValue := 100.;
  end_if;



END_PROGRAM

