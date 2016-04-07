PROGRAM prgEatingroomLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;

      Auto      : fbAutoRelay;
      
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

     blind.timeTo_up_down                   := t#38s;

     MODULE6_OUT.DOs.DO3                    := true; //Типа чтобы штора после старта была открыта
     initTimer( IN := true,
                PT := blind.timeTo_up_down);
     if initTimer.Q then
        init := true;
     end_if;
  else

  
      blind( up            => MODULE6_OUT.DOs.DO3,
             down          => MODULE6_OUT.DOs.DO4,

             position      := r2_1EatingroomBlindsPosition,

             open          := r2_1EatingroomBlindsUp,
             close         := r2_1EatingroomBlindsDown,
             stop          := r2_1EatingroomBlindsStop);

      r2_1EatingroomBlindsUp    := false;
      r2_1EatingroomBlindsDown  := false;
      r2_1EatingroomBlindsStop  := false;
  end_if;
(*
  button(btn:= adr(MODULE5_AI4.STAT.OVR));
  if button.shortPress then
     lamp1.setState := not lamp1.state;
  end_if;

 TODO: найти куда подключать кнопки на кухне. сейчас оин подключены к несуществующим входам диммера (MODULE3)
*)

  lamp1( trigButton := r2_1EatingroomLight05_06_23,
         state      => MODULE2_OUT.DOs.DO11
         );

  Auto( Sensor_Motion.state   := MODULE1_IN.DI2,
        autoMode              := r2_1EatingroomLight05_06_23_auto);

  if Auto.stateChanged then
     Lamp1.setState := Auto.state;
  end_if;
  

END_PROGRAM

