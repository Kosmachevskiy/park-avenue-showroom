PROGRAM prgLivingroomLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      out_Lamp1 : ptr_to real;
      Lamp1     : fbManualDimm;

      in_MotionSensor : ptr_to bool;
      Auto            : fbAutoRelay;

      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR


  if not init then
     out_Lamp1                        := adr(DIMMER_OUT.OUT2.LEVEL);

     r8_1Bathroom2Light14_15_16_auto  := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect       := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode          := NC;
     Auto.nightMode                   := true;
     in_MotionSensor                  := adr(MODULE1_IN.DI.DI1);


     init := true;
 end_if;


  Lamp1( (*btn        := in_button^,*)
         slider     := r2_3LivingroomLight02_07_08_level,
         trigButton := r2_3LivingroomLight02_07_08,
         //value      => out_Lamp1^
         );

  out_Lamp1^ := Lamp1.value * BOOL_TO_REAL(generalPower);

  Auto( Sensor_Motion.state   := in_MotionSensor^,
        autoMode              := r2_3LivingroomLight02_07_08_auto);


  if Auto.stateChanged then
     Lamp1.setValue := 50.;
  end_if;



END_PROGRAM

