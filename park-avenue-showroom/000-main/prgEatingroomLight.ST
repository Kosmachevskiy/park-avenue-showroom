PROGRAM prgEatingroomLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;

      Auto      : fbAutoRelay;
      
      buttonUp,
      buttonDown,
      button    : fbButtonProcessor;
      
      blind     : fbBlindController;
      
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

     blind.timeTo_up_down                   := t#38000ms;

     MODULE4_OUT.DO3                        := true; //Типа чтобы штора после старта была открыта
     initTimer( IN := true,
                PT := blind.timeTo_up_down);
     if initTimer.Q then
        init := true;
     end_if;
  else
      buttonUp(btn:= MODULE6_IN.DI.DI5);
      buttonDown(btn:= MODULE6_IN.DI.DI6);

      
      blind( up            => MODULE4_OUT.DO3,
             down          => MODULE4_OUT.DO4,

             position      := r2_1EatingroomBlindsPosition,

             open          := r2_1EatingroomBlindsUp OR buttonUp.shortPress,
             close         := r2_1EatingroomBlindsDown OR buttonDown.shortPress,
             stop          := r2_1EatingroomBlindsStop);

      r2_1EatingroomBlindsUp    := false;
      r2_1EatingroomBlindsDown  := false;
      r2_1EatingroomBlindsStop  := false;
  end_if;


  button(btn:= MODULE6_IN.DI.DI7 XOR MODULE6_IN.DI.DI4);
  if button.shortPress then
     lamp1.setState := not lamp1.state;
  end_if;

  lamp1( trigButton := r2_1EatingroomLight05_06_23,
         state      => MODULE2_OUT.DOs.DO11
         );

  Auto( Sensor_Motion.state   := MODULE1_IN.DI2,
        autoMode              := r2_1EatingroomLight05_06_23_auto);

  if Auto.stateChanged then
     Lamp1.setState := Auto.state;
  end_if;
  
  MODULE6_OUT.DOs.DO5 :=  MODULE2_OUT.DOs.DO11;
  MODULE6_OUT.DOs.DO6 :=  MODULE4_OUT.DO3;
  MODULE6_OUT.DOs.DO7 :=  MODULE4_OUT.DO4;
  
END_PROGRAM

