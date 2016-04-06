PROGRAM prgBalconyLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      
      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     init := true;
  end_if;

  lamp1( trigButton := r3_1BalconyLight,
         state      => MODULE2_OUT.DOs.DO4
         );

END_PROGRAM

