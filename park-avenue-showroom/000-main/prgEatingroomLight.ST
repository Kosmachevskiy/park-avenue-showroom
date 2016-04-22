PROGRAM prgEatingroomLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR

      Lamp1               : fbManualRelay;

      Auto3               : fbAutoRelay;
  
  
      buttonUp,
      buttonDown
      (*button*)          : fbButtonProcessor;


      blind               : fbBlindController;

      initTimer           : ton;
      init                : bool;
      
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then

     supervisorAuto03                        := AUTO_MODE_DEFAULT_STATE;
     Auto3.timeAfterMotionDetect             := AUTO_MODE_DEFAULT_TIME;
     Auto3.Sensor_Motion.mode                := NC;
     Auto3.nightMode                         := true;

     blind.timeTo_up_down                   := t#38000ms;

     //MODULE4_OUT.DO3                        := true; //Типа чтобы штора после старта была открыта
     initTimer( IN := true,
                PT := blind.timeTo_up_down);
     if initTimer.Q then
        init := true;
     end_if;
  else


      blind( //up            => MODULE4_OUT.DO3,
             //down          => MODULE4_OUT.DO4,

             position      := r2_1EatingroomBlindsPosition,

             open          := r2_1EatingroomBlindsUp OR buttonUp.shortPress,
             close         := r2_1EatingroomBlindsDown OR buttonDown.shortPress,
             stop          := r2_1EatingroomBlindsStop);

      r2_1EatingroomBlindsUp    := false;
      r2_1EatingroomBlindsDown  := false;
      r2_1EatingroomBlindsStop  := false;
  end_if;



  (*Lamp1*)
  if panel.button[3].shortPress then
     Lamp1.setState := not Lamp1.state;
  end_if;

  lamp1( trigButton := supervisorLight_05,
         state      => light_05
         );

  panel.led[3]:= Lamp1.state;
  
  Auto3(Sensor_Motion.state   := msensor03,
        autoMode              := supervisorAuto03);

  if Auto3.stateChanged then
     Lamp1.setState := Auto3.state;
  end_if;
  
  
END_PROGRAM

