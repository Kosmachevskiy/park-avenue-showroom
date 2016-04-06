PROGRAM prgEatingroomLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;

      Auto            : fbAutoRelay;
      
      blind           : fbBlindController;
      blindSetPositionObserber: fbRealObserver;
      
      initTimer : ton;
      init      : bool;

  END_VAR
  VAR_TEMP
  END_VAR

  if not init then

     r2_1EatingroomLight05_06_23_auto       := AUTO_MODE_DEFAULT_STATE;
     Auto.timeAfterMotionDetect             := AUTO_MODE_DEFAULT_TIME;
     Auto.Sensor_Motion.mode                := NC;
     Auto.nightMode                         := true;

     blind.timeTo_up_down                   := t#38s;

     //out_Blind_Open^                        := true; //Типа чтобы штора после старта была открыта
     initTimer( IN := true,
                PT := blind.timeTo_up_down);
     if initTimer.Q then
        init := true;
     end_if;
  else
      blindSetPositionObserber(value := r2_1EatingroomBlindsPosition);

      if blindSetPositionObserber.valueChanged then
         blind.setPosition := blindSetPositionObserber.value;
      end_if;
  
      blind( //up            => out_Blind_Open^,
             //down            => out_Blind_Close^,
           currentPosition => r2_1EatingroomBlindsPosition,

           open            := r2_1EatingroomBlindsUp,
           close           := r2_1EatingroomBlindsDown,
           stop            := r2_1EatingroomBlindsStop);

      r2_1EatingroomBlindsUp    := false;
      r2_1EatingroomBlindsDown  := false;
      r2_1EatingroomBlindsStop  := false;
  end_if;

  lamp1( trigButton := r2_1EatingroomLight05_06_23,
         //state      => out_Lamp1^
         );

  Auto( //Sensor_Motion.state   := in_MotionSensor^,
        autoMode              := r2_1EatingroomLight05_06_23_auto);

  if Auto.stateChanged then
     Lamp1.setState := Auto.state;
  end_if;
  

END_PROGRAM

