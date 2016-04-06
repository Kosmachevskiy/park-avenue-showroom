PROGRAM prgLivingroomLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualDimm;
      Auto            : fbAutoRelay;

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


  Lamp1( (*btn        := in_button^,*)
         slider     := r2_3LivingroomLight02_07_08_level,
         trigButton := r2_3LivingroomLight02_07_08,
         //value      => out_Lamp1^
         );

  Auto( //Sensor_Motion.state   := in_MotionSensor^,
        autoMode              := r2_3LivingroomLight02_07_08_auto);


  if Auto.stateChanged then
     Lamp1.setValue := 50.;
  end_if;



END_PROGRAM

