PROGRAM prgBalconyLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      
      button    : fbButtonProcessor;
      
      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     init := true;
  end_if;
  
  button(btn :=MODULE6_IN.DI.DI8);

  if button.shortPress then
     Lamp1.setState:= not Lamp1.state;
  end_if;

  lamp1( trigButton := r3_1BalconyLight,
         state      => MODULE4_OUT.DO3);

END_PROGRAM

