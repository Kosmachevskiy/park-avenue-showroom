PROGRAM prgEatingroomLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      out_Lamp1 : ptr_to bool;
      Lamp1     : fbManualRelay;

      in_MotionSensor : ptr_to bool;
      Auto            : fbAutoRelay;
      
      blind           : fbBlindController;
      //blindSetPositionObserber: fbRealObserver;
      out_Blind_Open  : ptr_to bool;
      out_Blind_Close : ptr_to bool;
      //blindKeeper     : fbDataKeeper;
      
      initTimer : ton;
      init      : bool;

  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     out_Lamp1                  := adr(MODULE1_OUT.DOs.DO11);

     r2_1EatingroomLight05_06_23_auto       := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect             := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode                := NC;
     Auto.nightMode                         := true;
     in_MotionSensor                        := adr(PLC_IN.DI2);

     blind.timeTo_up_down                   := t#38s;
     out_Blind_Open                         := adr(IR_15_01_OUT.DO3);
     out_Blind_Close                        := adr(IR_15_01_OUT.DO4);
     (*
     in_button                              := adr(PLC_IN.DI2);
     in_upButton                            := adr(PLC_IN.DI0);
     in_downButton                          := adr(PLC_IN.DI1);
     *)
     out_Blind_Open^                        := true;
     initTimer( IN := true,
                PT := blind.timeTo_up_down);
     if initTimer.Q then
        init := true;
     end_if;
  else
      blind( up            => out_Blind_Open^,
           down            => out_Blind_Close^,
           currentPosition => r2_1EatingroomBlindsPosition,

           open            := r2_1EatingroomBlindsUp,
           close           := r2_1EatingroomBlindsDown,
           stop            := r2_1EatingroomBlindsStop);

      r2_1EatingroomBlindsUp    := false;
      r2_1EatingroomBlindsDown  := false;
      r2_1EatingroomBlindsStop  := false;

(*
      blindSetPositionObserber(in := adr(r2_1EatingroomBlindsPosition));

      if blindSetPositionObserber.valueChanged then
         blind.setPosition := blindSetPositionObserber.value;
      end_if;
*)
  end_if;

  lamp1( trigButton := r2_1EatingroomLight05_06_23,
         state      => out_Lamp1^);

  Auto( Sensor_Motion.state   := in_MotionSensor^,
        autoMode              := r2_1EatingroomLight05_06_23_auto);

  if Auto.stateChanged then
     Lamp1.setState := Auto.state;
  end_if;
  
  
  
  
  
END_PROGRAM

